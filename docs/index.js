import { createApp, reactive } from "https://unpkg.com/petite-vue?module";

var links = [
    {
        url: "podcasts.html",
        label: "Podcasts"
    },
    {
        url: "https://music.apple.com/us/browse",
        label: "Apple Music"
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
        url: "https://teslawaze.azurewebsites.net",
        label: "TeslaWaze"
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
    }
];

const app = reactive({
    data: {
        items: links
    }
});

createApp({ app }).mount("#model");
