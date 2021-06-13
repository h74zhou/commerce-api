module ExecutionErrorResponder
  extend ActiveSupport::Concern

  private

  def execution_error(message: nil, status: :unprocessable_entity, code: 442)
    GraphQL::ExecutionError.new(message, options: {status: status, code: code })
  end
end