import { createApp, reactive } from "https://unpkg.com/petite-vue?module";

var links = [
    {
        url: "https://podbay.fm/p/chicane-presents-sunsets",
        label: "SunSets: Chicane"
    },
    {
        url: "https://podbay.fm/p/london-elektricity-podcast",
        label: "FSM: London Electricity"
    },
    {
        url: "https://podbay.fm/p/hospital-records-podcast",
        label: "Hospital Music Podcast"
    },
    {
        url: "https://podbay.fm/p/1483510527",
        label: "Stackoverflow Podcast"
    },
    {
        url: "https://podbay.fm/p/hidden-brain",
        label: "Hidden Brain Podcast"
    },
    {
        url: "https://podbay.fm/p/code-brew-285651",
        label: "Code Brew Podcast"
    }
];

const app = reactive({
    data: {
        items: links
    }
});

createApp({ app }).mount("#model");
