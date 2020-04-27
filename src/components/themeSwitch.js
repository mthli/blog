import React from 'react'
import { ThemeToggler } from 'gatsby-plugin-dark-mode'

const ThemeSwitch = () => (
  <ThemeToggler>
    {({ theme, toggleTheme }) => (
        <label className="dayNight">
          <input
            type="checkbox"
            checked={theme === 'dark'}
            onChange={e => toggleTheme(e.target.checked ? 'dark' : 'light')}
          />
          <div></div>
          <style jsx>
            {`
              .dayNight {
                margin-top: -8px;
                margin-right: -8px;
                cursor: pointer;
                transform: scale(0.5);
              }
              .dayNight input {
                display: none;
              }
              .dayNight input + div {
                position: relative;
                border-radius: 50%;
                box-shadow: inset 16px -16px 0 0 var(--text-color);
                width: 36px;
                height: 36px;
                transform: scale(1) rotate(-2deg);
                transition: box-shadow 0.5s ease 0s, transform 0.4s ease 0.1s;
              }
              .dayNight input + div:before {
                position: absolute;
                top: 0;
                left: 0;
                border-radius: inherit;
                width: inherit;
                height: inherit;
                content: '';
                transition: background 0.3s ease;
              }
              .dayNight input + div:after {
                position: absolute;
                top: 50%;
                left: 50%;
                width: 8px;
                height: 8px;
                border-radius: 50%;
                margin: -4px 0 0 -4px;
                box-shadow:
                  0 -23px 0 var(--text-color),
                  0  23px 0 var(--text-color),
                   23px 0 0 var(--text-color),
                  -23px 0 0 var(--text-color),
                    15px 15px 0 var(--text-color),
                   -15px 15px 0 var(--text-color),
                   15px -15px 0 var(--text-color),
                  -15px -15px 0 var(--text-color);
                content: '';
                transform: scale(0);
                transition: all 0.3s ease;
              }
              .dayNight input:checked + div {
                box-shadow: inset 32px -32px 0 0 var(--text-color);
                transform: scale(0.5) rotate(0deg);
                transition: transform 0.3s ease 0.1s, box-shadow 0.2s ease 0s;
              }
              .dayNight input:checked + div:before {
                background: var(--text-color);
                transition: background 0.3s ease 0.1s;
              }
              .dayNight input:checked + div:after {
                transform: scale(1.5);
                transition: transform 0.5s ease 0.15s;
              }
            `}
          </style>
        </label>
    )}
  </ThemeToggler>
)

export default ThemeSwitch
