import Typography from 'typography'
import Wordpress2015 from 'typography-theme-wordpress-2015'

Wordpress2015.overrideThemeStyles = () => ({
  a: {
    color: 'var(--link-color)',
  },
  'a.gatsby-resp-image-link': {
    boxShadow: 'none',
  },
})

const typography = new Typography(Wordpress2015)

// Hot reload typography in development.
if (process.env.NODE_ENV !== 'production') {
  typography.injectStyles()
}

export default typography
export const { rhythm } = typography
export const { scale } = typography
