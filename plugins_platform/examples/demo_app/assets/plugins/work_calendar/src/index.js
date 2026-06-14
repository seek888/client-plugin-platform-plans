import { ensureCalendarData } from './state/calendar_state.js';
import { renderCalendarPage } from './ui/pages/calendar_page.js';
import { renderTodayCard } from './ui/cards/today_card.js';
export {
  handleCreateEvent,
  handleDateClick,
  handleEventDetail,
  handleFilter,
  handleGoToday,
  handleNextMonth,
  handlePreviousMonth
} from './controllers/calendar_handlers.js';

export function onActivate() {
  ensureCalendarData();
}

export function onDeactivate() {}

export function renderPage(route) {
  ensureCalendarData();
  return renderCalendarPage(route);
}

export function renderCard(context) {
  ensureCalendarData();
  return renderTodayCard(context);
}
