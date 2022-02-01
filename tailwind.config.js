module.exports = {
    content: [
        './app/views/**/*.html.erb',
        './app/views/**/*.js.erb',
        './app/helpers/**/*.rb',
        './app/javascript/**/*.js'
    ],
    plugins: [
        require('postcss-import'),
        require('postcss-flexbugs-fixes'),
        require("tailwindcss"),
        require('postcss-preset-env')({
            autoprefixer: {
                flexbox: 'no-2009'
            },
            stage: 3
        })
    ]
}
