/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
import Rails from "rails-ujs";
require("turbolinks").start()
require("bootstrap")

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
const application = Application.start()
const context = require.context("../controllers", true, /\.js$/);

application.load(definitionsFromContext(context));
Rails.start();

// $(document).ready(function () {
//   $('.message .close')
//     .on('click', function () {
//       $(this)
//         .closest('.message')
//         .transition('fade');
//     });
// });

// $(document).on('turbolinks:load', function () {
//   alert('hello')
//   $('.ui.dropdown')
//     .dropdown();

//   $("#condition_select").on('change', function (e) {
//     var params = new URLSearchParams(location.search)
//     params.set("condition", e.target.selectedOptions[0].value)
//     location.search = params.toString();
//   });

//   $("#category_select").on('change', function (e) {
//     var params = new URLSearchParams(location.search)
//     params.set("category", e.target.selectedOptions[0].value)
//     location.search = params.toString();
//   });
// });
