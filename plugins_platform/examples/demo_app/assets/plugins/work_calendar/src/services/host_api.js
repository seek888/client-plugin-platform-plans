export function showToast(message) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  return invokeHost('toast.show', { message });
}

export function pickContacts(selectedIds) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  return invokeHost('org.contacts.pick', {
    multiple: true,
    selectedIds: selectedIds || []
  });
}

export function sendNotification(title, body, payload) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  return invokeHost('notification.send', {
    title,
    body,
    payload: payload || {}
  });
}

export function submitApproval(payload) {
  if (typeof invokeHost !== 'function') {
    return null;
  }
  return invokeHost('approval.submit', payload || {});
}
