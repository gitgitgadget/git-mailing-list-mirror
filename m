From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: gitk : french translation
Date: Wed, 11 Nov 2009 01:10:50 +0100
Message-ID: <20091111001050.GC27518@vidovic>
References: <9f50533b0911060605p6ad28ad9neac3620a1809c3db@mail.gmail.com> <9f50533b0911100945l2c3b7399w1d72771fd2cf8df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Maximilien Noal <noal.maximilien@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nicolas Pitre <nico@fluxnic.net>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Thomas Moulard <thomas.moulard@gmail.com>,
	Guy Brand <gb@unistra.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Emmanuel Trillaud <etrillaud@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 01:11:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N80ni-0002ZC-KY
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 01:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbZKKAKy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Nov 2009 19:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbZKKAKx
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 19:10:53 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:42201 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbZKKAKw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 19:10:52 -0500
Received: by ewy3 with SMTP id 3so653664ewy.37
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 16:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8cQgWjReEB21ZwODqKKUje4rBHixKi+KI9b0pUtli/E=;
        b=Wry7PDN7yVzcUkjWhfd7xo4FBfaM1EHPAxaUDS6tB4ugfC3fv872oMHwi55TFhhw0x
         MsEOaMsqqnxL8FkWRf/J3z9+bg9FRr4/LUNmjFZkmOcvLWi/kXib2yX7sRiBH32ccLh7
         +yxtGBG698NMZL4bYeqlWJipa5xej6MkclHBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Z/AKug4+h1cX+hVU2M1bn9+0Kch7jr7jJbjU4Jk+PG5SlwIRsdWKKs2c5OqKM9wP/k
         BmOIi+mkEzb9oN0Wm+xE50yS08mPPsmO+bm8MFywq3bmN9g4U1Cr0hBV9I85dVI+ZSU4
         xrEaVG7d2cJKfgrSm/Pymh1REmL1qytTTTRoQ=
Received: by 10.213.63.75 with SMTP id a11mr4168949ebi.63.1257898256679;
        Tue, 10 Nov 2009 16:10:56 -0800 (PST)
Received: from @ (91-164-133-202.rev.libertysurf.net [91.164.133.202])
        by mx.google.com with ESMTPS id 10sm2889427eyz.19.2009.11.10.16.10.52
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 16:10:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9f50533b0911100945l2c3b7399w1d72771fd2cf8df@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132605>

The 10/11/09, Emmanuel Trillaud wrote:

> +"Last-Translator: YOUR NAME <E-MAIL@ADDRESS>\n"
> +"Language-Team: FRENCH\n"

Please, fill in these fields.

> +#: gitk:337
> +msgid "No files selected: --merge specified but no files are unmerge=
d."
> +msgstr "Aucun fichier s=E9lectionn=E9 : --merge pr=E9cis=E9, mais to=
us les
> fichiers sont fusionn=E9s."

Line wraping error; configure your mail user agent to not wrap lines,
please.

> +#FIXME : am=E9liorer la traduction de 'file limite'

If you add some FIXME (which is good), you also should mark the
translation as "fuzzy" like this:

> +#: gitk:340

#, fuzzy

> +msgid ""
> +"No files selected: --merge specified but no unmerged files are with=
in file "
> +"limit."
> +msgstr "Aucun fichier s=E9lectionn=E9 : --merge pr=E9cis=E9 mais auc=
un
> fichier non fusionn=E9 n'est dans la limite des fichiers."

<...>

> +#: gitk:1437
> +msgid "Can't parse git log output:"
> +msgstr "Impossible de lire le r=E9sultat de git log :"

s/le r=E9sultat/la sortie/

> +#: gitk:1793 gitk:1817 gitk:3916 gitk:8786 gitk:10322 gitk:10498
> +msgid "OK"
> +msgstr "OK"

This one should not be required.

> +#: gitk:1934
> +msgid "New view..."
> +msgstr "Nouvelle vue ..."

s/vue /vue/

> +#: gitk:2099 gitk:2101
> +msgid "Exact"
> +msgstr "Exact"

This one should not be required.

> +#: gitk:2215
> +msgid "Patch"
> +msgstr "Patch"

Ditto.

> +#: gitk:2366 gitk:8604
> +msgid "Create new branch"
> +msgstr "Cr=E9er nouvelle branche"

"Cr=E9er une nouvelle branche"

> +#: gitk:2368
> +msgid "Reset HEAD branch to here"
> +msgstr "R=E9initialiser la branch HEAD vers cet =E9tat"

"branche" (missing "e").

> +#: gitk:2656
> +msgid ""
> +"\n"
> +"Gitk - a commit viewer for git\n"
> +"\n"
> +"Copyright =A9 2005-2008 Paul Mackerras\n"
> +"\n"
> +"Use and redistribute under the terms of the GNU General Public Lice=
nse"
> +msgstr ""
> +"\n"
> +"Gitk - visualisateur de commit pour git\n"
> +"\n"
> +"Copyright =A9 2005-2008 Paul Mackerras\n"
> +"\n"
> +"Utilisation et redistribution soumis aux termes de la GNU General
> Public License"

