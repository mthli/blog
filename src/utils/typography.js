import Typography from 'typography'
import Wordpress2016 from 'typography-theme-wordpress-2016'

Wordpress2016.overrideThemeStyles = () => {
  return {
    'header h1, header h2, header h3, header h4, header h5, header h6': {
      fontFamily: ['Montserrat', 'sans-serif'].join(','),
    },
    'a': {
      color: 'var(--link-color)',
    },
    'a.gatsby-resp-image-link': {
      boxShadow: 'none',
    },
    'hr': {
      background: 'var(--hr-color)',
    }
  }
}

delete Wordpress2016.googleFonts

const typography = new Typography(Wordpress2016)

// Hot reload typography in development.
if (process.env.NODE_ENV !== 'production') {
  typography.injectStyles()
}

export default typography
export const rhythm = typography.rhythm
export const scale = typography.scale
