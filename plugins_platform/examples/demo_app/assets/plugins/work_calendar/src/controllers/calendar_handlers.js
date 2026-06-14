import { calendarState } from '../state/calendar_state.js';
import { showToast } from '../services/host_api.js';
import { parseDate } from '../utils/date.js';
import { renderCalendarPage } from '../ui/pages/calendar_page.js';

export function handleGoToday() {
  calendarState.currentDate = new Date();
  calendarState.selectedDate = new Date();
  return fullUpdate();
}

export function handlePreviousMonth() {
  calendarState.currentDate = new Date(
    calendarState.currentDate.getFullYear(),
    calendarState.currentDate.getMonth() - 1,
    1
  );
  calendarState.selectedDate = new Date(calendarState.currentDate);
  return fullUpdate();
}

export function handleNextMonth() {
  calendarState.currentDate = new Date(
    calendarState.currentDate.getFullYear(),
    calendarState.currentDate.getMonth() + 1,
    1
  );
  calendarState.selectedDate = new Date(calendarState.currentDate);
  return fullUpdate();
}

export function handleDateClick(state) {
  const date = state && state.props ? state.props.date : null;
  if (date) {
    calendarState.selectedDate = parseDate(date);
  }
  return fullUpdate();
}

export function handleCreateEvent() {
  const base = calendarState.selectedDate || new Date();
  const id = 'evt_' + (calendarState.events.length + 1);
  calendarState.events.push({
    id,
    title: '新建跟进事项',
    type: 'task',
    startTime: new Date(base.getFullYear(), base.getMonth(), base.getDate(), 17, 0, 0).toISOString(),
    endTime: new Date(base.getFullYear(), base.getMonth(), base.getDate(), 18, 0, 0).toISOString(),
    location: '待确认',
    attendees: ['我'],
    notes: '从插件快速创建的临时事项'
  });
  showToast('已创建新日程');
  return fullUpdate();
}

export function handleFilter() {
  return fullUpdate();
}

export function handleEventDetail() {
  return fullUpdate();
}

function fullUpdate() {
  return {
    type: 'full',
    schema: renderCalendarPage()
  };
}
