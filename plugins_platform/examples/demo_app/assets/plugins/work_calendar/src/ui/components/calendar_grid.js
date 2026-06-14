import { calendarState } from '../../state/calendar_state.js';
import { getEventsForDate } from '../../services/calendar_service.js';
import { formatDate, sameDay } from '../../utils/date.js';
import { text } from '../tokens.js';

export function weekdayHeader() {
  const names = ['日', '一', '二', '三', '四', '五', '六'];
  return {
    type: 'row',
    children: names.map(name => ({
      type: 'expanded',
      children: [text(name, 12, '#6B7280', '600', 'center')]
    }))
  };
}

export function generateCalendarGrid() {
  const year = calendarState.currentDate.getFullYear();
  const month = calendarState.currentDate.getMonth();
  const firstDay = new Date(year, month, 1);
  const totalDays = new Date(year, month + 1, 0).getDate();
  const grid = [];

  for (let i = 0; i < firstDay.getDay(); i++) {
    grid.push(emptyCell());
  }

  for (let day = 1; day <= totalDays; day++) {
    const date = new Date(year, month, day);
    grid.push(dayCell(date));
  }

  while (grid.length % 7 !== 0) {
    grid.push(emptyCell());
  }

  return grid;
}

function emptyCell() {
  return {
    type: 'container',
    style: { backgroundColor: '#F9FAFB', borderRadius: 8 }
  };
}

function dayCell(date) {
  const events = getEventsForDate(calendarState.events, date);
  const isToday = sameDay(date, new Date());
  const selected = sameDay(date, calendarState.selectedDate);
  const color = selected ? '#DBEAFE' : (isToday ? '#EFF6FF' : '#FFFFFF');

  return {
    type: 'container',
    props: { date: formatDate(date) },
    style: {
      backgroundColor: color,
      borderRadius: 8,
      padding: '6,4,6,4'
    },
    events: { onTap: 'handleDateClick' },
    children: [
      text(String(date.getDate()), 13, selected ? '#1D4ED8' : '#111827', selected ? '700' : '500', 'center'),
      ...events.slice(0, 2).map(eventDot),
      events.length > 2 ? text('+' + (events.length - 2), 10, '#6B7280', '500', 'center') : text('', 10, '#6B7280', '400', 'center')
    ]
  };
}

function eventDot(evt) {
  const category = calendarState.categories[evt.type] || calendarState.categories.task;
  return {
    type: 'container',
    style: {
      backgroundColor: category.color,
      borderRadius: 4,
      padding: '2,2,2,2',
      margin: '2,0,0,0'
    },
    children: [
      text(evt.title, 9, '#FFFFFF', '500', 'center')
    ]
  };
}
