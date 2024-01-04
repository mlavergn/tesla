import { createApp, reactive } from "https://unpkg.com/petite-vue?module";

var links = [
    {
        url: "https://teslawaze.azurewebsites.net",
        label: "TeslaWaze"
    },
    {
        url: "https://abetterrouteplanner.com/classic/",
        label: "Better Route Planner"
    },
    {
        url: "https://abettertheater.com/",
        label: "A Better Theater"
    },
    {
        url: "https://supercharge.info/map",
        label: "Super Chargers"
    },
    {
        url: "https://maps.google.com",
        label: "Google Maps"
    },
    {
        url: "https://cnbc.com",
        label: "CNBC"
    },    
    {
        url: "https://about.teslafi.com",
        label: "TeslaFi"
    },
    {
        url: "https://fast.com",
        label: "Fast by Netflix"
    },
    {
        url: "https://github.com/mlavergn",
        label: "GitHub"
    },
    {
        url: "podcasts.html",
        label: "Podcasts"
    }    
];

const app = reactive({
    data: {
        items: links
    }
});

createApp({ app }).mount("#model");
