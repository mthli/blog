import React from 'react'
import { Link } from 'gatsby'

import { rhythm } from '../utils/typography'

const Layout = ({ title, children }) => {
  const header = (
    <h3
      style={{
        fontFamily: 'Montserrat, sans-serif',
        marginTop: 0,
      }}
    >
      <Link
        style={{
          boxShadow: 'none',
          textDecoration: 'none',
          color: 'inherit',
        }}
        to="/"
      >
        {title}
      </Link>
    </h3>
  )

  return (
    <div
      style={{
        marginLeft: 'auto',
        marginRight: 'auto',
        maxWidth: rhythm(26),
        padding: `${rhythm(1.5)} ${rhythm(3 / 4)}`,
      }}
    >
      <header
        style={{
          display: 'flex',
          justifyContent: 'space-between',
        }}
      >
        {header}
      </header>
      <main>{children}</main>
    </div>
  )
}

export default Layout
