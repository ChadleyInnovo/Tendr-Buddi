export class AppError extends Error {
  public statusCode: number
  public code: string

  constructor(message: string, statusCode = 500, code = "INTERNAL_ERROR") {
    super(message)
    this.statusCode = statusCode
    this.code = code
    Error.captureStackTrace(this, this.constructor)
  }
}

export const handleError = (error: unknown) => {
  if (error instanceof AppError) {
    return {
      message: error.message,
      statusCode: error.statusCode,
      code: error.code,
    }
  }

  console.error("Unhandled error:", error)

  return {
    message: "An unexpected error occurred",
    statusCode: 500,
    code: "INTERNAL_ERROR",
  }
}

