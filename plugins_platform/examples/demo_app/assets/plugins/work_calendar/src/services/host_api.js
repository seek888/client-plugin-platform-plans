export function showToast(message) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  return invokeHost('toast.show', { message });
}
