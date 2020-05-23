import React from 'react'

import Layout from '../components/layout'
import SEO from '../components/seo'

const NotFoundPage = () => (
  <Layout>
    <SEO title="404" />
    <h1>404</h1>
    <p>
      这里什么也没有，哈哈
      {' '}
      <span aria-label="smile" role="img">😄</span>
    </p>
  </Layout>
)

export default NotFoundPage
