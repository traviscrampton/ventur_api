class EditorBlobsController < ApplicationController
  require 'yajl'

  before_action :check_current_user, except: [:show]
  before_action :editor_blob
  before_action :validate_editor_blob_owner, except: [:show]

  # this action only returns the draft content
  def show
    render 'editor_blobs/show.json',
           locals: { id: editor_blob.id, content: editor_blob.draft_content }
  end

  def update
    updated_blob = EditorBlobEditor.new(editor_blob, editor_params, params[:files]).call

    if updated_blob.valid?
      render 'editor_blobs/show.json',
             locals: { id: updated_blob.id,
                       content: updated_blob.draft_content }
    else
      render json: { errors: updated_blob.errors.full_messages }, status: 422
    end
  end

  def update_draft_to_final
    purge_images
    draft_content = editor_blob.draft_content
    editor_blob.update(final_content: draft_content)

    render 'editor_blobs/show.json',
           locals: { id: editor_blob.id, content: editor_blob.final_content }
  end

  def update_final_to_draft
    final_to_draft

    render 'editor_blobs/show.json',
           locals: { id: editor_blob.id, content: editor_blob.draft_content }
  end

  def update_blob_done
    updated_blob = EditorBlobEditor.new(editor_blob, editor_params, params[:files]).call

    if updated_blob.valid?
      purge_images
      draft_content = updated_blob.draft_content
      editor_blob.update(final_content: draft_content)

      render 'editor_blobs/show.json',
           locals: { id: editor_blob.id, content: editor_blob.final_content }
    else
      render json: { errors: updated_blob.errors.full_messages }, status: 422
    end
  end

  def destroy
    purge_images
    final_to_draft

    render 'editor_blobs/show.json',
           locals: { id: editor_blob.id, content: editor_blob.final_content }
  end

  private

  def editor_blob
    @editor_blob ||= EditorBlob.find(params[:id])
  end

  def purge_images
    return unless params[:deletedIds]
    
    parser = Yajl::Parser.new
    deleted_ids = parser.parse(params[:deletedIds])

    deleted_ids.each { |id| 
      if editor_blob.images.find(id)
        editor_blob.images.find(id).purge_later
      end
    }
  end

  def final_to_draft
    final_content = editor_blob.final_content
    editor_blob.update(draft_content: final_content)
  end

  def validate_editor_blob_owner
    return if current_user.id == editor_blob.blobable.user.id

    return_unauthorized_error
  end

  def editor_params
    params.permit(:deletedIds, :content)
  end
end
