import { formatDate } from '../utils/date.js';

export function createEvent(id, title, type, y, m, d, sh, sm, eh, em, location, attendees) {
  return {
    id,
    title,
    type,
    startTime: new Date(y, m, d, sh, sm, 0).toISOString(),
    endTime: new Date(y, m, d, eh, em, 0).toISOString(),
    location,
    attendees
  };
}

export function getEventsForDate(events, date) {
  const key = formatDate(date);
  return events.filter(evt => evt.startTime.substring(0, 10) === key);
}

export function countWeekTasks(events) {
  const today = new Date();
  const start = new Date(today.getFullYear(), today.getMonth(), today.getDate() - today.getDay());
  const end = new Date(start.getFullYear(), start.getMonth(), start.getDate() + 7);
  return events.filter(evt => {
    const date = new Date(evt.startTime);
    return date >= start && date < end && evt.type === 'task';
  }).length;
}

export function meetingHoursForDate(events, date) {
  return getEventsForDate(events, date)
    .filter(evt => evt.type === 'meeting')
    .reduce((sum, evt) => {
      return sum + (new Date(evt.endTime) - new Date(evt.startTime)) / 3600000;
    }, 0);
}