"soumises"

> +#: gitk:2693
> +msgid "<Left>, z, j\tGo back in history list"
> +msgstr "<Gauche>, z, j\tAvancer dans l'historique"

s/Avancer/Reculer/

> +#: gitk:2694
> +msgid "<Right>, x, l\tGo forward in history list"
> +msgstr "<Droite>, x, l\tRemonter dans l'historique"

s/Remonter/Avancer/

> +#: gitk:2713
> +msgid "/\t\tFocus the search box"
> +msgstr "/"

No idea?

> +#: gitk:3401
> +msgid "No such commit"
> +msgstr "commit inexistant"

s/commit/Commit/

> +#: gitk:3415
> +msgid "git gui blame: command failed:"
> +msgstr "git gui blame : =E9chec de la commande"

Missing ending " :".

> +#: gitk:3446
> +#, tcl-format
> +msgid "Couldn't read merge head: %s"
> +msgstr "Impossible de lire le head de la fusion: %s"

s/fusion/fusion /

> +#: gitk:3479
> +#, tcl-format
> +msgid "Couldn't start git blame: %s"
> +msgstr "impossible de d=E9marrer git blame : %s"

s/impossible/Impossible/

> +#: gitk:3679
> +msgid "References (space separated list):"
> +msgstr "R=E9f=E9rences (liste d'=E9l=E9ments s=E9parer par des espac=
es) :"

s/s=E9parer/s=E9par=E9s/

> +#: gitk:3684
> +msgid "All remote-tracking branches"
> +msgstr "Toutes les branches de suivie distante"

"Toutes les branches de suivi distantes"

> +#: gitk:3687
> +msgid "Committer:"
> +msgstr "Committer :"

"Commiter"

> +#: gitk:3690
> +msgid "Changes to Files:"
> +msgstr "Changements des fichiers"

Missing ":".

> +#: gitk:3695
> +msgid "Since:"
> +msgstr "Depuis :"

"De :"

> +# FIXME : traduction de "skip"

"=E9viter"?

> +#: gitk:3697
> +msgid "Limit and/or skip a number of revisions (positive integer):"
> +msgstr "Limiter et/ou sauter un certain nombre (entier positif) de r=
=E9vision :"
                                                                       =
       ^

"Limiter et/ou =E9viter un certain nombre (entier positif) de r=E9visio=
ns :"

> +#: gitk:3699
> +msgid "Number to skip:"
> +msgstr "Nombre =E0 sauter :"

"=E9viter"?

> +#FIXME : traduction de "branch sides"
> +#: gitk:3702

#, fuzzy

> +msgid "Mark branch sides"
> +msgstr "Marquer le flanc des branches"

What about "c=F4t=E9"?

> +#: gitk:3837
> +msgid "-- criteria for selecting revisions"
> +msgstr "-- crit=E8re pour la s=E9l=E9ction des r=E9visions"

"s=E9lection"

> +#: gitk:3955
> +msgid "Error in commit selection arguments:"
> +msgstr "Erreur dans les arguments de s=E9lection des commits"

Missing ":".

> +#: gitk:4456 gitk:6303 gitk:8065 gitk:8080
> +msgid "Date"
> +msgstr "Date"

Should not be required.

> +#: gitk:4456 gitk:6303
> +msgid "CDate"
> +msgstr "CDate"

Ditto.

> +#: gitk:4605 gitk:4610
> +msgid "Descendant"
> +msgstr "Descendant"

Ditto.

> +#FIXME : plut=F4t traduire par "pas un descendant"
> +#: gitk:4606

#, fuzzy

> +msgid "Not descendant"
> +msgstr "Non descendant"

<...>

> +#FIXME : plut=F4t traduire par "pas un anc=EAtre"
> +#: gitk:4614

#, fuzzy

> +msgid "Not ancestor"
> +msgstr "Non anc=EAtre"

<...>

> +#: gitk:4904
> +msgid "Local changes checked in to index but not committed"
> +msgstr "Modifications locales enregistr=E9es dans l'index mais non c=
omitt=E9es"

"commit=E9es"

> +#: gitk:4940
> +msgid "Local uncommitted changes, not checked in to index"
> +msgstr "Modifications locales non enregistr=E9es dans l'index et non=
 committ=E9es"

Ditto.

> +#: gitk:6822 gitk:6828 gitk:8058
> +msgid "Parent"
> +msgstr "Parent"

Should not be required.

> +#: gitk:7926
> +#, tcl-format
> +msgid "Revision %s is not in the current view"
> +msgstr "R=E9vision %s n'est pas dans la vue courante"

s/R=E9vision/ La r=E9vision/

> +#: gitk:8127
> +msgid "Detached head: can't reset"
> +msgstr "Head d=E9tach=E9e: impossible de r=E9initialiser"

"d=E9tach=E9" instead of "d=E9tach=E9e" is better FMPOV.

> +#: gitk:8236 gitk:8242
> +msgid "Skipping merge commit "
> +msgstr "Sauter le commit de la fusion "

