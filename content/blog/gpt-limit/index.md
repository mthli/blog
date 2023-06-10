---
title: GPT App 的问题与局限
date: '2023-06-10T10:40:35+00:00'
description: 数据源更重要 🗂️
---

时间来到 2023 年 6 月，印象中自从 ChatGPT 上线，至少在 Twitter 上出现了两拨热潮。期间我正好从公司离职，感觉可以做些什么。但至今我仍然没有一个正式上线的产品，只是在一次次尝试中感到沮丧。谨以此文做一个阶段性总结。

## 套壳 App

如果说 GPT 热潮分为两个阶段的话，3 月份 [GPT-3.5 API](https://platform.openai.com/docs/api-reference/chat/create) 上线应该是第二波热潮的时间点。印象中在这之前的 App 以官方网页套壳 + [Prompt](https://en.wikipedia.org/wiki/Prompt_engineering) Library 居多；其实现在回头来看，当时 App Store 上应该早已出现了大量的 Chat AI Apps，不得不感慨灰产的强大。

API 的出现当然解放了大量生产力，加上官方网页的体验不佳、缺少客户端等等，时间线上越来越多的独立开发者们入场了，我也不例外。我花了两周多的时间写了一个 [Android App](https://twitter.com/mth_li/status/1639174596451766272?s=20)，加上了系统 TTS 语音功能，并简单发布了一个测试版本。

<div class="certer-small-image">
    <img src="/newboy.png" alt="推文截图">
</div>

熟悉 GPT 模型的读者们都知道，GPT-3.5 有 4096 tokens 的限制，而 GPT-4 有 8k 和 32k 两个版本。Token 数量决定了聊天过程中可以携带多少上下文，为了满足这个滑动窗口你只能不断地丢弃老的聊天记录来产生新的聊天记录，否则 API 就会报错。而请求发出之后再报错是很糟糕的体验，所以其实两周里大部分时间我都在适配官方计算 token 数量的库 tiktoken 并将其开源 [mthli/tiktoken-android](https://github.com/mthli/tiktoken-android)。

不幸的是，这个 App 在 Google Play 上架审核中被拒了，原因是 tiktoken 初始化过程中需要下载映射文件，但是审核人员的网络下载失败，所以被认为阻塞了用户体验（In-app experience）。咳咳，竟然有点黑色幽默？

虽然我可以修复后再上架，比如把映射文件内置到 App 里，但是最终我还是没有继续下去。原因是在开发 App 的过程中，我并没有感受到有多少成就感，或者说作品感、创造感？即使我在推文里说「结合 Android 的开放也许能做出一些不一样的玩法」，但当时并没有什么好的持续下去的想法。

也许我应该 build in public？也许当时修复上架了先看看用户反馈会不一样？我不知道。而且大家都做套壳想分一杯羹，我甚至觉得这是一种 [刻奇（kitsch）](https://zh.wikipedia.org/wiki/%E5%AA%9A%E4%BF%97)。

当然做套壳还是有一些意义的，那就是先耍起来，毕竟 GPT 对于大家来说都是新鲜玩意儿，极限在哪还不知道。但我还是想做一些非常有原创性的、个人烙印的产品。

## 问答 App

另一大类是问答 App，比如 [Chatbase](https://www.chatbase.co/) 和 [ChatPDF](https://www.chatpdf.com/)。

我也构想了一个场景，叫做 Chat Bookmark。因为我的浏览器书签实在太多了，但 Chrome 只能检索书签标题和链接，如果有插件能检索书签内容岂不美哉？而且书签内容就是个人知识库，天然适合 GPT + [Embeddings](https://platform.openai.com/docs/guides/embeddings) 场景。但是当我尝试把给所有书签建立向量时才发现，不是所有链接都可以被简单爬取的，有的链接要登录、有的链接需要 DOM 渲染（React）… 所以这个想法也破产了。

既然谈到了知识库，这就不得不提一些逻辑悖论。网上经常有人分享自己制作的某个领域的 GPT 问答 App，但其实你点开以后并不一定知道该问什么；回答的问题也难以求证数据来源，甚至不知道对不对。前者在提问前需要一些上下文背景；后者则需要给予使用者足够的数据源索引，类似 [New Bing](https://www.bing.com/new)，不幸的是大部分问答产品都没有提供索引功能。

<div class="certer-small-image">
    <img src="/paradox.png" alt="逻辑悖论">
</div>

这里简单讲讲为什么 GPT + Embeddings 回答的问题不一定准确。一般的流程是：

1. 先将数据源的文本语义转换为向量 `a`
2. 再将提问的语义转换为向量 `b`
3. 计算 `cosine(a, b)` 找出最相似（匹配）的数据 `s`
4. 将 `s` 发送给 GPT 做语义化前端处理

首先容易出问题的当然就是数据源，质量不高的数据源即使再相似，也会觉得答非所问。其次建立向量时通常涉及到文本切割，因为最后 GPT 处理时有 token 限制。不同的数据源有不同的做法，按句子还是按段落？按句子可能会匹配出一些向量上很相似但实则分布在文章各个段落的句子，上下文是割裂的；按段落携带的上下文是否又有点少（最相似的段落不一定能回答问题）？最后 GPT 也只是作为一个语义化前端，回答的质量还是取决于喂给它的数据。

以前使用搜索引擎是输入、点击、总结，现在使用问答 App 却变成输入、总结、求证。如果不是对数据源非常信任，问答模式反而更耗费精力了，甚至有点多此一举？

## 还有什么

其实 GPT 也有一些不错的场景，比如随意聊天、翻译、定制 prompt 的总结以及 [Notion AI](https://www.notion.so/product/ai) 等等；[AutoGPT](https://github.com/Significant-Gravitas/Auto-GPT) 也挺有意思。但是在这之上似乎我也没发掘出什么特别的。

面向 GPT 编程是一种有趣的体验，因为这是在面向不确定性编程。但是大部分 GPT Apps 的工作量我相信并不在与 GPT 交互上，而是集中在数据处理等方面（比如写爬虫），GPT 只是作为与用户交互的语义化前端。当然也可以使用 GPT 处理一些数据，比较慢就是了。

经过三个月的折腾和一无所获，我已经对构建 GPT App 祛魅了（know how），并且感到沮丧。也许我是一个失败的独立开发者，应该继续找一家公司上班。
