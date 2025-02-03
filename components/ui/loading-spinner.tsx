import { Icons } from "@/components/icons"

export function LoadingSpinner() {
  return (
    <div className="flex h-screen items-center justify-center">
      <Icons.spinner className="h-8 w-8 animate-spin" />
    </div>
  )
}

