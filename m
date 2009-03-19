From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git-gui: various French translation fixes
Date: Thu, 19 Mar 2009 06:09:25 +0100
Message-ID: <200903190609.25344.chriscool@tuxfamily.org>
References: <20090318205410.GA900@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
To: Sam Hocevar <sam@zoy.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 06:11:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkAXp-0002sC-Tl
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 06:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbZCSFKZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 01:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbZCSFKX
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 01:10:23 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:58698 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbZCSFKW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 01:10:22 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id DEE964C8068;
	Thu, 19 Mar 2009 06:10:13 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 8FC0B4C80A7;
	Thu, 19 Mar 2009 06:10:10 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20090318205410.GA900@zoy.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113717>

Le mercredi 18 mars 2009, Sam Hocevar a =E9crit :
> Mostly grammar, spelling and typography fixes, but also a few wording
> enhancements here and there.

It looks mostly good to me.

> Signed-off-by: Sam Hocevar <sam@zoy.org>
> ---
>  po/fr.po |  196
> +++++++++++++++++++++++++++++++------------------------------- 1 file=
s
> changed, 98 insertions(+), 98 deletions(-)
>
>  #: git-gui.sh:2484 lib/index.tcl:410
>  msgid "Revert Changes"
> -msgstr "Annuler les modifications (revert)"
> +msgstr "R=E9voquer les modifications"

I am not sure that "R=E9voquer" is better than "Annuler".

[...]

>  #: lib/index.tcl:326
>  msgid "Ready to commit."
> @@ -1719,18 +1719,18 @@ msgstr "Ajout de %s"
>  #: lib/index.tcl:396
>  #, tcl-format
>  msgid "Revert changes in file %s?"
> -msgstr "Annuler les modifications dans le fichier %s ? "
> +msgstr "R=E9voquer les modifications dans le fichier %s ? "
>
>  #: lib/index.tcl:398
>  #, tcl-format
>  msgid "Revert changes in these %i files?"
> -msgstr "Annuler les modifications dans ces %i fichiers ?"
> +msgstr "R=E9voquer les modifications dans ces %i fichiers ?"
>
>  #: lib/index.tcl:406
>  msgid "Any unstaged changes will be permanently lost by the revert."
>  msgstr ""
>  "Toutes les modifications non-index=E9es seront d=E9finitivement per=
dues par
> " -"l'annulation."
> +"la r=E9vocation."

Same thing for the 3 strings above.

[...]

>  #: lib/index.tcl:427
>  msgid "Reverting selected files"
> -msgstr "Annuler modifications dans fichiers selectionn=E9s"
> +msgstr "R=E9vocation en cours des fichiers selectionn=E9s"
>
>  #: lib/index.tcl:431
>  #, tcl-format
>  msgid "Reverting %s"
> -msgstr "Annulation des modifications dans %s"
> +msgstr "R=E9vocation en cours de %s"

Same thing above.

>  #: lib/remote_branch_delete.tcl:47
>  msgid "From Repository"
> @@ -2244,7 +2244,7 @@ msgid ""
>  "One or more of the merge tests failed because you have not fetched =
the
> " "necessary commits.  Try fetching from %s first."
>  msgstr ""
> -"Une ou plusieurs des tests de fusion ont =E9chou=E9s parce que vous=
 n'avez
> pas "
> +"Un ou plusieurs des tests de fusion ont =E9chou=E9 parce que vous=20
> n'avez pas "
> "r=E9cup=E9r=E9 les commits n=E9cessaires. Essayez de r=E9cup=E9r=E9 =
=E0=20
> partir de %s d'abord."

The last "r=E9cup=E9r=E9" should be changed to "r=E9cup=E9rer".

Thanks,
Christian.
