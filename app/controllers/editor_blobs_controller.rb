class EditorBlobsController < ApplicationController
  before_action :check_current_user, except: [:show]
  before_action :editor_blob
  before_action :validate_editor_blob_owner, except: [:show]

  # this action only returns the draft content
  def show
    render 'editor_blobs/show.json',
           locals: { id: editor_blob.id, content: editor_blob.draft_content }
  end

  def update
    updated_blob = EditorBlobEditor.new(editor_blob, editor_params).call

    if updated_blob.valid?
      render 'editor_blobs/show.json',
             locals: { id: updated_blob.id,
                       content: updated_blob.draft_content }
    else
      render json: { errors: updated_blob.errors.full_messages }, status: 422
    end
  end

  def update_to_final_content
    draft_content = editor_blob.draft_content
    editor_blob.update(final_content: draft_content)

    render 'editor_blobs/show.json',
           locals: { id: editor_blob.id, content: editor_blob.final_content }
  end

  def destroy
    # there will need to be something in this method that deletes the old images
    final_content = editor_blob.final_content
    editor_blob.update(draft_content: final_content)

    render 'editor_blobs/show.json',
           locals: { id: editor_blob.id, content: editor_blob.final_content }
  end

  private

  def editor_blob
    @editor_blob ||= EditorBlob.find(params[:id])
  end

  def validate_editor_blob_owner
    return if current_user.id == editor_blob.blobable.user.id

    return_unauthorized_error
  end

  def editor_params
    params.permit(:newImages, :deletedIds, :draft_content)
  end
end