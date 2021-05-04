import React from 'react'
import Helmet from 'react-helmet'
import PropTypes from 'prop-types'
import { useStaticQuery, graphql } from 'gatsby'

const SEO = ({
  description, lang, meta, title,
}) => {
  const { site } = useStaticQuery(
    graphql`
      query {
        site {
          siteMetadata {
            title
            description
            author
          }
        }
      }
    `,
  )

  const metaDescription = description || site.siteMetadata.description

  return (
    <Helmet
      htmlAttributes={{
        lang,
      }}
      title={title}
      // titleTemplate={`%s | ${site.siteMetadata.title}`}
      meta={[
        {
          name: 'description',
          content: metaDescription,
        },
        {
          property: 'og:type',
          content: 'website',
        },
        {
          property: 'og:title',
          content: title,
        },
        {
          property: 'og:description',
          content: metaDescription,
        },
        {
          name: 'twitter:card',
          content: 'summary',
        },
        {
          name: 'twitter:creator',
          content: 'mth_li',
        },
        {
          name: 'twitter:title',
          content: title,
        },
        {
          name: 'twitter:description',
          content: metaDescription,
        },
        {
          name: 'google-site-verification',
          content: 'M3XhpmAR-H4xgeNwBx6S-N4mQ4gRV2rVJSTIt5f3Rik',
        },
        {
          name: 'bytedance-verification-code',
          content: 'PUUxPokYUa0OgcOrEhMH',
        },
      ].concat(meta)}
    >
      <script>
        {`
          (function(){
            var el = document.createElement("script");
            el.src = "https://sf1-scmcdn-tos.pstatp.com/goofy/ttzz/push.js?6db04ad159d9ef9110fef3ad85973cffefae865430610d6a4e89b0ecab29f20292e485e55ded9865c1d60bbc5ada8e9a66b90adfc91df36816b5de84c32487fc";
            el.id = "ttzz";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(el, s);
          })(window)
        `}
      </script>
    </Helmet>
  )
}

SEO.defaultProps = {
  lang: 'zh',
  meta: [],
  description: '',
}

SEO.propTypes = {
  description: PropTypes.string,
  lang: PropTypes.string,
  meta: PropTypes.arrayOf(PropTypes.object),
  title: PropTypes.string.isRequired,
}

export default SEO
