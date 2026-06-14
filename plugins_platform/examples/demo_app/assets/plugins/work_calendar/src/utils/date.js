export function parseDate(value) {
  const parts = value.split('-').map(part => Number(part));
  return new Date(parts[0], parts[1] - 1, parts[2]);
}

export function formatDate(date) {
  return date.getFullYear() + '-' +
    String(date.getMonth() + 1).padStart(2, '0') + '-' +
    String(date.getDate()).padStart(2, '0');
}

export function formatTime(date) {
  return String(date.getHours()).padStart(2, '0') + ':' +
    String(date.getMinutes()).padStart(2, '0');
}

export function sameDay(left, right) {
  return formatDate(left) === formatDate(right);
}
