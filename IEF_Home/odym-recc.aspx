<%@ Page Title="ODYM-RECC" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="odym-recc.aspx.cs" Inherits="IEF_Home.odym_recc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600&family=Inter:wght@400;500&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; }

        .ief-main {
            font-family: 'Inter', sans-serif;
            color: #1a2533;
            line-height: 1.75;
            width: 100%;
            padding: 2.5rem 2.5rem 5rem;
            font-size: 18px;
        }

        /* ── Intro banner ── */
        .ief-intro {
            background: #eef3fa;
            border-left: 4px solid #2d4a9e;
            border-radius: 0 6px 6px 0;
            padding: 1.1rem 1.5rem;
            margin-bottom: 3rem;
            font-size: 1.3rem;
            color: #1e3060;
            line-height: 1.75;
        }

        /* ── Section ── */
        .ief-section {
            margin-bottom: 4rem;
        }

        .ief-section-title {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 2.7rem;
            font-weight: 600;
            color: #1a2533;
            margin: 0 0 1.4rem;
            padding-bottom: 0.65rem;
            border-bottom: 2px solid #2d4a9e;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            flex-wrap: wrap;
        }

        .ief-tag {
            font-family: 'Inter', sans-serif;
            font-size: 1.3rem;
            font-weight: 500;
            letter-spacing: 0.07em;
            text-transform: uppercase;
            background: #dce6f7;
            color: #1e3a88;
            padding: 3px 10px;
            border-radius: 4px;
        }

        .ief-body {
            font-size: 1.5rem;
            line-height: 1.85;
            color: #243040;
            margin-bottom: 1.4rem;
        }

        /* ── Section sub-label ── */
        .ief-res-label {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 1.5rem;
            font-weight: 600;
            letter-spacing: 0.09em;
            text-transform: uppercase;
            color: #2d4a9e;
            margin: 2rem 0 0.85rem;
        }

        /* ── Link card grid ── */
        .ief-links {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 12px;
            margin-bottom: 0.5rem;
        }

        /* Card is now a div, not an <a> */
        .ief-link-card {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            background: #fff;
            border: 1px solid #c0d0ea;
            border-radius: 8px;
            padding: 0.9rem 1.1rem;
            color: inherit;
            transition: border-color 0.15s, box-shadow 0.15s;
            cursor: default;
            position: relative;
        }

        .ief-link-card:hover {
            border-color: #2d4a9e;
            box-shadow: 0 2px 10px rgba(45,74,158,0.10);
        }

        /* The icon acts as the clickable link */
        .ief-link-card-icon {
            width: 34px;
            height: 34px;
            border-radius: 7px;
            background: #e4ecf8;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            margin-top: 1px;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.15s;
        }

        .ief-link-card-icon:hover {
            background: #c8d9f5;
        }

        .ief-link-card-icon svg {
            width: 17px;
            height: 17px;
            stroke: #2d4a9e;
            fill: none;
            stroke-width: 2;
            stroke-linecap: round;
            stroke-linejoin: round;
            pointer-events: none;
        }

        /* All text in cards is selectable */
        .ief-link-card-meta {
            font-size: 1.4rem;
            color: #6a88b8;
            margin-bottom: 3px;
            font-family: 'Space Grotesk', sans-serif;
            display: block;
            letter-spacing: 0.02em;
            user-select: text;
            -webkit-user-select: text;
        }

        .ief-link-card-url {
            font-size: 1.2rem;
            font-weight: 500;
            color: #1e3a88;
            word-break: break-word;
            display: block;
            user-select: text;
            -webkit-user-select: text;
            /* Also make the URL itself a link */
            cursor: pointer;
            text-decoration: underline;
            text-underline-offset: 2px;
        }

        .ief-link-card-url:hover {
            color: #0f2260;
        }

        .ief-link-card-desc {
            font-size: 1.1rem;
            color: #4a6080;
            margin-top: 3px;
            line-height: 1.45;
            display: block;
            user-select: text;
            -webkit-user-select: text;
        }

        /* ── Figure ── */
        .ief-figure {
            background: #f0f5fc;
            border: 1px solid #c0d0ea;
            border-radius: 8px;
            padding: 1.5rem;
            text-align: center;
            margin: 1.4rem 0;
        }

        .ief-figure img {
            max-width: 100%;
            height: auto;
            border-radius: 4px;
        }

        .ief-figure figcaption {
            font-size: 0.875rem;
            color: #5a7090;
            margin-top: 0.75rem;
            font-style: italic;
        }

        /* ── Tutorial list ── */
        .ief-tut-list {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        /* Tutorial item is also a div now */
        .ief-tut-item {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            background: #fff;
            border: 1px solid #c0d0ea;
            border-radius: 8px;
            padding: 0.85rem 1.1rem;
            color: inherit;
            transition: border-color 0.15s;
            cursor: default;
        }

        .ief-tut-item:hover {
            border-color: #2d4a9e;
        }

        .ief-tut-icon {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background: #e4ecf8;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            margin-top: 1px;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.15s;
        }

        .ief-tut-icon:hover {
            background: #c8d9f5;
        }

        .ief-tut-icon svg {
            width: 14px;
            height: 14px;
            stroke: #2d4a9e;
            fill: none;
            stroke-width: 2;
            stroke-linecap: round;
            stroke-linejoin: round;
            pointer-events: none;
        }

        .ief-tut-title {
            font-size: 1.4rem;
            font-weight: 500;
            color: #1e3a88;
            display: block;
            user-select: text;
            -webkit-user-select: text;
            cursor: pointer;
            text-decoration: underline;
            text-underline-offset: 2px;
        }

        .ief-tut-title:hover {
            color: #0f2260;
        }

        .ief-tut-desc {
            font-size: 1.2rem;
            color: #4a6080;
            margin-top: 2px;
            display: block;
            line-height: 1.5;
            user-select: text;
            -webkit-user-select: text;
        }

        /* ── Version blocks ── */
        .ief-version-block {
            border-left: 3px solid #b0c4e4;
            padding-left: 1.4rem;
            margin-bottom: 2.25rem;
        }

        .ief-version-heading {
            font-family: 'Space Grotesk', sans-serif;
            font-size: 1.2rem;
            font-weight: 600;
            letter-spacing: 0.07em;
            text-transform: uppercase;
            color: #2d4a9e;
            margin-bottom: 0.75rem;
        }

        .ief-current-badge {
            background: #2d4a9e;
            color: #fff;
            font-size: 0.8rem;
            padding: 2px 7px;
            border-radius: 3px;
            vertical-align: middle;
            margin-left: 8px;
            letter-spacing: 0.04em;
        }

        .ief-commit {
            font-size: 1rem;
            color: #5a7090;
            margin-top: 0.65rem;
        }

        .ief-commit code {
            font-family: 'Courier New', monospace;
            background: #e4ecf8;
            padding: 1px 6px;
            border-radius: 3px;
            font-size: 1.1em;
            color: #1e3a88;
            user-select: text;
            -webkit-user-select: text;
        }

        /* ── Inline links ── */
        .ief-main a {
            color: #1e3a88;
            text-decoration: underline;
            text-underline-offset: 2px;
        }

        .ief-main a:hover { color: #0f2260; }

        /* ── Responsive ── */
        @media (max-width: 700px) {
            .ief-main { padding: 1.5rem 1.1rem 3rem; font-size: 15px; }
            .ief-links { grid-template-columns: 1fr; }
            .ief-section-title { font-size: 1.4rem; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="row">
        <div class="col-md-12">
            <main class="ief-main">

                <p class="ief-intro">
                    At Industrial Ecology Freiburg, we work at the forefront of sustainability science. This work involves the development of research infrastructure, including data models, databases, and scenario models for the circular economy. We are committed to open science and share our core model infrastructure and data with the global sustainability science community.
                </p>

                <!-- ══ ODYM ══ -->
                <section class="ief-section">
                    <h2 class="ief-section-title">ODYM <span class="ief-tag">Open Dynamic Material Systems Model</span></h2>

                    <p class="ief-body">
                        ODYM is an open source framework for material systems modeling programmed in Python. The description of systems, processes, stocks, flows, and parameters is object-based, which facilitates the development of modular software and testing routines for individual model blocks. ODYM MFA was developed for large MFA models that span many years (historic and future) and where different products, components, sub-components, materials, alloys, waste, and chemical elements need to be traced simultaneously. ODYM features a new data structure for material flow analysis; all input and output data are stored in a standardized file format and can thus be exchanged across projects. It also comes with an extended library for dynamic stock modelling, which can also be used as standalone script.
                    </p>

                    <p class="ief-res-label">ODYM resources</p>
                    <div class="ief-links">

                        <div class="ief-link-card">
                            <a class="ief-link-card-icon" href="https://doi.org/10.1111/jiec.12952" target="_blank" title="Open link">
                                <svg viewBox="0 0 24 24"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
                            </a>
                            <span>
                                <span class="ief-link-card-meta">Journal paper · open access</span>
                                <a class="ief-link-card-url" href="https://doi.org/10.1111/jiec.12952" target="_blank">doi.org/10.1111/jiec.12952</a>
                            </span>
                        </div>

                        <div class="ief-link-card">
                            <a class="ief-link-card-icon" href="https://github.com/IndEcol/ODYM" target="_blank" title="Open link">
                                <svg viewBox="0 0 24 24"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"/></svg>
                            </a>
                            <span>
                                <span class="ief-link-card-meta">Python code on GitHub</span>
                                <a class="ief-link-card-url" href="https://github.com/IndEcol/ODYM" target="_blank">github.com/IndEcol/ODYM</a>
                                <span class="ief-link-card-desc">Documentation of ODYM classes and functions</span>
                            </span>
                        </div>

                        <div class="ief-link-card">
                            <a class="ief-link-card-icon" href="https://github.com/IndEcol/ODYM/wiki" target="_blank" title="Open link">
                                <svg viewBox="0 0 24 24"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/></svg>
                            </a>
                            <span>
                                <span class="ief-link-card-meta">Wiki</span>
                                <a class="ief-link-card-url" href="https://github.com/IndEcol/ODYM/wiki" target="_blank">github.com/IndEcol/ODYM/wiki</a>
                            </span>
                        </div>

                        <div class="ief-link-card">
                            <a class="ief-link-card-icon" href="https://www.industrialecology.uni-freiburg.de/teaching" target="_blank" title="Open link">
                                <svg viewBox="0 0 24 24"><path d="M22 10v6M2 10l10-5 10 5-10 5z"/><path d="M6 12v5c3 3 9 3 12 0v-5"/></svg>
                            </a>
                            <span>
                                <span class="ief-link-card-meta">Tutorials &amp; exercises · IEooc</span>
                                <a class="ief-link-card-url" href="https://www.industrialecology.uni-freiburg.de/teaching" target="_blank">industrialecology.uni-freiburg.de</a>
                                <span class="ief-link-card-desc">Scroll to IEooc_Methods3_Software3–8</span>
                            </span>
                        </div>

                    </div>

                    <p class="ief-body" style="margin-top:1.5rem;">
                        ODYM is evolving into a community tool for industrial ecologist, MFA experts, and socio-economic metabolism researchers worldwide. A number of new developments and contributions by different community members are on their way, including routines for Monte-Carlo simulation, data reconciliation, and parallel computing.
                    </p>
                </section>

                <!-- ══ RECC ══ -->
                <section class="ief-section">
                    <h2 class="ief-section-title">RECC <span class="ief-tag">Resource Efficiency – Climate Change</span></h2>

                    <p class="ief-body">
                        The resource efficiency–climate change (RECC) mitigation model framework is a step towards the interdisciplinary scientific assessment of material efficiency and its links to service provision, material cycle management, and climate policy.
                        RECC is based on dynamic material flow analysis and links the services provided (individual motorized transport and shelter) to the operation of in-use stocks of products (passenger vehicles and residential buildings), to their expansion and maintenance, and to their material cycles to model mitigation strategies and analyze trade-offs for environmental impacts along the products' life cycle. A key innovation of RECC is the upscaling of product archetypes with different degrees of material and energy efficiency, which are simulated with engineering tools.
                    </p>
                    <p class="ief-body">
                        RECC scenarios are driven by parameters that augment the storylines of the shared socioeconomic pathways (SSP) to describe future service demand and associated material requirements. In its current implementation (model versions 2.2., 2.4, and 2.5), ten material efficiency strategies at different stages of the material cycle can be assessed by ramping up their implementation rates to the identified technical potentials.
                        RECC provides scenario results for the life cycle impacts of ambitious service–material decoupling concurrent with energy system decarbonization, giving detailed insights on the RECC mitigation nexus to policy-makers worldwide.
                    </p>

                    <p class="ief-res-label">RECC system definition</p>
                    <figure class="ief-figure">
                        <img src="resources/RECC_SysDef_Model_v2_5a.png" alt="System definition of the RECC model with global scope" width="768" height="381">
                        <figcaption>Figure: System definition of the RECC model with global scope.</figcaption>
                    </figure>

                    <p class="ief-res-label">RECC resources</p>
                    <p class="ief-body">
                        Currently, about ten researchers contribute to further developing the RECC model and its database, mainly via the EU CIRCOMOD [<a href="https://circomod.eu/" target="_blank">https://circomod.eu/</a>] project. We plan to include transportation infrastructure, link the RECC scenarios to sectoral and general equilibrium models, couple RECC to forest growth models, and to study the impact of energy transition and circular economy strategies on different socioeconomic groups. We have a mailing list for internal communication around the model. Contact us if you want to be on the RECC model mailing list!
                    </p>

                    <div class="ief-links">

                        <div class="ief-link-card">
                            <a class="ief-link-card-icon" href="research/Documents/RECC_Model_Brief_Nov23.pdf" target="_blank" title="Open link">
                                <svg viewBox="0 0 24 24"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
                            </a>
                            <span>
                                <span class="ief-link-card-meta">Model brief</span>
                                <a class="ief-link-card-url" href="research/Documents/RECC_Model_Brief_Nov23.pdf" target="_blank">RECC_Model_Brief_Nov23.pdf</a>
                            </span>
                        </div>

                        <div class="ief-link-card">
                            <a class="ief-link-card-icon" href="/research/Documents/RECC_Model_Overview_July_2023.pdf" target="_blank" title="Open link">
                                <svg viewBox="0 0 24 24"><rect x="2" y="3" width="20" height="14" rx="2" ry="2"/><line x1="8" y1="21" x2="16" y2="21"/><line x1="12" y1="17" x2="12" y2="21"/></svg>
                            </a>
                            <span>
                                <span class="ief-link-card-meta">Overview presentation</span>
                                <a class="ief-link-card-url" href="/research/Documents/RECC_Model_Overview_July_2023.pdf" target="_blank">RECC_Model_Overview_July_2023.pdf</a>
                            </span>
                        </div>

                        <div class="ief-link-card">
                            <a class="ief-link-card-icon" href="https://zenodo.org/records/14194614" target="_blank" title="Open link">
                                <svg viewBox="0 0 24 24"><ellipse cx="12" cy="5" rx="9" ry="3"/><path d="M21 12c0 1.66-4 3-9 3s-9-1.34-9-3"/><path d="M3 5v14c0 1.66 4 3 9 3s9-1.34 9-3V5"/></svg>
                            </a>
                            <span>
                                <span class="ief-link-card-meta">Zenodo overview</span>
                                <a class="ief-link-card-url" href="https://zenodo.org/records/14194614" target="_blank">zenodo.org/records/14194614</a>
                                <span class="ief-link-card-desc">Reports and publications list</span>
                            </span>
                        </div>

                        <div class="ief-link-card">
                            <a class="ief-link-card-icon" href="https://www.resourcepanel.org/reports/resource-efficiency-and-climate-change" target="_blank" title="Open link">
                                <svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><line x1="2" y1="12" x2="22" y2="12"/><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"/></svg>
                            </a>
                            <span>
                                <span class="ief-link-card-meta">First RECC results · IRP report</span>
                                <a class="ief-link-card-url" href="https://www.resourcepanel.org/reports/resource-efficiency-and-climate-change" target="_blank">resourcepanel.org</a>
                            </span>
                        </div>

                        <div class="ief-link-card">
                            <a class="ief-link-card-icon" href="https://onlinelibrary.wiley.com/doi/full/10.1111/jiec.13023" target="_blank" title="Open link">
                                <svg viewBox="0 0 24 24"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
                            </a>
                            <span>
                                <span class="ief-link-card-meta">Framework paper · open access</span>
                                <a class="ief-link-card-url" href="https://onlinelibrary.wiley.com/doi/full/10.1111/jiec.13023" target="_blank">doi.org/10.1111/jiec.13023</a>
                            </span>
                        </div>

                        <div class="ief-link-card">
                            <a class="ief-link-card-icon" href="https://github.com/IndEcol/RECC-ODYM" target="_blank" title="Open link">
                                <svg viewBox="0 0 24 24"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"/></svg>
                            </a>
                            <span>
                                <span class="ief-link-card-meta">Python code on GitHub</span>
                                <a class="ief-link-card-url" href="https://github.com/IndEcol/RECC-ODYM" target="_blank">github.com/IndEcol/RECC-ODYM</a>
                            </span>
                        </div>

                        <div class="ief-link-card">
                            <a class="ief-link-card-icon" href="https://docs.google.com/presentation/d/1Iw8LkWveC-BWy69ULVZdp5Wj2Q1udouwYPtFw2ixsQc/edit?usp=sharing" target="_blank" title="Open link">
                                <svg viewBox="0 0 24 24"><rect x="2" y="3" width="20" height="14" rx="2" ry="2"/><line x1="8" y1="21" x2="16" y2="21"/><line x1="12" y1="17" x2="12" y2="21"/></svg>
                            </a>
                            <span>
                                <span class="ief-link-card-meta">JRECC model development canvas</span>
                                <a class="ief-link-card-url" href="https://docs.google.com/presentation/d/1Iw8LkWveC-BWy69ULVZdp5Wj2Q1udouwYPtFw2ixsQc/edit?usp=sharing" target="_blank">Google Slides</a>
                            </span>
                        </div>

                    </div>

                    <p class="ief-res-label" style="margin-top:2rem;">RECC tutorials</p>
                    <div class="ief-tut-list">

                        <div class="ief-tut-item">
                            <a class="ief-tut-icon" href="https://www.youtube.com/watch?v=zOfo1WTk7d8" target="_blank" title="Open link">
                                <svg viewBox="0 0 24 24"><polygon points="5 3 19 12 5 21 5 3"/></svg>
                            </a>
                            <span>
                                <a class="ief-tut-title" href="https://www.youtube.com/watch?v=zOfo1WTk7d8" target="_blank">RECC model tutorial video</a>
                                <span class="ief-tut-desc">Run ODYM-RECC on your own machine. Explains config files and how the model scripts work together for single and multiple scenarios.</span>
                            </span>
                        </div>

                        <div class="ief-tut-item">
                            <a class="ief-tut-icon" href="research/Documents/RECC_Multiple_Scenarios_HowTo.mp4" target="_blank" title="Open link">
                                <svg viewBox="0 0 24 24"><polygon points="5 3 19 12 5 21 5 3"/></svg>
                            </a>
                            <span>
                                <a class="ief-tut-title" href="research/Documents/RECC_Multiple_Scenarios_HowTo.mp4" target="_blank">Multi-scenario generation tutorial</a>
                                <span class="ief-tut-desc">RECC_Multiple_Scenarios_HowTo.mp4</span>
                            </span>
                        </div>

                        <div class="ief-tut-item">
                            <a class="ief-tut-icon" href="research/Documents/RECC_Aggregation_Visualisation_HowTo.mp4" target="_blank" title="Open link">
                                <svg viewBox="0 0 24 24"><polygon points="5 3 19 12 5 21 5 3"/></svg>
                            </a>
                            <span>
                                <a class="ief-tut-title" href="research/Documents/RECC_Aggregation_Visualisation_HowTo.mp4" target="_blank">Results evaluation tutorial</a>
                                <span class="ief-tut-desc">RECC_Aggregation_Visualisation_HowTo.mp4</span>
                            </span>
                        </div>

                        <div class="ief-tut-item">
                            <a class="ief-tut-icon" href="research/Documents/RECC_City_Level_HowTo.mp4" target="_blank" title="Open link">
                                <svg viewBox="0 0 24 24"><polygon points="5 3 19 12 5 21 5 3"/></svg>
                            </a>
                            <span>
                                <a class="ief-tut-title" href="research/Documents/RECC_City_Level_HowTo.mp4" target="_blank">Using RECC at the city level</a>
                                <span class="ief-tut-desc">RECC_City_Level_HowTo.mp4</span>
                            </span>
                        </div>

                        <div class="ief-tut-item">
                            <a class="ief-tut-icon" href="research/Documents/ODYM_Data_Processes_ODP_Manual.pdf" target="_blank" title="Open link">
                                <svg viewBox="0 0 24 24"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
                            </a>
                            <span>
                                <a class="ief-tut-title" href="research/Documents/ODYM_Data_Processes_ODP_Manual.pdf" target="_blank">Data documentation routine — ODYM data process manual</a>
                                <span class="ief-tut-desc">ODYM_Data_Processes_ODP_Manual.pdf · sample parameter file: 2_S_RECC_FinalProducts_2015_nonresbuildings_V2.2.xlsx</span>
                            </span>
                        </div>

                        <div class="ief-tut-item">
                            <a class="ief-tut-icon" href="research/Documents/2_S_RECC_FinalProducts_2015_nonresbuildings_V2.2.xlsx" target="_blank" title="Open link">
                                <svg viewBox="0 0 24 24"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/><polyline points="10 9 9 9 8 9"/></svg>
                            </a>
                            <span>
                                <a class="ief-tut-title" href="research/Documents/2_S_RECC_FinalProducts_2015_nonresbuildings_V2.2.xlsx" target="_blank">Sample parameter file</a>
                                <span class="ief-tut-desc">2_S_RECC_FinalProducts_2015_nonresbuildings_V2.2.xlsx</span>
                            </span>
                        </div>

                    </div>

                    <p class="ief-res-label" style="margin-top:2rem;">Version history</p>

                    <div class="ief-version-block">
                        <p class="ief-version-heading">v2.5 <span class="ief-current-badge">current</span></p>
                        <div class="ief-links">

                            <div class="ief-link-card">
                                <a class="ief-link-card-icon" href="https://github.com/IndEcol/RECC-ODYM" target="_blank" title="Open link">
                                    <svg viewBox="0 0 24 24"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"/></svg>
                                </a>
                                <span>
                                    <span class="ief-link-card-meta">Python code</span>
                                    <a class="ief-link-card-url" href="https://github.com/IndEcol/RECC-ODYM" target="_blank">github.com/IndEcol/RECC-ODYM</a>
                                </span>
                            </div>

                            <div class="ief-link-card">
                                <a class="ief-link-card-icon" href="https://doi.org/10.6094/UNIFR/242061" target="_blank" title="Open link">
                                    <svg viewBox="0 0 24 24"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
                                </a>
                                <span>
                                    <span class="ief-link-card-meta">Model documentation</span>
                                    <a class="ief-link-card-url" href="https://doi.org/10.6094/UNIFR/242061" target="_blank">doi.org/10.6094/UNIFR/242061</a>
                                </span>
                            </div>

                            <div class="ief-link-card">
                                <a class="ief-link-card-icon" href="https://zenodo.org/records/12752350" target="_blank" title="Open link">
                                    <svg viewBox="0 0 24 24"><ellipse cx="12" cy="5" rx="9" ry="3"/><path d="M21 12c0 1.66-4 3-9 3s-9-1.34-9-3"/><path d="M3 5v14c0 1.66 4 3 9 3s9-1.34 9-3V5"/></svg>
                                </a>
                                <span>
                                    <span class="ief-link-card-meta">Global building stock database</span>
                                    <a class="ief-link-card-url" href="https://zenodo.org/records/12752350" target="_blank">zenodo.org/records/12752350</a>
                                    <span class="ief-link-card-desc">Input data and results for building stock transformation scenarios</span>
                                </span>
                            </div>

                        </div>
                    </div>

                    <div class="ief-version-block">
                        <p class="ief-version-heading">v2.4</p>
                        <div class="ief-links">

                            <div class="ief-link-card">
                                <a class="ief-link-card-icon" href="https://doi.org/10.1038/s41467-021-25300-4" target="_blank" title="Open link">
                                    <svg viewBox="0 0 24 24"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
                                </a>
                                <span>
                                    <span class="ief-link-card-meta">Global vehicles &amp; buildings paper · open access</span>
                                    <a class="ief-link-card-url" href="https://doi.org/10.1038/s41467-021-25300-4" target="_blank">doi.org/10.1038/s41467-021-25300-4</a>
                                </span>
                            </div>

                            <div class="ief-link-card">
                                <a class="ief-link-card-icon" href="https://static-content.springer.com/esm/art%3A10.1038%2Fs41467-021-25300-4/MediaObjects/41467_2021_25300_MOESM1_ESM.pdf" target="_blank" title="Open link">
                                    <svg viewBox="0 0 24 24"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
                                </a>
                                <span>
                                    <span class="ief-link-card-meta">Complete model documentation + supplementary</span>
                                    <a class="ief-link-card-url" href="https://static-content.springer.com/esm/art%3A10.1038%2Fs41467-021-25300-4/MediaObjects/41467_2021_25300_MOESM1_ESM.pdf" target="_blank">springer.com (ESM PDF)</a>
                                </span>
                            </div>

                            <div class="ief-link-card">
                                <a class="ief-link-card-icon" href="https://github.com/IndEcol/RECC-ODYM" target="_blank" title="Open link">
                                    <svg viewBox="0 0 24 24"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"/></svg>
                                </a>
                                <span>
                                    <span class="ief-link-card-meta">Python code on GitHub</span>
                                    <a class="ief-link-card-url" href="https://github.com/IndEcol/RECC-ODYM" target="_blank">github.com/IndEcol/RECC-ODYM</a>
                                </span>
                            </div>

                            <div class="ief-link-card">
                                <a class="ief-link-card-icon" href="https://zenodo.org/record/4671644#.YtezrN9CRhE" target="_blank" title="Open link">
                                    <svg viewBox="0 0 24 24"><ellipse cx="12" cy="5" rx="9" ry="3"/><path d="M21 12c0 1.66-4 3-9 3s-9-1.34-9-3"/><path d="M3 5v14c0 1.66 4 3 9 3s9-1.34 9-3V5"/></svg>
                                </a>
                                <span>
                                    <span class="ief-link-card-meta">Input database</span>
                                    <a class="ief-link-card-url" href="https://zenodo.org/record/4671644#.YtezrN9CRhE" target="_blank">zenodo.org/record/4671644</a>
                                </span>
                            </div>

                            <div class="ief-link-card">
                                <a class="ief-link-card-icon" href="https://zenodo.org/record/4698619#.Yte09t9CRhE" target="_blank" title="Open link">
                                    <svg viewBox="0 0 24 24"><line x1="18" y1="20" x2="18" y2="10"/><line x1="12" y1="20" x2="12" y2="4"/><line x1="6" y1="20" x2="6" y2="14"/></svg>
                                </a>
                                <span>
                                    <span class="ief-link-card-meta">Model result database</span>
                                    <a class="ief-link-card-url" href="https://zenodo.org/record/4698619#.Yte09t9CRhE" target="_blank">zenodo.org/record/4698619</a>
                                </span>
                            </div>

                        </div>
                        <p class="ief-commit">
                            Final commit (global paper): <code>9c93d9b</code> &nbsp;·&nbsp; Final commit (Germany): <code>cb3a388</code>
                        </p>
                    </div>

                </section>

            </main>
        </div>
    </div>
</asp:Content>
