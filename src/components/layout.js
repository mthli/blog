import React from "react"
import { Link } from "gatsby"

import { rhythm } from "../utils/typography"

const Layout = ({ title, children }) => {
  const header = (
    <h3
      style={{
        fontFamily: `Montserrat, sans-serif`,
        marginTop: 0,
      }}
    >
      <Link
        style={{
          boxShadow: `none`,
          textDecoration: `none`,
          color: `inherit`,
        }}
        to={`/`}
      >
        {title}
      </Link>
    </h3>
  )

  return (
    <div
      style={{
        marginLeft: `auto`,
        marginRight: `auto`,
        maxWidth: rhythm(24),
        padding: `${rhythm(1.5)} ${rhythm(3 / 4)}`,
      }}
    >
      <header>{header}</header>
      <main>{children}</main>
      <footer>
        <div
          style={{
            display: `flex`,
            flexWrap: `wrap`,
            justifyContent: `space-between`,
          }}
        >
          <div>
            © {new Date().getFullYear()}, built with
            {` `}
            <a target="_blank" rel="noopener noreferrer" href="https://www.gatsbyjs.org">Gatsby</a>
          </div>
          <div>
            <a target="_blank" rel="noopener noreferrer" href="https://github.com/mthli">GitHub</a>
            {` • `}
            <a target="_blank" rel="noopener noreferrer" href="https://twitter.com/mth_li">Twitter</a>
            {` • `}
            <a target="_blank" rel="noopener noreferrer" href="https://www.instagram.com/mth_li">Instagram</a>
            {` • `}
            <a target="_blank" rel="noopener noreferrer" href="https://mthli.xyz/rss.xml">RSS</a>
          </div>
        </div>
      </footer>
    </div>
  )
}

export default Layout
