import React from 'react'

import Bio from './bio'
import { rhythm } from '../utils/typography'

const Layout = ({ children }) => {
  return (
    <div
      style={{
        marginLeft: 'auto',
        marginRight: 'auto',
        maxWidth: rhythm(26),
        padding: `${rhythm(2)} ${rhythm(3 / 4)}`,
      }}
    >
      <Bio />
      <main>{children}</main>
    </div>
  )
}

export default Layout
