From: Michael <barra_cuda@katamail.com>
Subject: Re: [PATCH] Initial  Italian translation of git-gui.pot
Date: Sun, 22 Jul 2007 21:28:05 +0200
Message-ID: <200707222128.05884.barra_cuda@katamail.com>
References: <20070722124236.47baacb1@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 22:08:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IChj0-00061A-5J
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 22:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762152AbXGVUIO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Jul 2007 16:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762070AbXGVUIN
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 16:08:13 -0400
Received: from slim-3c.inet.it ([213.92.5.125]:33306 "EHLO slim-3c.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761403AbXGVUIL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 16:08:11 -0400
X-Greylist: delayed 2417 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Jul 2007 16:08:11 EDT
Received: from host193-57-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.57.193]) by slim-3c.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.57.193+n2aJmXxoaG3; Sun, 22 Jul 2007 21:27:51 +0200
User-Agent: KMail/1.9.4
In-Reply-To: <20070722124236.47baacb1@paolo-desktop>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53309>

On Sunday 22 July 2007 12:42, Paolo Ciarrocchi wrote:
> Initial Italian translation
>=20
> Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>

io userei queste parole:

merge	unione, fusione/unire, fondere
commit	salvataggio/salvare (forse troppo inflazionato)
amend	correzione/correggere
hunk	parte
fetch	prendi da

Per il resto, avrei tradotto pi=F9 o meno come segue. Che ne dici?

> ---
>  po/it.po |  118 +++++++++++++++++++++++++++++++---------------------=
----------
>  1 files changed, 59 insertions(+), 59 deletions(-)
>=20
> diff --git a/po/it.po b/po/it.po
> index e8b8cdb..780519e 100644
> --- a/po/it.po
> +++ b/po/it.po

=2E..

>  #: git-gui.sh:1820 git-gui.sh:2176
>  msgid "Rescan"
> -msgstr ""
> +msgstr "Analizza"

"Riesamina database"?

>  #: git-gui.sh:2229
>  msgid "Amended Commit Message:"
> -msgstr ""
> +msgstr "Annulla messaggio del Commit"

"Correzione del messaggio da salvare:"?

>  #: git-gui.sh:2230
>  msgid "Amended Initial Commit Message:"
> -msgstr ""
> +msgstr "Annulla messaggio iniziale del Commit"

"Correzione del messaggio iniziale:"?

>  #: git-gui.sh:2231
>  msgid "Amended Merge Commit Message:"
> -msgstr ""
> +msgstr "Annulla messaggio di incorporamento"

"Correzione messaggio dell'unione"?

>  #: git-gui.sh:2431
>  msgid "Decrease Font Size"
> -msgstr ""
> +msgstr "Diminuisci dimensione Font"

font -> carattere?

>  #: git-gui.sh:2435
>  msgid "Increase Font Size"
> -msgstr ""
> +msgstr "Aumenta dimensione Font"
> =20
>  #: git-gui.sh:2440
>  msgid "Show Less Context"
> -msgstr ""
> +msgstr "Mostra meno contenuto"

contenuto -> contesto?

>  #: git-gui.sh:2447
>  msgid "Show More Context"
> -msgstr ""
> +msgstr "Mostra pi=F9 contenuto"
