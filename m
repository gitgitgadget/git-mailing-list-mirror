From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] git-gui: update Italian translation
Date: Wed, 10 Oct 2007 15:41:33 +0200
Message-ID: <4d8e3fd30710100641p6fc6f610g435d2fe66462c05b@mail.gmail.com>
References: <200710101533.17290.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Michele Ballabio" <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 15:42:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifbox-0002nY-Nd
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 15:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbXJJNlh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2007 09:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752816AbXJJNlh
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 09:41:37 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:14838 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369AbXJJNlf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2007 09:41:35 -0400
Received: by an-out-0708.google.com with SMTP id d31so8332and
        for <git@vger.kernel.org>; Wed, 10 Oct 2007 06:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KVqlF7/tsEszl3d+NRBNImbh4NcxZ2wkR5SfyGYX7l4=;
        b=WnL5k9Y1mDRqlTeVSPDJOu/IIVelAjFn3h5RQFKFZnV9XQ/7SjsDN09gWBGK3v4UEhMXU6m3z1S9BGGvSMbBfJiQW7FmhomF4W6IXM0Xjc5/zzwPiEoBcKmmvZbWGq8i+fNvQYKosZYaTUaHRvpiot8wH7mYVGGP51xbCHVOEB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tpmg0wou3x/cv+Pu5II6yH3HVTdG90yvc3uyYifO3xrIlQNB/EY3PTboJBq69c4Cff8hwvVM0hX0NjhYam074eJ3sEWGDTCiNpNGL6lJw8BoaPchfLuthERtcBmSttdh4iwgb1gXDm0c9U199KHm628TMeRNoNO14+oQPRKoSrw=
Received: by 10.142.217.17 with SMTP id p17mr89825wfg.1192023693305;
        Wed, 10 Oct 2007 06:41:33 -0700 (PDT)
Received: by 10.143.43.21 with HTTP; Wed, 10 Oct 2007 06:41:33 -0700 (PDT)
In-Reply-To: <200710101533.17290.barra_cuda@katamail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60496>

On 10/10/07, Michele Ballabio <barra_cuda@katamail.com> wrote:
[...]
> -msgstr "Caratteri non validi specificati nella gui.%s:"
> +msgstr "Caratteri non validi specificati in %s:"

OK

>  #: git-gui.sh:620
>  msgid "Main Font"
> @@ -56,7 +56,7 @@ msgid ""
>  msgstr ""
>  "La versione di GIT non pu=F2 essere determinata.\n"
>  "\n"
> -"%s sostiene che la versione =E8 '%s'.\n"
> +"%s riporta che la versione =E8 '%s'.\n"

OK

>  "\n"
>  "%s richiede almeno Git 1.5.0 o superiore.\n"
>  "\n"
> @@ -67,9 +67,8 @@ msgid "Git directory not found:"
>  msgstr "Non trovo la directory di git: "
>
>  #: git-gui.sh:860
> -#, fuzzy
>  msgid "Cannot move to top of working directory:"
> -msgstr "Impossibile usare una .git directory strana:"
> +msgstr "Impossibile spostarsi sulla directory principale del progett=
o:"

Really OK :-)

>  #: git-gui.sh:867
>  msgid "Cannot use funny .git directory:"
> @@ -97,23 +96,23 @@ msgstr "Non modificato"
>
>  #: git-gui.sh:1527
>  msgid "Modified, not staged"
> -msgstr "Modificato, non pronto per il commit"
> +msgstr "Modificato, non preparato per l'archiviazione"

I vote for leaving the word commit.
I would be confused by the word "archiviazione".

>  #: git-gui.sh:1528 git-gui.sh:1533
>  msgid "Staged for commit"
> -msgstr "Pronto per il commit"
> +msgstr "Preparato per l'archiviazione"

Ditto.

>  #: git-gui.sh:1529 git-gui.sh:1534
>  msgid "Portions staged for commit"
> -msgstr "Parti pronte per il commit"
> +msgstr "Parti preparate per l'archiviazione"

Ditto.

>  #: git-gui.sh:1530 git-gui.sh:1535
>  msgid "Staged for commit, missing"
> -msgstr "Pronto per il commit, mancante"
> +msgstr "Preparato per l'archiviazione, mancante"

Ditto  (and so on...)

As a general comment... very nice work!

Ciao,
--=20
Paolo
http://paolo.ciarrocchi.googlepages.com/
http://ubuntista.blogspot.com
