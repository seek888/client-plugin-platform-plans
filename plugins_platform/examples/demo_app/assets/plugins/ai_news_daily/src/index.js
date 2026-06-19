const FEED_KEY = 'ai-news';
const FEED_TITLE = 'AI 资讯快报';
const FEED_DESCRIPTION = '提供 AI、大模型等领域的最新资讯。';
const API_URL = 'https://60s.viki.moe/v2/ai-news';
const PAGE_SIZE = 20;

export function onActivate() {}

export function onDeactivate() {}

export function renderPage() {
  return {
    schemaVersion: '1.0',
    type: 'page',
    title: FEED_TITLE,
    layout: {
      type: 'column',
      padding: '16,16,16,16',
      scrollable: true,
      crossAxisAlignment: 'stretch'
    },
    children: [
      {
        type: 'card',
        children: [
          text(FEED_TITLE, 22, '#111827', '700'),
          text(FEED_DESCRIPTION, 14, '#4B5563', '400'),
          text('插件已启用后会作为 RSS 订阅源提供 AI、大模型领域的日更资讯。', 14, '#4B5563', '400')
        ]
      },
      {
        type: 'card',
        style: { margin: '12,0,0,0' },
        children: [
          text('订阅源信息', 16, '#111827', '700'),
          text('Feed Key: ' + FEED_KEY, 13, '#6B7280', '400'),
          text('API: ' + API_URL, 13, '#6B7280', '400'),
          text('每次刷新最多加载 ' + PAGE_SIZE + ' 条内容。', 13, '#6B7280', '400')
        ]
      },
      {
        type: 'card',
        style: { margin: '12,0,0,0' },
        children: [
          text('使用方式', 16, '#111827', '700'),
          text('激活插件后，回到订阅源列表刷新，宿主会通过 rss.feed.provider 能力发现并加载该订阅源。', 13, '#4B5563', '400')
        ]
      }
    ]
  };
}

export function discoverFeeds() {
  return {
    feeds: [
      {
        feedKey: FEED_KEY,
        provider: 'rss.feed.provider',
        title: FEED_TITLE,
        description: FEED_DESCRIPTION,
        iconUrl: 'https://ai-bot.cn/favicon.ico',
        link: 'https://ai-bot.cn/daily-ai-news'
      }
    ]
  };
}

export function getFeedInfo() {
  return {
    feedKey: FEED_KEY,
    title: FEED_TITLE,
    description: FEED_DESCRIPTION,
    iconUrl: 'https://ai-bot.cn/favicon.ico',
    link: 'https://ai-bot.cn/daily-ai-news',
    lastUpdated: new Date().toISOString()
  };
}

export async function refresh(params) {
  const pageSize = Number(params && params.pageSize) || PAGE_SIZE;
  const firstDate = normalizeDate(params && (params.date || params.since)) || today();
  console.log('[ai_news_daily] refresh params=', JSON.stringify(params || {}));
  return fetchDateWindow(firstDate, pageSize);
}

export async function loadMore(params) {
  const pageSize = Number(params && params.pageSize) || PAGE_SIZE;
  const nextCursor = normalizeDate(params && (params.nextCursor || params.date || params.since));
  console.log('[ai_news_daily] loadMore params=', JSON.stringify(params || {}));
  const startDate = nextCursor || addDays(today(), -1);
  return fetchDateWindow(startDate, pageSize);
}

export async function getArticleDetail(params) {
  const articleId = params && params.articleId ? String(params.articleId) : '';
  const date = articleId.split(':')[1] || today();
  const result = await fetchNewsByDate(date);
  const articles = mapArticles(result.news || [], result.date || date);
  return articles.find((item) => item.guid === articleId) || articles[0] || {};
}

async function fetchDateWindow(startDate, pageSize) {
  console.log('[ai_news_daily] fetchDateWindow start=', startDate, 'pageSize=', pageSize);
  const articles = [];
  let cursor = startDate;
  let attempts = 0;

  while (articles.length < pageSize && attempts < 14) {
    const result = await fetchNewsByDate(cursor);
    articles.push(...mapArticles(result.news || [], result.date || cursor));
    cursor = addDays(cursor, -1);
    attempts += 1;
  }

  const pageArticles = articles.slice(0, pageSize);
  return {
    articles: pageArticles,
    hasMore: true,
    nextCursor: cursor,
    totalCount: pageArticles.length
  };
}

async function fetchNewsByDate(date) {
  console.log('[ai_news_daily] fetchNewsByDate date=', date);
  const response = await invokeHost('network.request', {
    method: 'GET',
    url: API_URL,
    query: {
      date,
      encoding: 'json'
    },
    headers: {
      Accept: 'application/json'
    }
  });

  if (!response || response.success !== true) {
    console.log('[ai_news_daily] network.request failed=', JSON.stringify(response || {}));
    throw new Error((response && response.error) || 'Network request failed');
  }

  const data = response.data || {};
  if (data.statusCode && (data.statusCode < 200 || data.statusCode >= 300)) {
    throw new Error('AI news API returned ' + data.statusCode);
  }

  const payload = data.json || {};
  if (payload.code && Number(payload.code) !== 200) {
    console.log('[ai_news_daily] api payload error=', JSON.stringify(payload));
    throw new Error(payload.message || 'AI news API returned an error');
  }

  console.log(
    '[ai_news_daily] fetchNewsByDate ok date=',
    date,
    'newsCount=',
    Array.isArray(payload.data && payload.data.news) ? payload.data.news.length : 0,
  );
  return payload.data || { date, news: [] };
}

function mapArticles(news, date) {
  return news.map((item, index) => {
    const title = String(item.title || 'AI 资讯');
    const link = String(item.link || '');
    const publishedDate = normalizeDate(item.date) || date;
    return {
      guid: `ai-news:${publishedDate}:${stableHash(title + link)}`,
      title,
      summary: String(item.detail || ''),
      content: String(item.detail || ''),
      author: String(item.source || 'AI 资讯快报'),
      link,
      publishedAt: `${publishedDate}T00:00:00.000Z`,
      categories: ['AI资讯']
    };
  });
}

function today() {
  return new Date().toISOString().slice(0, 10);
}

function normalizeDate(value) {
  if (!value) return '';
  const text = String(value);
  return /^\d{4}-\d{2}-\d{2}$/.test(text) ? text : '';
}

function addDays(dateText, days) {
  const date = new Date(`${dateText}T00:00:00.000Z`);
  date.setUTCDate(date.getUTCDate() + days);
  return date.toISOString().slice(0, 10);
}

function stableHash(input) {
  let hash = 0;
  for (let i = 0; i < input.length; i += 1) {
    hash = ((hash << 5) - hash + input.charCodeAt(i)) | 0;
  }
  return Math.abs(hash).toString(36);
}

function text(value, size, color, weight) {
  return {
    type: 'text',
    props: { text: value },
    style: {
      fontSize: size,
      color,
      fontWeight: weight || '400'
    }
  };
}
