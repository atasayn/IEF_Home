<%@ Page Title="Our Research Framework" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="emsc_framework.aspx.cs" Inherits="IEF_Home.emsc_framework" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600&family=Inter:wght@400;500&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; }

        .emsc-main {
            font-family: 'Inter', sans-serif;
            color: #253238;
            line-height: 1.75;
            width: 100%;
            padding: 2.5rem 2.5rem 5rem;
            font-size: 18px;
        }

        .emsc-main a {
            color: #0b6d84;
            text-decoration: underline;
            text-underline-offset: 2px;
        }

        .emsc-main a:hover { color: #08505f; }

        .emsc-main h2 {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 3rem;
            font-weight: 600;
            margin: 0 0 1.4rem;
        }

        /* ── Intro banner ── */
        .emsc-intro {
            background: #eaf6f8;
            border-left: 4px solid #0f8ca7;
            border-radius: 0 6px 6px 0;
            padding: 1.1rem 1.5rem;
            margin-bottom: 1.5rem;
            font-size: 1.6rem;
            color: #08505f;
            line-height: 1.75;
        }

        .emsc-toolbar {
            display: flex;
            gap: 1.2rem;
            justify-content: flex-end;
            margin-bottom: 1rem;
            font-size: 1.3rem;
        }

        .emsc-linkbtn {
            background: none;
            border: 0;
            padding: 0;
            color: #0b6d84;
            text-decoration: underline;
            text-underline-offset: 2px;
            cursor: pointer;
            font: inherit;
        }

        /* ── Foldable sections ── */
        .emsc-section {
            border: 1px solid #cdeaef;
            border-radius: 8px;
            margin-bottom: 1.2rem;
            background: #fff;
        }

        .emsc-section > summary {
            list-style: none;
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1.2rem 1.5rem;
            cursor: pointer;
            font-family: 'Space Grotesk', sans-serif;
            font-size: 2rem;
            font-weight: 600;
            color: #253238;
            border-radius: 8px;
        }

        .emsc-section > summary::-webkit-details-marker { display: none; }

        .emsc-section > summary:hover { background: #f2f9fa; }

        .emsc-section[open] > summary {
            border-bottom: 2px solid #0f8ca7;
            border-radius: 8px 8px 0 0;
        }

        .emsc-num {
            flex-shrink: 0;
            width: 3.4rem;
            height: 3.4rem;
            border-radius: 50%;
            background: #0f8ca7;
            color: #fff;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.6rem;
        }

        .emsc-sum-title { flex: 1; min-width: 0; }

        .emsc-badge {
            font-family: 'Inter', sans-serif;
            font-size: 1.1rem;
            font-weight: 500;
            letter-spacing: 0.06em;
            text-transform: uppercase;
            background: #fff3d1;
            color: #6b4f00;
            padding: 3px 9px;
            border-radius: 4px;
            white-space: nowrap;
        }

        .emsc-toggle {
            font-family: 'Inter', sans-serif;
            font-size: 1.3rem;
            font-weight: 500;
            color: #0f8ca7;
            white-space: nowrap;
        }

        .emsc-toggle::after { content: "Show \25BE"; }
        .emsc-section[open] .emsc-toggle::after { content: "Hide \25B4"; }

        .emsc-section-body {
            padding: 1.8rem 2rem 2rem;
            font-size: 1.6rem;
            line-height: 1.85;
            color: #253238;
        }

        .emsc-section-body p { margin: 0 0 1.2rem; }

        .emsc-label {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 1.4rem;
            font-weight: 600;
            letter-spacing: 0.09em;
            text-transform: uppercase;
            color: #0f8ca7;
            margin: 2rem 0 0.85rem;
        }

        .emsc-takeaway {
            background: #f2f9fa;
            border-radius: 8px;
            padding: 1.2rem 1.5rem;
            margin: 1.5rem 0;
        }

        .emsc-hint {
            font-size: 1.3rem;
            color: #6b7a80;
            font-style: italic;
        }

        /* ── Figure cards (open a pop-up) ── */
        .emsc-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 14px;
            margin: 1rem 0 1.5rem;
        }

        .emsc-card {
            display: flex;
            flex-direction: column;
            text-align: left;
            background: #fff;
            border: 1px solid #cdeaef;
            border-radius: 8px;
            padding: 0.9rem;
            cursor: pointer;
            font: inherit;
            color: inherit;
            transition: border-color 0.15s, box-shadow 0.15s;
        }

        .emsc-card:hover, .emsc-card:focus-visible {
            border-color: #0f8ca7;
            box-shadow: 0 2px 10px rgba(15,140,167,0.15);
            outline: none;
        }

        .emsc-card img {
            width: 100%;
            height: 140px;
            object-fit: contain;
            background: #f2f9fa;
            border-radius: 4px;
        }

        .emsc-card-title {
            font-family: 'Space Grotesk', sans-serif;
            font-weight: 600;
            font-size: 1.5rem;
            color: #0b6d84;
            margin-top: 0.7rem;
        }

        .emsc-card-desc {
            font-size: 1.3rem;
            color: #5a6b72;
            line-height: 1.5;
            margin-top: 0.3rem;
        }

        .emsc-card-more {
            font-size: 1.2rem;
            color: #0f8ca7;
            margin-top: auto;
            padding-top: 0.6rem;
        }

        /* ── Cascade diagram ── */
        .emsc-diagram {
            background: #f7fbfc;
            border: 1px solid #cdeaef;
            border-radius: 8px;
            padding: 1rem;
            margin: 1.5rem 0 1rem;
            overflow-x: auto;
        }

        .emsc-diagram svg {
            display: block;
            width: 100%;
            min-width: 760px;
            height: auto;
            font-family: 'Inter', sans-serif;
        }

        .emsc-node { cursor: pointer; }
        .emsc-node:focus { outline: none; }

        .emsc-node .emsc-box {
            fill: #fff;
            stroke: #0f8ca7;
            stroke-width: 1.5;
            transition: fill 0.15s;
        }

        .emsc-node .emsc-box.society { fill: #f19a92; }
        .emsc-node .emsc-box.nature { fill: #93cf8a; }
        .emsc-node .emsc-box.core { fill: #8cc4dc; }
        .emsc-node .emsc-box.chip { fill: #eaf6f8; stroke: #7cc3d3; }

        .emsc-node:hover .emsc-box,
        .emsc-node:focus-visible .emsc-box {
            stroke: #ffc000;
            stroke-width: 3;
        }

        .emsc-node:hover .emsc-box:not(.society):not(.nature):not(.core) { fill: #fff3d1; }

        .emsc-node text { font-size: 15px; fill: #253238; pointer-events: none; }
        .emsc-node text.small { font-size: 13px; }

        .emsc-pin circle { fill: #ffc000; }
        .emsc-pin text { font-size: 11px; font-weight: 600; fill: #253238; }

        .emsc-line { stroke: #0f8ca7; stroke-width: 1.6; fill: none; }
        .emsc-frame { stroke: #0b6d84; stroke-width: 1.6; stroke-dasharray: 7 5; fill: none; }
        .emsc-cycle { stroke: #4f9a4f; stroke-width: 1.8; stroke-dasharray: 3 4; fill: none; }
        .emsc-annot { font-size: 13px; font-style: italic; fill: #5a6b72; }

        .emsc-stages {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin: 0.5rem 0 1.5rem;
        }

        .emsc-chip {
            background: #eaf6f8;
            border: 1px solid #cdeaef;
            border-radius: 16px;
            padding: 4px 12px;
            font: inherit;
            font-size: 1.3rem;
            color: #0b6d84;
            cursor: pointer;
        }

        .emsc-chip:hover, .emsc-chip:focus-visible {
            border-color: #ffc000;
            background: #fff3d1;
            outline: none;
        }

        .emsc-chip b { color: #7a5a00; margin-right: 4px; }

        .emsc-refs {
            font-size: 1.3rem;
            color: #5a6b72;
            padding-left: 1.8rem;
        }

        .emsc-refs li { margin-bottom: 0.3rem; }

        /* ── Tables (section 4) ── */
        .emsc-tabs {
            display: flex;
            gap: 6px;
            border-bottom: 2px solid #cdeaef;
            margin-top: 1.5rem;
        }

        .emsc-tab {
            background: #eaf6f8;
            border: 1px solid #cdeaef;
            border-bottom: 0;
            border-radius: 6px 6px 0 0;
            padding: 0.6rem 1.4rem;
            font: inherit;
            font-size: 1.4rem;
            color: #0b6d84;
            cursor: pointer;
        }

        .emsc-tab[aria-selected="true"] {
            background: #0f8ca7;
            border-color: #0f8ca7;
            color: #fff;
        }

        .emsc-table-wrap {
            overflow-x: auto;
            margin-bottom: 1.5rem;
        }

        .emsc-table {
            border-collapse: collapse;
            width: 100%;
            min-width: 900px;
            font-size: 1.3rem;
            line-height: 1.45;
        }

        .emsc-table th, .emsc-table td {
            border: 1px solid #e1e8ea;
            padding: 0.7rem 0.8rem;
            vertical-align: top;
            text-align: left;
        }

        .emsc-table thead th {
            background: #0f8ca7;
            color: #fff;
            font-weight: 500;
        }

        .emsc-table thead tr.emsc-coupling th {
            background: #eaf6f8;
            color: #08505f;
            font-style: italic;
            font-weight: 400;
        }

        .emsc-table tbody th {
            background: #f2f9fa;
            color: #0b6d84;
            white-space: nowrap;
        }

        .emsc-table tbody tr:hover td { background: #fff3d1; }

        /* ── Method cards (section 5) ── */
        .emsc-methods {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
            gap: 14px;
            margin: 1rem 0 1.5rem;
        }

        .emsc-method {
            background: #f7fbfc;
            border: 1px solid #cdeaef;
            border-radius: 8px;
            padding: 1.1rem 1.3rem;
            font-size: 1.4rem;
            line-height: 1.6;
        }

        .emsc-method h4 {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 1.6rem;
            font-weight: 600;
            color: #0b6d84;
            margin: 0 0 0.6rem;
        }

        .emsc-method ul { padding-left: 1.8rem; margin: 0; }

        .emsc-todo {
            border: 1px dashed #ffc000;
            background: #fff9e6;
            border-radius: 8px;
            padding: 1rem 1.3rem;
            font-size: 1.4rem;
        }

        .emsc-todo ul { margin: 0.4rem 0 0; padding-left: 1.8rem; }

        /* ── Pop-up dialog ── */
        .emsc-dialog {
            border: 0;
            border-radius: 10px;
            padding: 0;
            width: min(820px, calc(100vw - 32px));
            max-height: calc(100vh - 48px);
            box-shadow: 0 12px 40px rgba(37,50,56,0.35);
            font-family: 'Inter', sans-serif;
            color: #253238;
        }

        .emsc-dialog::backdrop { background: rgba(37,50,56,0.55); }

        .emsc-dialog-inner {
            position: relative;
            padding: 2rem 2.4rem 2.2rem;
            font-size: 1.5rem;
            line-height: 1.75;
        }

        .emsc-dialog-close {
            position: absolute;
            top: 0.8rem;
            right: 0.8rem;
            width: 3.6rem;
            height: 3.6rem;
            border: 0;
            border-radius: 50%;
            background: #eaf6f8;
            color: #0b6d84;
            font-size: 2.2rem;
            line-height: 1;
            cursor: pointer;
        }

        .emsc-dialog-close:hover { background: #cdeaef; }

        .emsc-dialog h3 {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 2.2rem;
            font-weight: 600;
            color: #253238;
            margin: 0 3.5rem 1.2rem 0;
        }

        .emsc-dialog h3 .emsc-pop-num {
            display: inline-block;
            background: #ffc000;
            color: #253238;
            border-radius: 4px;
            padding: 0 7px;
            margin-right: 8px;
            font-size: 1.6rem;
            vertical-align: middle;
        }

        .emsc-dialog p { margin: 0 0 1rem; }

        .emsc-dialog a { color: #0b6d84; text-underline-offset: 2px; }

        .emsc-dialog figure { margin: 0 0 1.2rem; text-align: center; }

        .emsc-dialog figure img {
            max-width: 100%;
            max-height: 340px;
            height: auto;
            border-radius: 4px;
        }

        .emsc-dialog figcaption {
            font-size: 1.2rem;
            color: #6b7a80;
            font-style: italic;
            margin-top: 0.4rem;
        }

        .emsc-short {
            background: #fff9e6;
            border-left: 3px solid #ffc000;
            padding: 0.8rem 1.1rem;
            border-radius: 0 6px 6px 0;
        }

        .emsc-source {
            font-size: 1.25rem;
            color: #6b7a80;
            border-top: 1px solid #e1e8ea;
            padding-top: 0.8rem;
            margin-top: 1.2rem;
            line-height: 1.6;
        }

        .emsc-source a { word-break: break-word; }

        /* ── Responsive ── */
        @media (max-width: 700px) {
            .emsc-main { padding: 1.5rem 1.1rem 3rem; }
            .emsc-main h2 { font-size: 2.2rem; }
            .emsc-section > summary { font-size: 1.6rem; padding: 1rem; gap: 0.7rem; flex-wrap: wrap; }
            .emsc-num { width: 2.8rem; height: 2.8rem; font-size: 1.4rem; }
            .emsc-section-body { padding: 1.2rem 1.1rem 1.5rem; font-size: 1.5rem; }
            .emsc-cards { grid-template-columns: 1fr; }
            .emsc-dialog-inner { padding: 1.6rem 1.4rem 1.8rem; }
            .emsc-dialog h3 { font-size: 1.8rem; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="row">
        <div class="col-md-12">
            <div class="emsc-main">

                <h2>Our Research Framework: the Energy and Material Service Cascade</h2>

                <p class="emsc-intro">
                    This page offers a systematic and interactive introduction to the overarching sustainability research framework used by the Industrial Ecology Freiburg research group: the energy and material service cascade (EMSC). Originally proposed by <a href="https://doi.org/10.1016/j.erss.2019.02.026" target="_blank" rel="noopener">Kalt et al. (2019)</a> as Energy Service Cascade, this framework is under continuous development and application. The sections below guide you through the EMSC framework, its origin, its elements, its applications, and its links to other scientific disciplines.
                </p>

                <div class="emsc-toolbar">
                    <button type="button" class="emsc-linkbtn" id="emscExpandAll">Expand all</button>
                    <button type="button" class="emsc-linkbtn" id="emscCollapseAll">Collapse all</button>
                </div>

                <!-- ══ 1. From research questions to framework ══ -->
                <details class="emsc-section" id="research-questions" open>
                    <summary><span class="emsc-num">1</span><span class="emsc-sum-title">From research questions to research framework</span><span class="emsc-toggle"></span></summary>
                    <div class="emsc-section-body">
                        <p>
                            Sustainability transitions are large-scale changes in complex socio-ecological systems. Many processes and actors are involved, many links within and between the physical and the social world are relevant, and many feedbacks need to be considered. In such a setting, good research needs to focus without losing relevance. Here, an interdisciplinary research framework can help structure the approach by identifying key elements of study and building systematic links to other disciplines and modes of inquiry.
                        </p>
                        <p>
                            An interdisciplinary research framework for industrial ecology and socio-metabolic research must link materials and energy, industry and consumers, cities and global supply chains to each other and to the relevant social and environmental factors. It must enable us to study transitions over time and at different spatial scales.
                        </p>
                    </div>
                </details>

                <!-- ══ 2. Foundations ══ -->
                <details class="emsc-section" id="foundations">
                    <summary><span class="emsc-num">2</span><span class="emsc-sum-title">The foundations of the energy and material service cascade</span><span class="emsc-toggle"></span></summary>
                    <div class="emsc-section-body">
                        <p>
                            The general framework presented here builds on several foundations. The main influences are described in detail below, while many others are relevant, too.
                        </p>

                        <p class="emsc-hint">Click on a figure to learn more.</p>
                        <div class="emsc-cards">
                            <button type="button" class="emsc-card" data-pop="daly">
                                <img src="resources/emsc/economy-environment.png" alt="The economy as a sub-system of the environment">
                                <span class="emsc-card-title">Ecological economics</span>
                                <span class="emsc-card-desc">Two antipodal concepts of economy–environment interactions</span>
                                <span class="emsc-card-more">Read more &rarr;</span>
                            </button>
                            <button type="button" class="emsc-card" data-pop="doughnut">
                                <img src="resources/emsc/doughnut.jpg" alt="The Doughnut of social and planetary boundaries">
                                <span class="emsc-card-title">Doughnut economics</span>
                                <span class="emsc-card-desc">The safe and just space for humanity</span>
                                <span class="emsc-card-more">Read more &rarr;</span>
                            </button>
                            <button type="button" class="emsc-card" data-pop="smr">
                                <img src="resources/emsc/social-metabolism.png" alt="Economy-wide material and energy flows between society and nature">
                                <span class="emsc-card-title">Socio-metabolic research</span>
                                <span class="emsc-card-desc">Society–nature interactions and the biophysical basis of society</span>
                                <span class="emsc-card-more">Read more &rarr;</span>
                            </button>
                            <button type="button" class="emsc-card" data-pop="mefa">
                                <img src="resources/emsc/mefa-spheres.png" alt="Flows between biosphere, geosphere and anthroposphere">
                                <span class="emsc-card-title">Material and energy flow analysis</span>
                                <span class="emsc-card-desc">Quantifying flows and stocks of materials in a well-defined system</span>
                                <span class="emsc-card-more">Read more &rarr;</span>
                            </button>
                            <button type="button" class="emsc-card" data-pop="esc">
                                <img src="resources/emsc/ecosystem-service-cascade.png" alt="The ecosystem service cascade">
                                <span class="emsc-card-title">The ecosystem service cascade</span>
                                <span class="emsc-card-desc">From ecosystem structures to human well-being and values</span>
                                <span class="emsc-card-more">Read more &rarr;</span>
                            </button>
                        </div>

                        <div class="emsc-takeaway">
                            <p class="emsc-label" style="margin-top: 0;">Key takeaways</p>
                            <p>
                                An interdisciplinary research framework that links materials and energy, industry and consumers, cities and global supply chains to each other and to the relevant social and environmental factors adds detail to established approaches, including ecological economics, the Doughnut model of the economy, social metabolism, material and energy flow analysis, and the ecosystem service cascade. These frameworks depart from the basic understanding that economic activities, including the sustainable management of material and energy flows, are shaped by and embedded in ecological ceilings and social requirements.* However, they lack detail regarding how exactly materials and energy are linked to service provisioning, human wellbeing, and environmental impacts.
                            </p>
                            <p class="emsc-hint" style="margin-bottom: 0;">
                                *) See also <a href="https://www.blog.industrialecology.uni-freiburg.de/index.php/2018/12/02/why-a-two-pillar-model-is-a-better-choice-for-conceptualizing-sustainability/" target="_blank" rel="noopener">this blog post</a> by Stefan Pauliuk on the relation between environment, society, and the economy in sustainable development.
                            </p>
                        </div>
                    </div>
                </details>

                <!-- ══ 3. The EMSC ══ -->
                <details class="emsc-section" id="cascade">
                    <summary><span class="emsc-num">3</span><span class="emsc-sum-title">The synthesis framework: the energy and material service cascade</span><span class="emsc-toggle"></span></summary>
                    <div class="emsc-section-body">
                        <p>
                            The Energy and Material Service Cascade (EMSC) is a generally applicable conceptual framework to clarify and describe the relation between energy, materials, the environment, and society. The EMSC is the socio-metabolic analogue to Haines-Young’s and Potschin’s (2011) Ecosystem Service Cascade.
                        </p>
                        <p>
                            The EMSC offers a multi-stage perspective on (i) energy conversion and material supply chains comprising natural structures, human-made capital and labor; (ii) physical functions performed by energy chains and built environment structures (in-use stocks comprised of engineering materials); (iii) services humans demand to foster well-being; (iv) the actual contributions of services to human well-being (health, life satisfaction, …); (v) individual preferences and attitudes that create willingness to pay, encourage business models, etc. Values influence how services and benefits are perceived and affect structures through various social processes (investment decisions, environmental and economic policy, …). <span class="emsc-hint">(Rephrased from Kalt et al. (2019).)</span>
                        </p>

                        <p class="emsc-hint">Click on any numbered element of the cascade to learn more.</p>
                        <div class="emsc-diagram">
                            <svg viewBox="40 150 1260 520" role="group" aria-label="The energy and material service cascade">
                                <defs>
                                    <marker id="emscArrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
                                        <path d="M0,0 L10,5 L0,10 z" fill="#0f8ca7" />
                                    </marker>
                                </defs>

                                <!-- background structure -->
                                <ellipse class="emsc-cycle" cx="661" cy="383" rx="302" ry="92" />
                                <rect class="emsc-frame" x="232" y="192" width="512" height="222" rx="10" />
                                <path class="emsc-line" d="M75,302 C40,570 400,630 562,622" marker-end="url(#emscArrow)" />
                                <path class="emsc-line" d="M1272,304 C1300,570 960,630 752,622" marker-end="url(#emscArrow)" />
                                <line class="emsc-line" x1="146" y1="243" x2="146" y2="265" marker-start="url(#emscArrow)" marker-end="url(#emscArrow)" />
                                <line class="emsc-line" x1="1201" y1="242" x2="1201" y2="267" marker-start="url(#emscArrow)" marker-end="url(#emscArrow)" />
                                <line class="emsc-line" x1="242" y1="302" x2="219" y2="302" marker-end="url(#emscArrow)" />
                                <line class="emsc-line" x1="415" y1="302" x2="388" y2="302" marker-end="url(#emscArrow)" />
                                <line class="emsc-line" x1="588" y1="250" x2="561" y2="290" marker-end="url(#emscArrow)" />
                                <line class="emsc-line" x1="588" y1="358" x2="561" y2="315" marker-end="url(#emscArrow)" />
                                <line class="emsc-line" x1="762" y1="280" x2="734" y2="260" marker-end="url(#emscArrow)" />
                                <line class="emsc-line" x1="762" y1="330" x2="734" y2="350" marker-end="url(#emscArrow)" />
                                <line class="emsc-line" x1="935" y1="306" x2="908" y2="306" marker-end="url(#emscArrow)" />
                                <line class="emsc-line" x1="1129" y1="304" x2="1101" y2="306" marker-end="url(#emscArrow)" />
                                <line class="emsc-line" x1="657" y1="535" x2="657" y2="583" marker-end="url(#emscArrow)" />
                                <text class="emsc-annot" x="378" y="440">Production</text>
                                <text class="emsc-annot" x="874" y="446">Recycling</text>

                                <!-- 01 Values -->
                                <g class="emsc-node" data-pop="c01" tabindex="0" role="button" aria-label="01 Society, values">
                                    <rect class="emsc-box society" x="75" y="171" width="142" height="70" rx="6" />
                                    <text x="146" y="201" text-anchor="middle">Society,</text>
                                    <text x="146" y="221" text-anchor="middle">values</text>
                                    <g class="emsc-pin"><circle cx="75" cy="171" r="12" /><text x="75" y="175" text-anchor="middle">01</text></g>
                                </g>

                                <!-- 02 Wellbeing -->
                                <g class="emsc-node" data-pop="c02" tabindex="0" role="button" aria-label="02 Well-being">
                                    <rect class="emsc-box society" x="75" y="267" width="142" height="70" rx="6" />
                                    <text x="146" y="307" text-anchor="middle">Well-being</text>
                                    <g class="emsc-pin"><circle cx="75" cy="267" r="12" /><text x="75" y="271" text-anchor="middle">02</text></g>
                                </g>

                                <!-- 03 Benefits -->
                                <g class="emsc-node" data-pop="c03" tabindex="0" role="button" aria-label="03 Benefits">
                                    <rect class="emsc-box chip" x="168" y="352" width="96" height="28" rx="14" />
                                    <text class="small" x="216" y="371" text-anchor="middle">Benefits</text>
                                    <g class="emsc-pin"><circle cx="168" cy="352" r="12" /><text x="168" y="356" text-anchor="middle">03</text></g>
                                </g>

                                <!-- 04 Services -->
                                <g class="emsc-node" data-pop="c04" tabindex="0" role="button" aria-label="04 Services, activities">
                                    <rect class="emsc-box core" x="244" y="267" width="142" height="70" rx="6" />
                                    <text x="315" y="297" text-anchor="middle">Services,</text>
                                    <text x="315" y="317" text-anchor="middle">activities</text>
                                    <g class="emsc-pin"><circle cx="244" cy="267" r="12" /><text x="244" y="271" text-anchor="middle">04</text></g>
                                </g>

                                <!-- 05 Functions -->
                                <g class="emsc-node" data-pop="c05" tabindex="0" role="button" aria-label="05 Functions">
                                    <rect class="emsc-box chip" x="340" y="352" width="104" height="28" rx="14" />
                                    <text class="small" x="392" y="371" text-anchor="middle">Functions</text>
                                    <g class="emsc-pin"><circle cx="340" cy="352" r="12" /><text x="340" y="356" text-anchor="middle">05</text></g>
                                </g>

                                <!-- 06 Stocks -->
                                <g class="emsc-node" data-pop="c06" tabindex="0" role="button" aria-label="06 Products and stocks">
                                    <rect class="emsc-box core" x="417" y="267" width="142" height="70" rx="6" />
                                    <text x="488" y="297" text-anchor="middle">Products /</text>
                                    <text x="488" y="317" text-anchor="middle">stocks</text>
                                    <g class="emsc-pin"><circle cx="417" cy="267" r="12" /><text x="417" y="271" text-anchor="middle">06</text></g>
                                </g>

                                <!-- 07 Flows -->
                                <g class="emsc-node" data-pop="c07" tabindex="0" role="button" aria-label="07 Flows: build-up and operational energy and material">
                                    <rect class="emsc-box core" x="590" y="206" width="142" height="84" rx="6" />
                                    <text class="small" x="661" y="234" text-anchor="middle">Build-up</text>
                                    <text class="small" x="661" y="252" text-anchor="middle">energy and</text>
                                    <text class="small" x="661" y="270" text-anchor="middle">material</text>
                                    <rect class="emsc-box core" x="590" y="318" width="142" height="84" rx="6" />
                                    <text class="small" x="661" y="346" text-anchor="middle">Operational</text>
                                    <text class="small" x="661" y="364" text-anchor="middle">energy and</text>
                                    <text class="small" x="661" y="382" text-anchor="middle">material</text>
                                    <text x="661" y="309" text-anchor="middle" font-weight="600">Flows</text>
                                    <g class="emsc-pin"><circle cx="590" cy="206" r="12" /><text x="590" y="210" text-anchor="middle">07</text></g>
                                </g>

                                <!-- 08 SFSN -->
                                <g class="emsc-node" data-pop="c08" tabindex="0" role="button" aria-label="08 Stock-flow-service nexus">
                                    <rect class="emsc-box chip" x="250" y="178" width="218" height="28" rx="14" />
                                    <text class="small" x="359" y="197" text-anchor="middle">Stock-flow-service nexus</text>
                                    <g class="emsc-pin"><circle cx="250" cy="178" r="12" /><text x="250" y="182" text-anchor="middle">08</text></g>
                                </g>

                                <!-- 09 Supply -->
                                <g class="emsc-node" data-pop="c09" tabindex="0" role="button" aria-label="09 Energy and material supply">
                                    <rect class="emsc-box core" x="764" y="245" width="142" height="121" rx="6" />
                                    <text class="small" x="835" y="290" text-anchor="middle">Energy carriers,</text>
                                    <text class="small" x="835" y="310" text-anchor="middle">raw materials</text>
                                    <rect class="emsc-box core" x="937" y="262" width="162" height="93" rx="6" />
                                    <text class="small" x="1018" y="292" text-anchor="middle">Extraction &amp;</text>
                                    <text class="small" x="1018" y="310" text-anchor="middle">conversion</text>
                                    <text class="small" x="1018" y="328" text-anchor="middle">technologies</text>
                                    <text class="emsc-annot" x="1018" y="378" text-anchor="middle">Energy supply,</text>
                                    <text class="emsc-annot" x="1018" y="395" text-anchor="middle">material production</text>
                                    <g class="emsc-pin"><circle cx="764" cy="245" r="12" /><text x="764" y="249" text-anchor="middle">09</text></g>
                                </g>

                                <!-- 10 Material cycles -->
                                <g class="emsc-node" data-pop="c10" tabindex="0" role="button" aria-label="10 Material cycles and the circular economy">
                                    <rect class="emsc-box chip" x="586" y="446" width="150" height="28" rx="14" />
                                    <text class="small" x="661" y="465" text-anchor="middle">Material cycles</text>
                                    <g class="emsc-pin"><circle cx="586" cy="446" r="12" /><text x="586" y="450" text-anchor="middle">10</text></g>
                                </g>

                                <!-- 11 Earth system -->
                                <g class="emsc-node" data-pop="c11" tabindex="0" role="button" aria-label="11 Earth system dynamics and natural resources">
                                    <rect class="emsc-box nature" x="1131" y="171" width="141" height="69" rx="6" />
                                    <text x="1201" y="211" text-anchor="middle">Earth system</text>
                                    <rect class="emsc-box nature" x="1131" y="269" width="141" height="69" rx="6" />
                                    <text class="small" x="1201" y="298" text-anchor="middle">Climate impact,</text>
                                    <text class="small" x="1201" y="316" text-anchor="middle">land use</text>
                                    <text class="emsc-annot" x="1201" y="360" text-anchor="middle">Natural resources</text>
                                    <g class="emsc-pin"><circle cx="1131" cy="171" r="12" /><text x="1131" y="175" text-anchor="middle">11</text></g>
                                </g>

                                <!-- 12 Social processes -->
                                <g class="emsc-node" data-pop="c12" tabindex="0" role="button" aria-label="12 Social processes: enablers">
                                    <rect class="emsc-box chip" x="380" y="495" width="555" height="40" rx="8" />
                                    <text x="657" y="521" text-anchor="middle">Enablers: culture, governance, economy, technology</text>
                                    <g class="emsc-pin"><circle cx="380" cy="495" r="12" /><text x="380" y="499" text-anchor="middle">12</text></g>
                                </g>

                                <!-- 13 Sustainability -->
                                <g class="emsc-node" data-pop="c13" tabindex="0" role="button" aria-label="13 Sustainability">
                                    <rect class="emsc-box" x="564" y="587" width="186" height="65" rx="6" />
                                    <text x="657" y="625" text-anchor="middle" font-weight="600">Sustainability</text>
                                    <g class="emsc-pin"><circle cx="564" cy="587" r="12" /><text x="564" y="591" text-anchor="middle">13</text></g>
                                </g>
                            </svg>
                        </div>

                        <div class="emsc-stages" aria-label="Stages of the cascade">
                            <button type="button" class="emsc-chip" data-pop="c01"><b>01</b>Values</button>
                            <button type="button" class="emsc-chip" data-pop="c02"><b>02</b>Well-being</button>
                            <button type="button" class="emsc-chip" data-pop="c03"><b>03</b>Benefits</button>
                            <button type="button" class="emsc-chip" data-pop="c04"><b>04</b>Services, activities</button>
                            <button type="button" class="emsc-chip" data-pop="c05"><b>05</b>Functions</button>
                            <button type="button" class="emsc-chip" data-pop="c06"><b>06</b>Stocks</button>
                            <button type="button" class="emsc-chip" data-pop="c07"><b>07</b>Flows</button>
                            <button type="button" class="emsc-chip" data-pop="c08"><b>08</b>Stock-flow-service nexus</button>
                            <button type="button" class="emsc-chip" data-pop="c09"><b>09</b>Energy and material supply</button>
                            <button type="button" class="emsc-chip" data-pop="c10"><b>10</b>Material cycles</button>
                            <button type="button" class="emsc-chip" data-pop="c11"><b>11</b>Earth system</button>
                            <button type="button" class="emsc-chip" data-pop="c12"><b>12</b>Social processes</button>
                            <button type="button" class="emsc-chip" data-pop="c13"><b>13</b>Sustainability</button>
                        </div>

                        <div class="emsc-takeaway">
                            <p class="emsc-label" style="margin-top: 0;">Key takeaways</p>
                            <p>The EMSC fulfils the conditions for a generally applicable framework for socio-metabolic research:</p>
                            <ul>
                                <li>It provides explicit links between materials and energy on the one side and industry and consumers on the other side via the stock-flow-service nexus.</li>
                                <li>When applied at the appropriate scale and system scope, it links the provisioning systems in cities to their global supply chains, e.g., via high-resolution dynamic material flow analysis linked to environmental footprints.</li>
                                <li>With the stock-flow-service nexus linked to population dynamics and energy and material trade scenarios, the framework allows us to depict transformations over time. As is common in material and energy flow analysis, it can be applied at any spatial scale of interest.</li>
                                <li>The links between the EMSC and the relevant social and environmental factors are established via different interdisciplinary linkages, which are described in the sections below.</li>
                            </ul>
                        </div>

                        <p class="emsc-label">Based upon</p>
                        <ul class="emsc-refs">
                            <li>Bergsdal et al. (2007), <a href="https://doi.org/10.1080/09613210701287588" target="_blank" rel="noopener">doi.org/10.1080/09613210701287588</a></li>
                            <li>Kalt et al. (2019), <a href="https://doi.org/10.1016/j.erss.2019.02.026" target="_blank" rel="noopener">doi.org/10.1016/j.erss.2019.02.026</a></li>
                            <li>Haberl et al. (2021), <a href="https://doi.org/10.1016/j.ecolecon.2021.106949" target="_blank" rel="noopener">doi.org/10.1016/j.ecolecon.2021.106949</a></li>
                            <li>Tanikawa et al. (2021), <a href="https://doi.org/10.1016/j.jclepro.2020.125450" target="_blank" rel="noopener">doi.org/10.1016/j.jclepro.2020.125450</a></li>
                            <li>Whiting et al. (2022), <a href="https://doi.org/10.1016/j.envdev.2021.100647" target="_blank" rel="noopener">doi.org/10.1016/j.envdev.2021.100647</a></li>
                            <li>Carmona et al. (2022), <a href="https://doi.org/10.1016/j.egyr.2022.10.086" target="_blank" rel="noopener">doi.org/10.1016/j.egyr.2022.10.086</a></li>
                        </ul>
                    </div>
                </details>

                <!-- ══ 4. Coupling and decoupling ══ -->
                <details class="emsc-section" id="decoupling">
                    <summary><span class="emsc-num">4</span><span class="emsc-sum-title">Coupling and decoupling in the energy and material service cascade</span><span class="emsc-toggle"></span></summary>
                    <div class="emsc-section-body">
                        <p>
                            Decoupling and rebounds can happen at all stages of the energy and material service cascade, and there are multiple different measures and mechanisms for both. The two tables below list examples of decoupling options by EMSC stage and type of strategy, as well as rebound mechanisms. The examples provided are stylized and may not represent desirable or typical situations.
                        </p>

                        <div class="emsc-tabs" role="tablist">
                            <button type="button" class="emsc-tab" role="tab" id="tabDecoupling" aria-controls="panelDecoupling" aria-selected="true">Decoupling options</button>
                            <button type="button" class="emsc-tab" role="tab" id="tabRebound" aria-controls="panelRebound" aria-selected="false">Rebound mechanisms</button>
                        </div>

                        <div class="emsc-table-wrap" role="tabpanel" id="panelDecoupling" aria-labelledby="tabDecoupling">
                            <table class="emsc-table">
                                <thead>
                                    <tr><th>Strategy</th><th>Wellbeing – service</th><th>Service – stocks</th><th>Stock – less flow</th><th>Stock – different flow</th><th>Flow – technology</th><th>Technology – impacts</th></tr>
                                    <tr class="emsc-coupling"><th>Coupling between stages</th><th>Urban form, lifestyle, values</th><th>Operating buildings, vehicles</th><th>Energy and material efficiency</th><th>Energy carrier and material choice</th><th>Renewables</th><th>Land use efficiency, ore grade</th></tr>
                                </thead>
                                <tbody>
                                    <tr><th>Technology</th><td>Marketing, technology narrative</td><td>Electric bicycles, video conference</td><td>Energy saving lamps (LED), building insulation</td><td>Electric vehicles, heat pumps, battery trains</td><td>Photovoltaics, wind energy, hydropower</td><td>New PV technologies, higher wind turbines</td></tr>
                                    <tr><th>Behaviour</th><td>Climate-friendly living: less meat</td><td>Cycling for short distances, train rides</td><td>Energy labels for products</td><td>Change of heating system, electric vehicle</td><td>Buy own roof-top PV or battery</td><td>Driving style</td></tr>
                                    <tr><th>Prices</th><td>CO<sub>2</sub> tax, emissions trading</td><td>Parking fees, property tax</td><td>Energy use tax</td><td>Purchase premium</td><td>Feed-in tariff</td><td>Invest in cleanup technologies</td></tr>
                                    <tr><th>Regulation</th><td>Small vehicle standards, building zoning regulations</td><td>Building zoning regulation, access to public transport</td><td>Minimum standards, e.g., no incandescent light bulbs</td><td>Ban of certain technologies (e.g., oil heating)</td><td>Compulsory capacity addition, merit order</td><td>Low carbon fuel standards</td></tr>
                                    <tr><th>Circular economy</th><td>Strategies aiming at lower per capita stocks</td><td>Provisioning modes with less materials (shift)</td><td>Light-weighting (better design and material substitution)</td><td>Sourcing materials from scrap via recycling</td><td>Using biomass if available, like from waste</td><td>Mining of high-grade deposits</td></tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="emsc-table-wrap" role="tabpanel" id="panelRebound" aria-labelledby="tabRebound" hidden>
                            <table class="emsc-table">
                                <thead>
                                    <tr><th>Rebound mechanism</th><th>Wellbeing – service</th><th>Service – stocks</th><th>Stock – less flow</th><th>Stock – different flow</th><th>Flow – technology</th><th>Technology – impacts</th></tr>
                                </thead>
                                <tbody>
                                    <tr><th>Technology</th><td>Less wellbeing due to bad product design or malfunctioning products</td><td>Inefficient service provision modes: single-family houses, private cars</td><td>Products with short lifetime by design, planned obsolescence</td><td>Increasing impacts for different packaging materials</td><td>Technology trade-offs, like large resource use of batteries</td><td>Higher impacts due to declining ore grades</td></tr>
                                    <tr><th>Behaviour</th><td>Diminished wellbeing contributions from habitual consumption</td><td>Less efficient use of stocks, e.g., large cars with few people due to convenience</td><td>More frequent replacement of stocks due to lack of time for repair</td><td>Stick to established technology due to lack of information</td><td>Delayed shift of technology due to perceived risks of change</td><td>Inefficient use of stocks, e.g., heating with window open</td></tr>
                                    <tr><th>Prices</th><td>Overconsumption of cheap services with marginal contributions to wellbeing</td><td>Inefficient use of stocks due to lack of incentives, e.g., empty office space</td><td>Fast fashion</td><td>Move to single-use material because it’s cheap</td><td>Stick to established technology due to lack of money</td><td>Higher impacts if environmental damage or bad labour conditions are not priced</td></tr>
                                    <tr><th>Regulation</th><td>Regulation may restrict service generation to certain times, like driving bans, which limits wellbeing</td><td>Regulation prohibits the more efficient use of devices, e.g., of office space, for different uses or more intense use</td><td>Mandatory replacement rates for e.g., safety equipment lead to higher turnover</td><td>Regulation prohibits the use of certain materials, despite their proven suitability</td><td>Regulation prohibits the use of certain production technologies, despite their proven suitability</td><td>Lack of regulation or law enforcement leads to higher impacts</td></tr>
                                    <tr><th>Circular economy</th><td>Services generated by lifetime-extended products may be seen as less attractive by some, like second-hand clothing</td><td>Lifetime extension can mean that inefficient products are used longer</td><td>Lifetime extension can mean that inefficient products are used longer</td><td>New materials can be more difficult to recycle, e.g., composites</td><td>Use of recycled material can be more energy-intensive than the use of natural resources</td><td>Use of recycled material can be more energy-intensive than the use of natural resources</td></tr>
                                </tbody>
                            </table>
                        </div>

                        <p>
                            The section below shows typical methods and examples for estimating the decoupling and rebound effects of the different strategies within industrial ecology and socio-metabolic research. After that, the perspective and assessment approaches of other disciplines, including economics, law, behavioural science, and planning, are systematically linked to the EMSC.
                        </p>
                    </div>
                </details>

                <!-- ══ 5. Working with the framework ══ -->
                <details class="emsc-section" id="applications">
                    <summary><span class="emsc-num">5</span><span class="emsc-sum-title">Working with the framework: applications, indicators and sustainability assessment</span><span class="emsc-badge">In preparation</span><span class="emsc-toggle"></span></summary>
                    <div class="emsc-section-body">
                        <div class="emsc-todo">
                            This section is being developed and will be completed after a workshop in November/December 2026. It will present the sub-systems of the cascade, with their definitions, main links, and applications, including research questions and good example studies:
                            <ul>
                                <li>The stock-flow-service nexus in different methods</li>
                                <li>Material cycles (Sankey diagrams)</li>
                                <li>Provisioning systems: socio-metabolic and institutional aspects</li>
                                <li>Product systems (life cycle assessment)</li>
                                <li>Decent living standards, mineral security, and material poverty</li>
                            </ul>
                        </div>

                        <p class="emsc-label">Preview: the stock-flow-service nexus in different methods</p>
                        <div class="emsc-methods">
                            <div class="emsc-method">
                                <h4>Dynamic material flow analysis</h4>
                                <ul>
                                    <li>The development over time of material and product in-use stocks is considered at scale (region, country).</li>
                                    <li>The build-up materials for the in-use stocks are calculated from the mass balance (inflow = stock change + outflow). Outflow can be determined from previous inflows with a lifetime model.</li>
                                    <li>Operation and service provision of in-use stocks is considered by some studies.</li>
                                    <li>Open question: how stocks and the services they provide contribute to wellbeing (focus so far on money/income).</li>
                                </ul>
                            </div>
                            <div class="emsc-method">
                                <h4>Life cycle assessment</h4>
                                <ul>
                                    <li>In-use stocks are not quantified. Instead, a tiny portion of a stock is consumed as a flow (e.g., for 1 vehicle-km: 1/200,000 of a vehicle that drives 200,000 km in total; 1/5,000 of a bed used for 5,000 nights).</li>
                                    <li>The operational energy and material demand is included.</li>
                                    <li>The build-up material is included via the material contained in that fraction of the product.</li>
                                    <li>All stocks are scaled down to flows according to their service lifetime.</li>
                                </ul>
                            </div>
                            <div class="emsc-method">
                                <h4>Macro-economic modelling</h4>
                                <ul>
                                    <li>In-use stocks in the end-use sectors (residential buildings, passenger vehicles, appliances) are not considered, only the (monetary) consumption of final goods that builds up and maintains these stocks.</li>
                                    <li>Industrial in-use stocks (factories, commercial buildings) are considered as monetary assets whose depreciation enables industrial production.</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </details>

                <!-- ══ 6. Interdisciplinary links ══ -->
                <details class="emsc-section" id="interdisciplinary">
                    <summary><span class="emsc-num">6</span><span class="emsc-sum-title">Interdisciplinary links from and to the energy and material service cascade</span><span class="emsc-badge">In preparation</span><span class="emsc-toggle"></span></summary>
                    <div class="emsc-section-body">
                        <div class="emsc-todo">
                            This section is being developed and will be completed after a workshop in November/December 2026. It will describe the systematic links between the EMSC and other disciplines, with descriptions and examples, including:
                            <ul>
                                <li>Wellbeing research</li>
                                <li>Regulation, policy, and planning</li>
                                <li>Economics and decision modelling</li>
                                <li>Inequality</li>
                                <li>High-resolution data</li>
                            </ul>
                        </div>
                    </div>
                </details>

                <!-- ══ 7. Connect ══ -->
                <details class="emsc-section" id="connect">
                    <summary><span class="emsc-num">7</span><span class="emsc-sum-title">How to connect, contribute, and develop</span><span class="emsc-toggle"></span></summary>
                    <div class="emsc-section-body">
                        <p>
                            The Industrial Ecology Freiburg research group is committed to using and expanding the energy and material service cascade as a general research framework for industrial ecology and socio-metabolic research. On this open science portal, we offer research infrastructure and teaching material to work with the EMSC and its related methods at different spatial scales and for different coupling and decoupling questions.
                        </p>
                        <p>
                            Something on this page is unclear or missing? Please reach out to us via <a href="mailto:in4mation@indecol.uni-freiburg.de">in4mation@indecol.uni-freiburg.de</a>.
                        </p>
                        <ul>
                            <li>The <a href="https://is4ie.org/" target="_blank" rel="noopener">International Society for Industrial Ecology (ISIE)</a>, with its different topical sections, provides access to a global network of scholars and practitioners working with the cascade and related approaches.</li>
                            <li>You can check and share open EMSC-related software tools via <a href="https://github.com/IndEcol/Dashboard" target="_blank" rel="noopener">github.com/IndEcol/Dashboard</a>.</li>
                            <li>You can check and share open EMSC-related datasets via Zenodo and link to <a href="https://zenodo.org/communities/indecol/records" target="_blank" rel="noopener">this community of datasets</a>.</li>
                            <li>You can check and share open EMSC-related teaching material with the <a href="https://is4ie.org/resources/educational" target="_blank" rel="noopener">ISIE</a>.</li>
                        </ul>

                        <p class="emsc-label">Credits</p>
                        <ul>
                            <li>The colleagues from SEC Vienna for their constant efforts to further develop the theoretical basis of socio-metabolic research.</li>
                            <li>The website portal <a href="https://nature-economy.com/" target="_blank" rel="noopener">nature-economy.com</a> for the idea to present the framework in an interactive manner.</li>
                            <li>Chris Hauenstein from the IEF team for feedback and ideas during the development of this overview.</li>
                        </ul>
                        <p class="emsc-hint">The material presented here will be documented in full in IEF Working Paper 1 (2027).</p>
                    </div>
                </details>

                <!-- ══ Pop-up dialog ══ -->
                <dialog class="emsc-dialog" id="emscDialog" aria-labelledby="emscDialogTitle">
                    <div class="emsc-dialog-inner">
                        <button type="button" class="emsc-dialog-close" id="emscDialogClose" aria-label="Close">&times;</button>
                        <div id="emscDialogBody"></div>
                    </div>
                </dialog>

                <!-- ══ Pop-up content: foundations ══ -->
                <template id="pop-daly">
                    <h3 id="emscDialogTitle">Two antipodal concepts of economy–environment interactions</h3>
                    <figure><img src="resources/emsc/economy-environment.png" alt="The economy as a sub-system of the environment"></figure>
                    <p>Daly and Farley (2004) discuss two different ways of looking at the relationship between the economy and the environment. First, one can perceive natural ecosystems as a subsystem of the man-made economy, a subsystem that provides us with resources and receives our waste flows, whose services – if necessary – can be substituted by economic processes, and whose limitations can be overcome by technology deployment. To put more emphasis on the importance of ecosystem services to the economy, ecological economists and many others have been promoting a different perspective: they propose to consider the economy as a sub-system of the natural environment (the figure above).</p>
                    <p>The latter view seems to have become the predominant perspective among researchers and accountants concerned with environmental issues. It can now even be found in the UN System of Environmental-Economic Accounting (SEEA) (Fig. 3.1 in UN (2012)), which provides guidelines for the accounting of the physical dimension of monetary stocks and flows recorded in the system of national accounts.</p>
                    <p class="emsc-short"><strong>Shortcomings:</strong> The economy comprises non-tangible assets like software and information, and socially constructed economic objects including liabilities and goodwill, which are not part of the biophysical reality. The non-tangible and perishable part of the economy, including non-tangible assets and service flows, is not accurately represented in this figure. Moreover, there is no notion of a social dimension, which is one key dimension of sustainable development. One can argue that neither of the two representations fully acknowledges the importance of physical limits to economic activity and the importance of non-physical, non-tangible objects in economic systems.</p>
                    <div class="emsc-source">
                        Sources: Daly, H.E., Farley, J., 2004. Ecological Economics. Principles and Application. Island Press, Washington D.C. · UN, 2012. System of Environmental-Economic Accounting 2012, Central Framework. United Nations, New York. · Text and figure adapted from Pauliuk and Hertwich (2015), <a href="https://doi.org/10.1016/j.ecolecon.2015.08.012" target="_blank" rel="noopener">doi.org/10.1016/j.ecolecon.2015.08.012</a>
                    </div>
                </template>

                <template id="pop-doughnut">
                    <h3 id="emscDialogTitle">The safe and just space for humanity</h3>
                    <figure><img src="resources/emsc/doughnut.jpg" alt="The Doughnut of social and planetary boundaries"></figure>
                    <p>Doughnut economics is a visual framework for sustainable development – shaped like a doughnut or lifebelt – combining the concept of planetary boundaries with the complementary concept of social boundaries. The name derives from the shape of the diagram, i.e. a disc with a hole in the middle.</p>
                    <p>The centre hole of the model depicts the proportion of people that lack access to life's essentials (healthcare, education, equity and so on), while the crust represents the ecological ceilings (planetary boundaries) that life depends on and must not be overshot.</p>
                    <p class="emsc-short"><strong>Shortcomings:</strong> The doughnut economy visual does not contain much structural detail about the regenerative and distributive economy.</p>
                    <div class="emsc-source">
                        Sources: Raworth, Kate (2012). A safe and just space for humanity. · <a href="https://en.wikipedia.org/wiki/Doughnut_(economic_model)" target="_blank" rel="noopener">en.wikipedia.org/wiki/Doughnut_(economic_model)</a>
                    </div>
                </template>

                <template id="pop-smr">
                    <h3 id="emscDialogTitle">Socio-metabolic research</h3>
                    <figure><img src="resources/emsc/social-metabolism.png" alt="Economy-wide material and energy flows between society and nature"></figure>
                    <p>Socio-metabolic research (SMR) is a systems approach to studying society–nature interactions at different spatio-temporal scales. It is based on the assumption that social systems and ecosystems are complex systems that reproduce themselves, interact with each other and co-evolve over time. Social metabolism encompasses biophysical flows exchanged between societies and their natural environment as well as the flows within and between social systems. Sociometabolic flows operate and maintain biophysical structures of society, such as buildings, infrastructures or machinery, usually denoted as ‘artefacts’, ‘manufactured capital’, ‘in-use stocks of materials’, or ‘material stocks’.</p>
                    <p>Systematically observing societies’ use of biophysical resources is a core goal of SMR. By focusing on society’s metabolism, SMR helps to overcome the widespread conceptual disregard of biophysical processes in many economic and social science approaches and demonstrates the ‘size’ or ‘scale’ of human activities compared with the biosphere. Explicitly or implicitly, sociometabolic research builds on the following assumptions:</p>
                    <p>(1) The functioning of social systems, including the economy, rests on successfully organizing energy and material flows to expand, maintain and operate its biophysical basis: human population, livestock and artefacts such as buildings, infrastructures or durable commodities. These stocks generate important flows, such as physical, intellectual or emotional labour, products such as bread, clothes or electricity, and services such as living space or mobility.</p>
                    <p>(2) The composition, magnitude and patterns of social metabolism determine society’s environmental pressures and impacts. Sustainability requires sociometabolic flows to be compatible with the supply and sink capacity of the biosphere.</p>
                    <p>(3) First principles of the natural sciences (for example, the laws of thermodynamics) apply to the metabolism of socioeconomic systems and are fundamental to their understanding.</p>
                    <p>In that sense, social systems (like humans themselves) constitute hybrids of biophysical and symbolic systems shaped by discourses, power relations or monetary flows, and are subject to intentional organization. SMR explicitly addresses economic theory and aims at broadening economic thought by providing a biophysical perspective on growth theory, efficiency and rebound effects or the decoupling debate.</p>
                    <p class="emsc-short"><strong>Shortcomings:</strong> While SMR has become a core element in communities such as ecological economics and industrial ecology, its links to the social and behavioural sciences, via the link between materials, need satisfaction, and wellbeing, remain understudied and need a stronger conceptual basis.</p>
                    <div class="emsc-source">
                        Source: Haberl et al. (2019), Contributions of sociometabolic research to sustainability science, <a href="https://doi.org/10.1038/s41893-019-0225-2" target="_blank" rel="noopener">doi.org/10.1038/s41893-019-0225-2</a>
                    </div>
                </template>

                <template id="pop-mefa">
                    <h3 id="emscDialogTitle">Material and energy flow analysis (MEFA)</h3>
                    <figure><img src="resources/emsc/mefa-spheres.png" alt="Flows between biosphere, geosphere and anthroposphere"></figure>
                    <p>Material flow analysis (MFA), also referred to as substance flow analysis (SFA), is an analytical method to quantify flows and stocks of materials or substances in a well-defined system. MFA is an important tool to study the bio-physical aspects of human activity on different spatial and temporal scales. It is considered a core method of industrial ecology or anthropogenic, urban, social and industrial metabolism. MFA is used to study material, substance, or product flows across different industrial sectors or within ecosystems. MFA can also be applied to a single industrial installation, for example, for tracking nutrient flows through a waste water treatment plant.</p>
                    <p class="emsc-short"><strong>Shortcomings:</strong> While MFA is the most systematic approach to study material and commodity flows, the links between materials and environmental impacts as well as their societal benefits are often schematic (e.g., via saturation patterns) or lacking from the assessments.</p>
                    <div class="emsc-source">
                        Sources: Baccini and Brunner, Metabolism of the Anthroposphere, <a href="https://www.amazon.de/Metabolism-Anthroposphere-Analysis-Evaluation-Design/dp/0262016656" target="_blank" rel="noopener">book link</a> · Graedel (2019), Material Flow Analysis from Origin to Evolution, <a href="https://doi.org/10.1021/acs.est.9b03413" target="_blank" rel="noopener">doi.org/10.1021/acs.est.9b03413</a> · <a href="https://en.wikipedia.org/wiki/Material_flow_analysis" target="_blank" rel="noopener">en.wikipedia.org/wiki/Material_flow_analysis</a>
                    </div>
                </template>

                <template id="pop-esc">
                    <h3 id="emscDialogTitle">The ecosystem service cascade</h3>
                    <figure><img src="resources/emsc/ecosystem-service-cascade.png" alt="The ecosystem service cascade"></figure>
                    <p>Haines-Young’s and Potschin’s (2011) ‘Ecosystem Service Cascade’ links the biophysical functioning of ecosystems to the society managing it by distinguishing: a) structures in the ecosystem, b) functions in the ecosystem, c) services of the ecosystem to society, d) benefits to people by consuming ecosystem services and e) values of people. This conceptual model is a multi-stage approach that allows us to explain how nature's biophysical features flow into human well-being and economic value.</p>
                    <p class="emsc-short"><strong>Shortcomings:</strong> Not really a shortcoming, but the ecosystem service cascade needs translation from ‘real’ to ‘industrial ecosystems’ or the built environment and its biophysical features, and how they constitute human wellbeing and economic value.</p>
                    <div class="emsc-source">
                        Sources: Haines-Young R, Potschin M B. 2010. The Links Between Biodiversity, Ecosystem Services and Human Well-Being. In: Raffaelli D, Frid C (eds.) Ecosystem Ecology: A New Synthesis. Cambridge University Press, 110–139, <a href="https://doi.org/10.1017/CBO9780511750458.007" target="_blank" rel="noopener">doi.org/10.1017/CBO9780511750458.007</a> · Spangenberg et al. (2014), <a href="https://doi.org/10.1016/j.ecolecon.2014.04.025" target="_blank" rel="noopener">doi.org/10.1016/j.ecolecon.2014.04.025</a>
                    </div>
                </template>

                <!-- ══ Pop-up content: cascade stages ══ -->
                <template id="pop-c01">
                    <h3 id="emscDialogTitle"><span class="emsc-pop-num">01</span>Values in the energy and material service cascade</h3>
                    <p>Values refer to individual attitudes, preferences and habits as well as societal norms and their manifestations. Economic and non-economic values are differentiated: in economic terms, values translate into willingness to pay for energy services. Moreover, benefits influence individual preferences and trigger behavioral patterns that are not economically motivated. Example: a person living in an urban region and appreciating the benefits of good access to public transport will likely have other convictions regarding an ideal place to live or traffic policy than a rural dweller used to moving by car.</p>
                    <p>Conversely, habits and societal preferences (‘values’) also influence the demand for energy services and the perceived benefits. These mechanisms are represented by the feedback from ‘values’ to ‘services’ and ‘benefits’. And finally, ‘values’ exert influence on the evolution of biophysical structures through numerous mechanisms involving governance, economy, culturally motivated claims articulated by e.g. social movements etc.</p>
                    <div class="emsc-source">Source: Kalt et al. (2019), <a href="https://doi.org/10.1016/j.erss.2019.02.026" target="_blank" rel="noopener">doi.org/10.1016/j.erss.2019.02.026</a></div>
                </template>

                <template id="pop-c02">
                    <h3 id="emscDialogTitle"><span class="emsc-pop-num">02</span>Wellbeing in the energy and material service cascade</h3>
                    <p>Human wellbeing is linked to environmental, economic, societal, political, social, and psychological factors and interactions between them. Wellbeing is studied with theories of human needs, the capabilities approach, and research on subjective indicators.</p>
                    <p>Research on wellbeing claims that there are objective constituents of well-being, which are ends in themselves and not just means for more positive and less negative feelings (so-called eudaimonic wellbeing).</p>
                    <p>Proponents of human needs theories claim that while there are infinitely many different strategies to satisfy human needs, the needs themselves are finite, few, and universal. This is the link (or nexus) between services, benefits, values, and wellbeing in the energy and material service cascade.</p>
                    <p>Different services (like transport or online meetings) can provide benefits (like exchange of information, formation of groups, closeness to friends), which, depending on the values of the individuals and organizations involved, contribute to human wellbeing.</p>
                    <div class="emsc-source">Source: Tamberg et al. (2026), <a href="https://doi.org/10.1007/s11205-026-03816-w" target="_blank" rel="noopener">doi.org/10.1007/s11205-026-03816-w</a></div>
                </template>

                <template id="pop-c03">
                    <h3 id="emscDialogTitle"><span class="emsc-pop-num">03</span>Benefits in the energy and material service cascade</h3>
                    <p>Energy services generate ‘benefits’: actual contributions to human wellbeing such as health and life satisfaction, which are associated with human needs (e.g., subsistence, protection, idleness etc.). Benefits are the outcome of services: not having to freeze in winter (i.e. thermal comfort; an energy service) contributes to bodily health (a benefit and contribution to wellbeing). Similarly, illuminated living space (a service) enables the inhabitants to be active after sunset, to enjoy various forms of entertainment or to participate in social life (benefits).</p>
                    <p>The actual benefits from energy services can be seen quite differently and in conflicting ways by different cultures and societal groups.</p>
                    <div class="emsc-source">Source: Kalt et al. (2019), <a href="https://doi.org/10.1016/j.erss.2019.02.026" target="_blank" rel="noopener">doi.org/10.1016/j.erss.2019.02.026</a></div>
                </template>

                <template id="pop-c04">
                    <h3 id="emscDialogTitle"><span class="emsc-pop-num">04</span>Services and activities in the energy and material service cascade</h3>
                    <p>Services are conceptualized as what humans actually demand. Services enhance wellbeing but are not identical to well-being contributions: while functions are conceptualized as being independent from actual beneficiaries, ‘a service is only a service if a human beneficiary can be identified’. For example, no service is attributable to illuminating and heating vacant buildings, although the functions are in place.</p>
                    <p>Culturally specific perceptions play an important role in the definition of services. It must be critically scrutinized what the actual demands of certain societal groups are, how they are articulated, and who gets to participate in defining the actual ‘service’. Requested service levels are to some degree defined by the subjective benefits they provide and influenced by historical and cultural backgrounds.</p>
                    <div class="emsc-source">Source: Kalt et al. (2019), <a href="https://doi.org/10.1016/j.erss.2019.02.026" target="_blank" rel="noopener">doi.org/10.1016/j.erss.2019.02.026</a></div>
                </template>

                <template id="pop-c05">
                    <h3 id="emscDialogTitle"><span class="emsc-pop-num">05</span>Functions in the energy and material service cascade</h3>
                    <p>‘Functions’ link socio-economic metabolism to people’s needs. In the cascade, a function is a physical action performed by an energy conversion chain, for example accelerating a vehicle, transmitting thermal energy to living space or emitting photons for illumination. Hence, functions are measurable in physical units but not necessarily energy units.</p>
                    <p>Usefulness: humans find it useful that a vehicle is accelerated by its internal combustion engine, or that food is kept fresh in a fridge. But – and this is the crucial difference to services – these useful capacities are not per se generators of well-being and merely help to provide a service, like enabling a person to reach a workplace or consuming fresh and healthy food.</p>
                    <div class="emsc-source">Source: Kalt et al. (2019), <a href="https://doi.org/10.1016/j.erss.2019.02.026" target="_blank" rel="noopener">doi.org/10.1016/j.erss.2019.02.026</a></div>
                </template>

                <template id="pop-c06">
                    <h3 id="emscDialogTitle"><span class="emsc-pop-num">06</span>Stocks and structures in the energy and material service cascade</h3>
                    <p>The cascade explicitly discerns natural structures, i.e. naturally occurring energy resources, and socio-technical structures, including manufactured capital and labor required to make energy available to end users.</p>
                    <p>It includes the entire energy conversion chain: primary energy conversion to secondary and final energy and ultimately useful energy, and the passive system, i.e., artefacts such as building envelopes for space heating or road and rail infrastructures and their spatial structures in freight and personal transport.</p>
                    <p>In MEFA terminology, the man-made part of this stage is the socio-economic metabolism.</p>
                    <div class="emsc-source">Source: Kalt et al. (2019), <a href="https://doi.org/10.1016/j.erss.2019.02.026" target="_blank" rel="noopener">doi.org/10.1016/j.erss.2019.02.026</a></div>
                </template>

                <template id="pop-c07">
                    <h3 id="emscDialogTitle"><span class="emsc-pop-num">07</span>Material and energy flows in the energy and material service cascade</h3>
                    <p>While the in-use stocks represent the structures (buildings, vehicles, infrastructure, appliances, industrial assets) that are needed to provide services to people, many services, such as driving, cooling, or eating, require operational energy and material flows, such as fuel, electricity, or food. Moreover, at some point, the stocks themselves have to be built and maintained, leading to build-up and maintenance flows of copper, steel, plastics, and many more materials, and of energy.</p>
                    <p>Together these flows form the ‘flow’ stage of the cascade. Flows are an essential prerequisite of forming and operating a built environment. The provision of such flows is thus a major economic indicator.</p>
                    <p>Next to inflows to stocks, there are outflows of waste and end-of-life buildings, vehicles, or products, which require treatment and which represent opportunities for re-use, recycling, and energy recovery and thus a circular economy of material resources.</p>
                    <p>Studying the link between stocks and flows is the subject of dynamic material flow analysis (dMFA) and dynamic stock modelling, in particular.</p>
                    <div class="emsc-source">Source: Baccini and Brunner, Metabolism of the Anthroposphere, <a href="https://www.amazon.de/Metabolism-Anthroposphere-Analysis-Evaluation-Design/dp/0262016656" target="_blank" rel="noopener">book link</a></div>
                </template>

                <template id="pop-c08">
                    <h3 id="emscDialogTitle"><span class="emsc-pop-num">08</span>The stock-flow-service nexus in the energy and material service cascade</h3>
                    <p>The in-use stocks of buildings, infrastructure, and products in the built environment form the socio-technical structures in the EMSC. They have several central roles (Pauliuk and Müller 2014). First, they are <strong>service suppliers</strong>: in-use stocks provide services to end-users and industries. Major human activities such as residing, working, transportation, and communication require in-use stocks such as buildings, cars, factories, and machines for their function.</p>
                    <p>At the same time, in-use stocks are <strong>resource repositories</strong>, as they represent large material stocks that need to be provided when stocks are built and that are set free when stocks are demolished.</p>
                    <p>Moreover, in-use stocks are <strong>dynamics determiners</strong>: they determine the long-term dynamics of the social metabolism. Stocks have a slow turnover in many sectors, with lifetimes of up to 100 years and more. This constrains how quickly new technologies can replace old ones. The availability of post-consumer scrap for recycling is to a large extent determined by the retirement rate of in-use stocks.</p>
                    <p>Together, these three central properties of stocks form the stock-flow-service nexus (SFS-nexus), which captures relationships between stocks, flows and services with the following core features: (1) Stringent stock-flow consistency: consumption flows can accumulate as in-use stocks, which are later released as waste flows. In the simple stationary model, consumption and waste flows equal the stock divided by the average lifetime. (2) The SFS-nexus approach offers a broader understanding of ‘services’; it therefore contributes to a much richer conceptualization of the linkages between resource use and wellbeing.</p>
                    <p>The SFS-nexus combines the two basic notions that (1) service provision to people requires the operation and use of stocks and that (2) over time, stocks require inflows of energy and materials for their operation and build-up, and they generate outflows of waste and end-of-life products as a result. Different methods each have their way of representing this central linkage of the EMSC (see section 5).</p>
                    <div class="emsc-source">Sources: Pauliuk and Müller (2014), <a href="https://doi.org/10.1016/j.gloenvcha.2014.03.013" target="_blank" rel="noopener">doi.org/10.1016/j.gloenvcha.2014.03.013</a> · Haberl et al. (2021), <a href="https://doi.org/10.1016/j.ecolecon.2021.106949" target="_blank" rel="noopener">doi.org/10.1016/j.ecolecon.2021.106949</a></div>
                </template>

                <template id="pop-c09">
                    <h3 id="emscDialogTitle"><span class="emsc-pop-num">09</span>Supply of energy and materials in the energy and material service cascade</h3>
                    <p>Operational and build-up energy and material flows, such as the steel for new buildings or the electricity for cooling buildings, are supplied by industry. The materials originate from agriculture, forestry, and mining and are processed by industry, manufacturing, and construction. All of these material cycle and energy supply steps use energy and cause emissions to the environment.</p>
                    <p>A wide array of technologies for processing materials and supplying energy is available, and these technologies are under constant development and improvement. Many energy carriers and materials are globally traded commodities, which means that they link remote extraction and processing to local manufacturing and consumption.</p>
                    <p>Hertwich (2021) estimates that the share of material production in global anthropogenic GHG emissions has risen to more than 20%. This means that industry is under large pressure to change technology and energy carriers, and to reduce output in light of global warming.</p>
                    <p>The control and ownership of industrial assets to process materials and energy is a major geopolitical factor, as illustrated by the conflicts around secure access to technology metals worldwide.</p>
                    <div class="emsc-source">Sources: Wiedenhofer et al. (2024), <a href="https://doi.org/10.1146/annurev-environ-110822-044428" target="_blank" rel="noopener">doi.org/10.1146/annurev-environ-110822-044428</a> · Hertwich (2021), <a href="https://doi.org/10.1038/s41561-021-00690-8" target="_blank" rel="noopener">doi.org/10.1038/s41561-021-00690-8</a></div>
                </template>

                <template id="pop-c10">
                    <h3 id="emscDialogTitle"><span class="emsc-pop-num">10</span>Material cycles and the circular economy in the energy and material service cascade</h3>
                    <p>The flows and stocks of materials in the anthroposphere form the technical material cycles, and managing these material flows and their cycles is an important part of human economic activity.</p>
                    <p>The circular economy (CE) is a particular vision of how such management can happen. It comprises two key elements at its core: firstly, re-circulating materials into new applications instead of disposing of them, thereby reducing both waste disposal and the need for primary natural resources and associated environmental impacts. This can be achieved by implementing measures along the spectrum of the well-known R-strategies: reduce, re-use, recycle. Secondly, the circular economy encourages a broader landscape of ways to provide goods and services using scarce natural resources. This involves new business models as well as social, civic, and regulatory arrangements that make circular practices (i.e., specific R-strategies) viable – from making products more repairable to enabling collaborative consumption and long-term use.</p>
                    <p>A CE can be seen as an idealized sustainable state of the industrial metabolism. The CE is a new economic paradigm on how to manage material use to meet societal goals (via service provisioning) while respecting local ecosystem integrity and global planetary boundaries.</p>
                    <div class="emsc-source">Source: Pauliuk et al. (2026), Stylized Facts for the Circular Economy – A Knowledge Synthesis. SSRN preprint 7028698</div>
                </template>

                <template id="pop-c11">
                    <h3 id="emscDialogTitle"><span class="emsc-pop-num">11</span>Earth system dynamics and natural resources in the energy and material service cascade</h3>
                    <p>Earth system dynamics include climate and weather, which impact ecosystem functioning and thus food and other biomass supply. Human activities, in turn, have a strong influence on these dynamics, with anthropogenic GHG emissions being the main driver.</p>
                    <p>Natural resources, such as minerals and land, are required for human material and energy (incl. food) supply chains. Different materials and energy carriers, combined with different extraction and conversion technologies (e.g. open pit vs. underground mining), drive land and resource use.</p>
                    <p>Decoupling options exist at this stage, e.g., the use of crops with higher yields or advanced mining and extraction techniques. But stronger coupling is also observed, e.g., when ore grades decline and more raw material has to be extracted and processed to produce a certain quantity of refined metals.</p>
                </template>

                <template id="pop-c12">
                    <h3 id="emscDialogTitle"><span class="emsc-pop-num">12</span>Social processes in the energy and material service cascade</h3>
                    <p><em>Social processes of organisation and transformation: labour, organisations, economy, governance, culture.</em></p>
                    <p>Stocks don’t work magically by themselves, and flows in the anthroposphere don’t move by themselves. They require human action for their formation and maintenance (stocks) and motion (flows). This action is guided by a number of coordinated social processes, including labour, governance, social movements, etc.</p>
                    <p>The EMSC contains both natural structures, i.e. naturally occurring energy resources, and socio-technical structures, including manufactured capital and the labour required to make energy available to end-users and convert it to useful energy.</p>
                    <p>Human values do not only link the services enjoyed to the perceived wellbeing but exert substantial influence on the evolution of biophysical structures in the built environment through numerous, diverse and complex mechanisms involving governance, economy, culturally motivated claims articulated by e.g. social movements etc.</p>
                    <p>Finally, the stock-flow-service nexus as central element of the EMSC is central in shaping human practices, which are “routinized type[s] of behavior which consists of several elements, interconnected to one other: forms of bodily activities, forms of mental activities, ‘things’ [stocks!] and their use [services! flows!], a background knowledge in the form of understanding, know-how, states of emotion and motivational knowledge” (Reckwitz 2002, p. 249).</p>
                    <div class="emsc-source">Sources: Haberl et al. (2021), <a href="https://doi.org/10.1016/j.ecolecon.2021.106949" target="_blank" rel="noopener">doi.org/10.1016/j.ecolecon.2021.106949</a> · Kalt et al. (2019), <a href="https://doi.org/10.1016/j.erss.2019.02.026" target="_blank" rel="noopener">doi.org/10.1016/j.erss.2019.02.026</a> · Reckwitz (2002), <a href="https://doi.org/10.1177/13684310222225432" target="_blank" rel="noopener">doi.org/10.1177/13684310222225432</a></div>
                </template>

                <template id="pop-c13">
                    <h3 id="emscDialogTitle"><span class="emsc-pop-num">13</span>Sustainability in the energy and material service cascade</h3>
                    <figure>
                        <img src="resources/emsc/two-pillar-sustainability.png" alt="A two-pillar model of sustainability">
                        <figcaption>A two-pillar model of sustainability, emphasizing the paramount importance of the social threshold and biophysical constraint, where the economy is not directly linked to sustainability but to the social and environmental pillars.</figcaption>
                    </figure>
                    <p>In the EMSC, economic activity is seen as embedded in the social realm and it also has a biophysical layer. Both the biophysical and the social spheres or layers pose constraints to economic activity: the biophysical sphere via resource scarcity and emission constraints, the social sphere via supply of labour, allocation of capital to economic processes, human demand for goods and services, and aspects of distributional justice.</p>
                    <p>The magnitude of the environmental problems we face and the billions of people with limited access to a healthy and fulfilling lifestyle remind us that the focus of sustainable development lies on meeting the needs of the global society while adhering to the environmental limits of the planet. We have the knowledge and the capability to design an economy that can achieve these two goals.</p>
                    <p>Sustainability in the EMSC hence rests on two pillars: social thresholds and biophysical constraints, and the economy is not directly linked to sustainability but to the social requirements and environmental foundations of society.</p>
                    <div class="emsc-source">Source: Rephrased from Pauliuk (2018), <a href="https://www.blog.industrialecology.uni-freiburg.de/index.php/2018/12/02/why-a-two-pillar-model-is-a-better-choice-for-conceptualizing-sustainability/" target="_blank" rel="noopener">Why a two-pillar model is a better choice for conceptualizing sustainability</a></div>
                </template>

            </div>
        </div>
    </div>

    <script>
        (function () {
            var dialog = document.getElementById('emscDialog');
            var dialogBody = document.getElementById('emscDialogBody');
            var sections = document.querySelectorAll('.emsc-section');

            function openPop(id) {
                var tpl = document.getElementById('pop-' + id);
                if (!tpl) return;
                dialogBody.innerHTML = '';
                dialogBody.appendChild(tpl.content.cloneNode(true));
                if (dialog.showModal) {
                    dialog.showModal();
                } else {
                    dialog.setAttribute('open', '');
                }
                dialog.scrollTop = 0;
            }

            function closePop() {
                if (dialog.close) {
                    dialog.close();
                } else {
                    dialog.removeAttribute('open');
                }
            }

            // Any element with data-pop opens the matching <template id="pop-...">
            document.addEventListener('click', function (e) {
                var trigger = e.target.closest('[data-pop]');
                if (trigger) {
                    e.preventDefault();
                    openPop(trigger.getAttribute('data-pop'));
                }
            });

            // SVG nodes are not native buttons, so handle Enter/Space ourselves
            document.addEventListener('keydown', function (e) {
                if (e.key !== 'Enter' && e.key !== ' ') return;
                var node = e.target.closest && e.target.closest('g[data-pop]');
                if (node) {
                    e.preventDefault();
                    openPop(node.getAttribute('data-pop'));
                }
            });

            document.getElementById('emscDialogClose').addEventListener('click', closePop);

            // Clicking the backdrop lands on the <dialog> element itself
            dialog.addEventListener('click', function (e) {
                if (e.target === dialog) closePop();
            });

            document.getElementById('emscExpandAll').addEventListener('click', function () {
                sections.forEach(function (s) { s.open = true; });
            });

            document.getElementById('emscCollapseAll').addEventListener('click', function () {
                sections.forEach(function (s) { s.open = false; });
            });

            // Tabs in section 4
            var tabs = document.querySelectorAll('.emsc-tab');
            tabs.forEach(function (tab) {
                tab.addEventListener('click', function () {
                    tabs.forEach(function (t) {
                        var selected = t === tab;
                        t.setAttribute('aria-selected', selected ? 'true' : 'false');
                        document.getElementById(t.getAttribute('aria-controls')).hidden = !selected;
                    });
                });
            });

            // Open the section named in the URL hash, e.g. /emsc_framework#cascade
            function openFromHash() {
                var target = location.hash && document.getElementById(location.hash.slice(1));
                if (target && target.classList.contains('emsc-section')) {
                    target.open = true;
                    target.scrollIntoView();
                }
            }
            window.addEventListener('hashchange', openFromHash);
            openFromHash();
        })();
    </script>
</asp:Content>
