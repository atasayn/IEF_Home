<%@ Page Title="Legal Notes" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="legal.aspx.cs" Inherits="IEF_Home.Legal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">
    <script>
        function change_language(show, hide) {
            Array.from(document.getElementsByClassName("lang-" + show)).forEach(el => el.style.display = "block");
            Array.from(document.getElementsByClassName("lang-" + hide)).forEach(el => el.style.display = "none");
        }
    </script>
    <style type="text/css">
        thead, tbody tr:nth-child(2n) {
            background-color: #eeeeee;
        }

        .lang-de {
            display: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="lang-changer">
        <img src="resources/flag-germany.png" width="30" alt="de flag" title="Deutsch" onclick="change_language('de', 'en');"/>
        <img src="resources/flag-england.png" width="30" alt="uk flag" title="English" onclick="change_language('en', 'de');"/>
    </div>
    <a href="#impressum" class="lang-en">&#x2794; To legal notes</a>
    <a href="#impressum" class="lang-de">&#x2794; Zum Impressum</a>
    <div id="privacy">
        <div class="lang-en">
            <h2>Privacy Policy</h2>
            The chair of industrial ecology is part of University Freiburg. This privacy policy will explain how we use the personal data we collect from you when you use our website. 

    <h3>Topics:</h3>
            <ol>
                <li>What data do we collect?</li>
                <li>What are your data protection rights?</li>
                <li>How to manage your cookies</li>
                <li>Privacy policies of other websites</li>
                <li>Changes to our privacy policy</li>
                <li>How to contact us</li>
                <li>How to contact the appropriate authorities</li>
            </ol>

            <h3>What data do we collect?</h3>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <td>Whose data</td>
                            <td>What data</td>
                            <td>from WHERE</td>
                            <td>For what</td>
                            <td>How long</td>
                            <td>Why</td>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Visitors of the page</td>
                            <td>IP address, browser and operating system of the requester, date and time, name and url of the requested file</td>
                            <td>Your request</td>
                            <td>Manual analysis of faults, errors and security incidents</td>
                            <td>14 days</td>
                            <td>Art. 6 II f GDPR (legitimate interest)</td>
                        </tr>
                        <tr>
                            <td>Users with accounts</td>
                            <td>Username, name, email, workplace/institution, login cookie</td>
                            <td>Your registration</td>
                            <td>Usage of the internal services</td>
                            <td>Until account is deleted</td>
                            <td>Art. 6 II b GDPR (contract)</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <h3>What are your data protection rights?</h3>
            We would like to make sure you are fully aware of all of your data protection rights. Every user is entitled to the following:
    <ul>
        <li>The right to access – You have the right to request us for copies of your personal data free of charge.</li>
        <li>The right to rectification – You have the right to request that we correct any information you believe is inaccurate. You also have the right to reuest us to complete the information you believe is incomplete.</li>
        <li>The right to erasure – You have the right to request that we erase your personal data, under certain conditions.</li>
        <li>The right to restrict processing – You have the right to request that we restrict the processing of your personal data, under certain conditions.</li>
        <li>The right to object to processing – You have the right to object to our processing of your personal data, under certain conditions.</li>
        <li>The right to data portability – You have the right to request that we transfer the data that we have collected to another organization, or directly to you, under certain conditions.</li>
    </ul>
            If you make a request, we have one month to respond to you. If you would like to exercise any of these rights, please contact us at our email: <a href="mailto://datenschutz@uni-freiburg.de">datenschutz@uni-freiburg.de</a>

            <h3>Privacy policies of other websites</h3>
            Our website contains links to other websites. Our privacy policy applies only to our website, so if you click on a link to another website, you should read their privacy policy.

    Additionally, our website includes content of Twitter Inc. For more information about their privacy policy please visit <a href="https://twitter.com/en/privacy">https://twitter.com/en/privacy</a>.

    <h3>Changes to our privacy policy</h3>
            We keep its privacy policy under regular review and places any updates on this web page. This privacy policy was last updated on 22th July 2022.

    <h3>How to contact us</h3>
            </p>If you have any questions about our privacy policy, the data we hold on you, or you would like to exercise one of your data protection rights, please do not hesitate to contact us via email: <a href="mailto://datenschutz@uni-freiburg.de">datenschutz@uni-freiburg.de</a></p>
    
    <p>Responsible for the data processing is:</p>

            <p>
                <b>Juniorprofessur für Nachhaltiges Energie- und Stoffstrommanagement, Albert-Ludwigs-Universität Freiburg</b><br />
                Tennenbacher Straße 4<br />
                79106 Freiburg<br />
                Telephone: +49-761-203-98726<br />
                Email: in4mation@indecol.uni-freiburg.de
            </p>

            <h3>How to contact the appropriate authority</h3>
            <p>Should you wish to report a complaint or if you feel that we have not addressed your concern in a satisfactory manner, you may contact the Information Commissioner’s Office:</p>
            <p>
                <b>Der Landesbeauftragte für den Datenschutz und die Informationsfreiheit Baden-Württemberg</b><br />
                Telephone:	+49 711/61 55 41 – 0<br />
                Telefax:	+49 711/61 55 41 – 15<br />
                Email:	poststelle@lfdi.bwl.de
            </p>
        </div>
        <div class="lang-de">
            <h2>Datenschutzinformation</h2>
            Die Professur für Nachhaltiges Energie- und Stoffstrommanagement ist Teil der Albert-Ludwigs-Universität Freiburg. Diese Datenschutzrichtlinie erläutert, wie wir die personenbezogenen Daten verwenden, die wir von Ihnen bei der Nutzung unserer Website erheben.

    <h3>Themen:</h3>
            <ol>
                <li>Welche Daten erheben wir?</li>
                <li>Was sind Ihre Datenschutzrechte?</li>
                <li>So verwalten Sie Ihre Cookies</li>
                <li>Datenschutzrichtlinien anderer Websites</li>
                <li>Änderungen unserer Datenschutzrichtlinie</li>
                <li>So erreichen Sie uns</li>
                <li>So kontaktieren Sie die zuständigen Behörden</li>
            </ol>

            <h3>Welche Daten erheben wir?</h3>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <td>Wessen Daten</td>
                            <td>Welche Daten</td>
                            <td>Woher</td>
                            <td>Wofür</td>
                            <td>Wie lange</td>
                            <td>Warum</td>
                        </tr>
                        </thead>
            <tbody>
                <tr>
                    <td>Besucher der Seite</td>
                    <td>IP-Adresse, Browser und Betriebssystem des Anfragenden, Datum und Uhrzeit, Name und URL der angeforderten Datei</td>
                    <td>Ihre Anfrage</td>
                    <td>Manuelle Analyse von Störungen, Fehlern und Sicherheitsvorfällen</td>
                    <td>14 Tage</td>
                    <td>Art. 6 II f DSGVO (berechtigtes Interesse)</td>
                </tr>
                <tr>
                    <td>Benutzer mit Konten</td>
                    <td>Benutzername, Name, E-Mail, Arbeitsplatz/Institution, Login-Cookie</td>
                    <td>Ihre Registrierung</td>
                    <td>Nutzung der internen Dienste</td>
                    <td>Bis das Konto gelöscht wird</td>
                    <td>Art. 6 II b DSGVO (Vertrag)</td>
                </tr>
            </tbody>
                </table>
            </div>
            <h3>Was sind Ihre Datenschutzrechte?</h3>
            Wir möchten sicherstellen, dass Sie sich all Ihrer Datenschutzrechte voll bewusst sind. Jeder Benutzer hat Anspruch auf:
    <ul>
        <li>Das Auskunftsrecht – Sie haben das Recht, uns um kostenlose Kopien Ihrer personenbezogenen Daten zu bitten.</li>
        <li>Das Recht auf Berichtigung – Sie haben das Recht zu verlangen, dass wir alle Informationen korrigieren, die Sie für unrichtig halten. Sie haben auch das Recht Informationen zu ergänzen, die Sie für unvollständig halten.</li>
        <li>Das Recht auf Löschung – Sie haben das Recht zu verlangen, dass wir Ihre personenbezogenen Daten unter bestimmten Bedingungen löschen.</li>
        <li>Das Recht auf Einschränkung der Verarbeitung – Sie haben das Recht zu verlangen, dass wir die Verarbeitung Ihrer personenbezogenen Daten unter bestimmten Bedingungen einschränken.</li>
        <li>Das Recht, der Verarbeitung zu widersprechen – Sie haben unter bestimmten Bedingungen das Recht, unserer Verarbeitung Ihrer personenbezogenen Daten zu widersprechen.</li>
        <li>Das Recht auf Datenübertragbarkeit – Sie haben das Recht zu verlangen, dass wir die von uns gesammelten Daten unter bestimmten Bedingungen an eine andere Organisation oder direkt an Sie übertragen.</li>
    </ul>
            Wenn Sie eine Anfrage stellen, haben wir einen Monat Zeit, um Ihnen zu antworten. Wenn Sie eines dieser Rechte ausüben möchten, kontaktieren Sie uns bitte unter unserer E-Mail: <a href="mailto://datenschutz@uni-freiburg.de">datenschutz@uni-freiburg.de</a>

            <h3>Datenschutzrichtlinien anderer Websites</h3>
            Unsere Website enthält Links zu anderen Websites. Unsere Datenschutzrichtlinie gilt nur für unsere Website. Wenn Sie also auf einen Link zu einer anderen Website klicken, sollten Sie deren Datenschutzrichtlinie lesen.

    Außerdem enthält unsere Website Inhalte von Twitter Inc. Weitere Informationen zu deren Datenschutzrichtlinien finden Sie unter <a href="https://twitter.com/en/privacy">https://twitter.com/en/privacy</a>.

    <h3>Änderungen unserer Datenschutzrichtlinie</h3>
            Wir überprüfen unsere Datenschutzrichtlinie regelmäßig und veröffentlichen alle Aktualisierungen auf dieser Webseite. Diese Datenschutzrichtlinie wurde zuletzt am 22. Juli 2022 aktualisiert.

    <h3>So erreichen Sie uns</h3>
            </p>Wenn Sie Fragen zu unserer Datenschutzrichtlinie oder den Daten haben, die wir über Sie speichern, oder wenn Sie eines Ihrer Datenschutzrechte ausüben möchten, zögern Sie bitte nicht, uns per E-Mail zu kontaktieren: <a href="mailto ://datenschutz@uni-freiburg.de">datenschutz@uni-freiburg.de</a></p>
    
    <p>Verantwortlicher für die Datenverarbeitung ist:</p>

            <p>
                <b>Juniorprofessur für Nachhaltiges Energie- und Stoffstrommanagement, Albert-Ludwigs-Universität Freiburg</b><br />
                Tennenbacher Straße 4<br />
                79106 Freiburg<br />
                Telefon: +49-761-203-98726<br />
                E-Mail: in4mation@indecol.uni-freiburg.de
            </p>

            <h3>So kontaktieren Sie die zuständige Behörde</h3>
            <p>
                Falls Sie eine Beschwerde melden möchten oder der Meinung sind, dass wir Ihr Anliegen nicht zufriedenstellend behandelt haben, können Sie sich an den Landesdatenschutzbeauftragten wenden:
                Büro:</p>
            <p>
                <b>Der Landesbeauftragte für den Datenschutz und die Informationsfreiheit Baden-Württemberg</b><br />
                Telefon: +49 711/61 55 41 – 0<br />
                Telefax: +49 711/61 55 41 – 15<br />
                E-Mail: poststelle@lfdi.bwl.de
            </p>
        </div>
    </div>
    <div id="impressum">
        <div class="lang-de">
            <h2>Impressum</h2>
            <h3>Herausgeber</h3>
            Professur für Nachhaltiges Energie- und Stoffstrommanagement

        <h3>Anschrift</h3>
            Fakultät für Umwelt und Natürliche Ressourcen<br />
            Albert-Ludwigs-Universität Freiburg<br />
            Tennenbacher Straße 4<br />
            79106 Freiburg

        <h3>Kontakt</h3>
            Telefon: +49-761-203-98762<br />
            in4mation@indecol.uni-freiburg.de<br />
            https://www.indecol.uni-freiburg.de

        <h3>Copyright-Hinweis zu Fotos und Graphiken</h3>
            Alle verwendeten Bilder, soweit nicht anders ausgezeichnet: Copyright Albert-Ludwigs-Universität Freiburg
            Länderflaggen: Awalhs, <a href="https://creativecommons.org/licenses/by-sa/4.0">CC BY-SA 4.0</a>, via Wikimedia Commons

        <h3>Haftungsausschluss bei eigenen Inhalten</h3>
            Die Inhalte dieser Website werden mit größtmöglicher Sorgfalt recherchiert und implementiert. Fehler im Bearbeitungsvorgang sind dennoch nicht auszuschließen. Hinweise und Korrekturen senden Sie bitte an die o.g. Emailadresse. Eine Haftung für die Richtigkeit, Vollständigkeit und Aktualität dieser Webseiten wird nicht übernommen.

        <h3>Haftungsausschluss bei Querverweisen und Links</h3>
            Durch Hyperlinks verweist diese Seite auf Inhalte anderer Anbieter. Diese fremden Inhalte stammen weder von der Universität Freiburg, noch hat die Universität Freiburg die Möglichkeit, den Inhalt von Seiten Dritter zu beeinflussen. Die Inhalte fremder Seiten, auf die die Universität Freiburg mittels Links hinweist, spiegeln nicht die Meinung der Universität Freiburg wieder, sondern dienen lediglich der Information und der Darstellung von Zusammenhängen. Diese Feststellungen gelten für alle innerhalb des eigenen Internetangebotes gesetzten Links und Verweise sowie für Fremdeinträge in von der Universität Freiburg eingerichteten Gästebüchern, Diskussionsforen und Mailinglisten. Für illegale, fehlerhafte oder unvollständige Inhalte und insbesondere für Schäden, die aus der Nutzung oder Nichtnutzung solcherart dargebotener Informationen entstehen, haftet allein der Anbieter der Seite, auf welche verwiesen wurde.
        </div>
        <div class="lang-en">
            <h2>Legal Notes</h2>
            <h3>Publisher</h3>
            Group for sustainable energy and material flow management

            <h3>Address</h3>
            Faculty of Environment and Natural Resources<br />
            University of Freiburg<br />
            Tennenbacher Strasse 4<br />
            79106 Friburg

            <h3>Contact</h3>
            Telephone: +49-761-203-98762<br />
            in4mation@indecol.uni-freiburg.de<br />
            https://www.indecol.uni-freiburg.de

            <h3>Copyright notice on photos and graphics</h3>
            All images used, unless otherwise noted: Copyright Albert-Ludwigs-Universität Freiburg<br/>
            Country flags: Awalhs, <a href="https://creativecommons.org/licenses/by-sa/4.0">CC BY-SA 4.0</a>, via Wikimedia Commons

            <h3>Disclaimer for own content</h3>
            The contents of this website are researched and implemented with the greatest possible care. However, errors in the processing process cannot be ruled out. Please send notes and corrections to the above email address. No liability is assumed for the correctness, completeness and topicality of these websites.

            <h3>Disclaimer for cross-references and links</h3>
            This site refers to content from other providers through hyperlinks. This third-party content does not originate from the University of Freiburg, nor does the University of Freiburg have the ability to influence the content of third-party sites. The content of third-party sites to which the University of Freiburg refers via links does not reflect the opinion of the University of Freiburg, but only serves to provide information and to show context. These statements apply to all links and references set within our own website as well as to third-party entries in guest books, discussion forums and mailing lists set up by the University of Freiburg. The provider of the page to which reference is made is solely liable for illegal, incorrect or incomplete content and in particular for damage resulting from the use or non-use of information presented in this way.
        </div>
    </div>
</asp:Content>
