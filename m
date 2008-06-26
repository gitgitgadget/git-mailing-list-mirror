From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] gitk: Add basic French translation
Date: Thu, 26 Jun 2008 08:39:12 +0200
Message-ID: <200806260839.12577.chriscool@tuxfamily.org>
References: <1213852083-31418-1-git-send-email-kibi@debian.org> <1213852083-31418-2-git-send-email-kibi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: paulus@samba.org, git@vger.kernel.org
To: Cyril Brulebois <kibi@debian.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 08:36:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBl5U-0008Gr-56
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 08:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbYFZGfM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jun 2008 02:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752788AbYFZGfM
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 02:35:12 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:53055 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785AbYFZGfK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jun 2008 02:35:10 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 8B5AE1AB2D8;
	Thu, 26 Jun 2008 08:35:09 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 4B4C91AB2C9;
	Thu, 26 Jun 2008 08:35:09 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1213852083-31418-2-git-send-email-kibi@debian.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86405>

Le jeudi 19 juin 2008, Cyril Brulebois a =E9crit :
> Signed-off-by: Cyril Brulebois <kibi@debian.org>
> ---
>  po/fr.po |  904
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 1 file=
s
> changed, 904 insertions(+), 0 deletions(-)
>  create mode 100644 po/fr.po
>
> diff --git a/po/fr.po b/po/fr.po
> new file mode 100644
> index 0000000..d37b2eb
> --- /dev/null
> +++ b/po/fr.po
> @@ -0,0 +1,904 @@
> +# Translation of gitk
> +# This file is distributed under the same license as the gitk packag=
e.
> +# Copyright =C2=A9 2008 Cyril Brulebois <kibi@debian.org>
> +#

[...]

> +
> +#: gitk:2121 gitk:2136 gitk:7211
> +msgid "Diff this -> selected"
> +msgstr ""

msgstr "Diff ceci -> selection"

> +
> +#: gitk:2123 gitk:2138 gitk:7212
> +msgid "Diff selected -> this"
> +msgstr ""

msgstr "Diff selection -> ceci"

> +
> +#: gitk:2125 gitk:2140 gitk:7213
> +msgid "Make patch"
> +msgstr "Cr=C3=A9er patch"
> +
> +#: gitk:2126 gitk:7351
> +msgid "Create tag"
> +msgstr "Cr=C3=A9er tag"
> +
> +#: gitk:2127 gitk:7450
> +msgid "Write commit to file"
> +msgstr ""

msgstr "Enregistrer le commit dans un fichier"

> +
> +#: gitk:2128 gitk:7504
> +msgid "Create new branch"
> +msgstr "Cr=C3=A9er une nouvelle branch"

msgstr "Cr=C3=A9er une nouvelle branche"

> +#: gitk:2129
> +msgid "Cherry-pick this commit"
> +msgstr "Cueillir ce commit"
> +
> +#: gitk:2131
> +msgid "Reset HEAD branch to here"
> +msgstr "R=C3=A9initialiser la branche HEAD ici"
> +
> +#: gitk:2147
> +msgid "Check out this branch"
> +msgstr ""

msgstr "Emprunter cette branche"

[...]

> +#: gitk:2438
> +msgid "<PageUp>\tMove up one page in commit list"
> +msgstr ""

msgstr "<PageUp>\tRemonter d'une page dans la liste des commits"

> +
> +#: gitk:2439
> +msgid "<PageDown>\tMove down one page in commit list"
> +msgstr ""

msgstr "<PageDown>\tRedescendre d'une page dans la liste des commits"

> +#: gitk:2440
> +#, tcl-format
> +msgid "<%s-Home>\tScroll to top of commit list"
> +msgstr ""

msgstr "<%s-Home>\tAller en haut de la liste des commits"

> +#: gitk:2441
> +#, tcl-format
> +msgid "<%s-End>\tScroll to bottom of commit list"
> +msgstr ""

msgstr "<%s-End>\tAller en bas de la liste des commits"

> +#: gitk:2442
> +#, tcl-format
> +msgid "<%s-Up>\tScroll commit list up one line"
> +msgstr ""

msgstr "<%s-Up>\tMonter d'une ligne dans la liste des commits"

> +#: gitk:2443
> +#, tcl-format
> +msgid "<%s-Down>\tScroll commit list down one line"
> +msgstr ""

msgstr "<%s-Down>\tDescendre d'une ligne dans la liste des commits"

> +#: gitk:2444
> +#, tcl-format
> +msgid "<%s-PageUp>\tScroll commit list up one page"
> +msgstr ""

msgstr "<%s-PageUp>\tMonter d'une page dans la liste des commits"

> +#: gitk:2445
> +#, tcl-format
> +msgid "<%s-PageDown>\tScroll commit list down one page"
> +msgstr ""

msgstr "<%s-PageDown>\tDescendre d'une page dans la liste des commits"

> +#: gitk:2446
> +msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
> +msgstr ""

msgstr "<Shift-Up>\tRechercher en arri=E8re (plus haut, commits plus r=E9=
cents)"

> +#: gitk:2447
> +msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
> +msgstr ""

msgstr "<Shift-Down>\tRechercher en avant (plus bas, commits plus ancie=
ns)"

> +#: gitk:2448
> +msgid "<Delete>, b\tScroll diff view up one page"
> +msgstr ""

msgstr "<Delete>, b\tMonter d'une page dans la vue du diff"

> +#: gitk:2449
> +msgid "<Backspace>\tScroll diff view up one page"
> +msgstr ""

msgstr "<Backspace>\tMonter d'une page dans la vue du diff"

> +#: gitk:2450
> +msgid "<Space>\t\tScroll diff view down one page"
> +msgstr ""

msgstr "<Space>\t\tDescendre d'une page dans la vue du diff"

> +#: gitk:2451
> +msgid "u\t\tScroll diff view up 18 lines"
> +msgstr ""

msgstr "u\t\tMonter de 18 lignes dans la vue du diff"

> +#: gitk:2452
> +msgid "d\t\tScroll diff view down 18 lines"
> +msgstr ""

msgstr "d\t\tDescendre de 18 lignes dans la vue du diff"

> +#: gitk:2453
> +#, tcl-format
> +msgid "<%s-F>\t\tFind"
> +msgstr ""

msgstr "<%s-F>\t\tChercher"

> +#: gitk:2454
> +#, tcl-format
> +msgid "<%s-G>\t\tMove to next find hit"
> +msgstr ""

msgstr "<%s-G>\t\tAller =E0 la prochaine occurence"

> +#: gitk:2455
> +msgid "<Return>\tMove to next find hit"
> +msgstr ""

msgstr "<Return>\tAller =E0 la prochaine occurence"

> +#: gitk:2456
> +msgid "/\t\tMove to next find hit, or redo find"
> +msgstr ""

msgstr "/\t\tAller =E0 la prochaine occurence ou recommencer la recherc=
he"

> +#: gitk:2457
> +msgid "?\t\tMove to previous find hit"
> +msgstr ""

msgstr "?\t\tAller =E0 l'occurence pr=E9c=E9dente"


Ok, I stopped reviewing/completing here because I am short on time righ=
t now=20
and anyway I think I should have answered before.

By the way for these po file where there are lots of encoding problem,=20
sending the attached file is ok I think.

Thanks for starting this,
Christian.