"=C9viter le commit de fusion "

> +#: gitk:8262 gitk:8265 gitk:8273 gitk:8283 gitk:8292
> +msgid "Commit "
> +msgstr "Commit "

Should not be required.

> +#: gitk:8274
> +msgid ""
> +" differs from\n"
> +"       "
> +msgstr ""
> +"diff=E8re de\n"

Miss the space at the begining?

> +#: gitk:8483
> +msgid "Error creating tag:"
> +msgstr "Erreur =E0 la cr=E9ation du tag"

Missing ":".

> +#: gitk:8705
> +#, tcl-format
> +msgid "Commit %s is already included in branch %s -- really re-apply=
 it?"
> +msgstr "Commit %s est d=E9j=E0 inclus dans la branche %s -- faut-il
> vraiment le r=E9-appliquer?"

Peut-=EAtre :

"r=E9-appliquer malgr=E9 tout ?"

> +#: gitk:8719
> +#, tcl-format
> +msgid ""
> +"Cherry-pick failed because of local changes to file '%s'.\n"
> +"Please commit, reset or stash your changes and try again."
> +msgstr "La cueillette a =E9chou=E9e =E0 cause de modifications local=
e au
> fichier '%s'.\n"

s/locale/locales/

> +"Veuillez committer, reset ou stash vos changements et essayer de no=
uveau."

s/committer/commiter/
s/reset/r=E9initialiser/ (for consistency with this whole translation)
s/stash/stasher/

> +#: gitk:8741
> +msgid "No changes committed"
> +msgstr "Aucun changement committer"

"Aucun changement commit=E9"

> +# FIXME: faut-il traduire working tree par r=E9pertoire de travail o=
u
> arbre de travail?
> +# FIXME : traduction de Soft/Hard/Mixed
> +#: gitk:8777
> +msgid "Soft: Leave working tree and index untouched"
> +msgstr "Douce: Laisse l'arbre de travail et l'index dans leur =E9tat=
 courant"

"L=E9ger : laisse les fichiers du work tree et l'index intacts"

> +#: gitk:8780
> +msgid "Mixed: Leave working tree untouched, reset index"
> +msgstr "Hybride: Laisse l'arbre de travail dans son =E9tat courant,
> r=E9initialise l'index"

"Hybride : ne touche pas aux fichiers du work tree, r=E9initialise l'in=
dex"

> +#: gitk:8783
> +msgid ""
> +"Hard: Reset working tree and index\n"
> +"(discard ALL local changes)"
> +msgstr ""
> +"Dur: R=E9initialise l'arbre de travail et l'index\n"

"R=E9initialise le work tree et l'index"

> +"(abandonne TOUS les changements locaux)"

<...>

> +#: gitk:8857

#, fuzzy

> +msgid "Checking out"
> +msgstr "R=E9cup=E9ration"

<...>

> +#: gitk:9257
> +msgid ""
> +"Error reading commit topology information; branch and preceding/fol=
lowing "
> +"tag information will be incomplete."
> +msgstr ""
> +"Erreur =E0 la lecture des informations sur la topology des commits.=
 "

s/topology/topologie/
s/./ ;/

> +"Les informations sur les branches et les tags pr=E9c=E9dents/suivan=
t "

s/L/l/

> +"seront incompl=E8tes."
> +
> +#: gitk:10243
> +msgid "Tag"
> +msgstr "Tag"

Should not be required.

> +#: gitk:10243
> +msgid "Id"
> +msgstr "Id"

Ditto.

> +#: gitk:10308
> +msgid "B"
> +msgstr "B"

Ditto.

> +#: gitk:10311
> +msgid "I"
> +msgstr "I"

Ditto.

> +#FIXME : Traduction standard de "pane"?
> +#: gitk:10416

#, fuzzy

> +#, tcl-format
> +msgid "Maximum graph width (% of pane)"
> +msgstr "Longueur maximum du graphe (% du panneau)"

<...>

> +#: gitk:10441
> +msgid "Support per-file encodings"
> +msgstr "Support pour un encodage de caract=E8re par fichier"

s/de caract=E8re/ des caract=E8res/

> +#: gitk:10449
> +msgid "Choose..."
> +msgstr "Choisir ..."

No space.

> +#: gitk:10475
> +msgid "Diff: hunk header"
> +msgstr "Diff=E9rences : ent=EAte de l'extrait"

"diff : ent=EAte du hunk"

> +#: gitk:10477
> +msgid "diff hunk header"
> +msgstr "diff=E9rences : ent=EAte de l'extrait"

Ditto.

> +#: gitk:10973
> +msgid ""
> +"Sorry, gitk cannot run with this version of Tcl/Tk.\n"
> +" Gitk requires at least Tcl/Tk 8.4."
> +msgstr ""
> +"D=E9sol=E9, gitk ne peut =EAtre ex=E9cut=E9 par cette version de Tc=
l/Tk.\n"
> +" Gitk requiert Tcl/Tk version 8.4 ou sup=E9rieur."

s/par/avec/

--=20
Nicolas Sebrecht
