import React from 'react'
import { Link } from 'gatsby'

import ThemeSwitch from './themeSwitch'
import { rhythm } from '../utils/typography'

const Layout = ({ title, children }) => {
  const header = (
    <>
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
      <ThemeSwitch />
    </>
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
      <footer>
        <div
          style={{
            display: 'flex',
            flexWrap: 'wrap',
            justifyContent: 'space-between',
          }}
        >
          <div>
            ©
            {' '}
            {new Date().getFullYear()}
            , built with
            {' '}
            <a target="_blank" rel="noopener noreferrer" href="https://www.gatsbyjs.org">Gatsby</a>
          </div>
          <div>
            <a target="_blank" rel="noopener noreferrer" href="https://github.com/mthli">GitHub</a>
            {' • '}
            <a target="_blank" rel="noopener noreferrer" href="https://twitter.com/mth_li">Twitter</a>
            {' • '}
            <a target="_blank" rel="noopener noreferrer" href="https://www.instagram.com/mth_li">Instagram</a>
            {' • '}
            <a target="_blank" rel="noopener noreferrer" href="https://mthli.xyz/rss.xml">RSS</a>
          </div>
        </div>
      </footer>
    </div>
  )
}

export default Layout
