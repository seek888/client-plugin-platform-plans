import { formatMonthLabel, t } from '../../i18n.js';
import { text } from '../tokens.js';

export function header(year, month) {
  return {
    type: 'card',
    style: { margin: '0,0,12,0' },
    children: [
      {
        type: 'row',
        children: [
          {
            type: 'expanded',
            children: [text(t('plugin.name'), 22, '#111827', '700')]
          },
          {
            type: 'button',
            props: { text: t('language.switch') },
            style: { margin: '0,6,0,0' },
            events: { onTap: 'handleToggleLocale' }
          },
          {
            type: 'iconButton',
            props: { icon: 'Icons.today' },
            events: { onTap: 'handleGoToday' }
          },
          {
            type: 'iconButton',
            props: { icon: 'Icons.event' },
            events: { onTap: 'handleCreateEvent' }
          }
        ]
      },
      {
        type: 'row',
        children: [
          {
            type: 'iconButton',
            props: { icon: 'Icons.chevron_left' },
            events: { onTap: 'handlePreviousMonth' }
          },
          {
            type: 'expanded',
            children: [
              text(formatMonthLabel(year, month), 18, '#1F2937', '700', 'center')
            ]
          },
          {
            type: 'iconButton',
            props: { icon: 'Icons.chevron_right' },
            events: { onTap: 'handleNextMonth' }
          }
        ]
      }
    ]
  };
}
