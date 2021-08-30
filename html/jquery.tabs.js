/*! 
 * jQuery Tabs - jQuery plugin to create simple vertical and horizontal tabs
 * Copyright 2017 - Anantajit JG
 * https://github.com/anantajitjg/jquery-tabs
 */

(function ($) {
    'use strict';
    $.fn.jqTabs = function (options) {
        // plugin options
        var settings = $.extend({
            direction: 'vertical',
            duration: 400,
            mainWrapperClass: 'jq-tab-wrapper',
            tabClass: 'jq-tab-title',
            tabContentClass: 'jq-tab-content',
            tabClicked: $.noop,
            tabContentLoaded: $.noop
        }, options);
        return this.each(function () {
            var wrapperElem = $(this);
            wrapperElem.hasClass(settings.mainWrapperClass) ? '' : wrapperElem.addClass(settings.mainWrapperClass);
            settings.direction === 'horizontal' ? wrapperElem.addClass('horizontal-tab') : ''; // if direction is horizontal then a class horizontal-tab is added
            wrapperElem.find('.' + settings.tabClass).click(function (e) {
                e.preventDefault();
                settings.tabClicked.call(); // optional callback
                var currentTabElem = $(this);
                if (!currentTabElem.hasClass('active')) {
                    wrapperElem.find('.' + settings.tabClass).removeClass('active');
                    var currentTab = currentTabElem.data('tab'); // get the current data value for the tab
                    currentTabElem.addClass('active');
                    wrapperElem.find('.' + settings.tabContentClass).removeClass('active').css('display', 'none');
                    // display tab content
                    wrapperElem.find('.' + settings.tabContentClass + '[data-tab="' + currentTab + '"]').fadeIn(settings.duration, function () {
                        settings.tabContentLoaded.call(); // optional callback
                        var currentContentElem = $(this);
                        currentContentElem.addClass('active');
                    });
                }
            });
        });
    }
}(jQuery));