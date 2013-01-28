From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 11 new messages
Date: Mon, 28 Jan 2013 19:13:15 +0100
Message-ID: <20130128181315.GB2926@rath-ubuntu>
References: <1359353699-3987-1-git-send-email-ralf.thielow@gmail.com>
 <ke69ta$1e4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jk@jk.gs, stimming@tuhh.de, trast@inf.ethz.ch
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Jan 28 19:13:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TztDD-0003rs-5O
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 19:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757640Ab3A1SNW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2013 13:13:22 -0500
Received: from mail-bk0-f53.google.com ([209.85.214.53]:58676 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757587Ab3A1SNU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 13:13:20 -0500
Received: by mail-bk0-f53.google.com with SMTP id j10so1532004bkw.26
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 10:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wQZDqNzFQP55OmrzMsO070Z6bFG+yL0vvDs4f1x94Zk=;
        b=Qzis8JhhViRSXAHQHh3l+ku5nPfY4JO6TXCBWX9sSrv05wzPncsJzQ2tVR/njW8wXM
         ZaNYOUbjqWTS49K1oy2UEimcnftl6/cRYKPjHHP1N60PG21zZL9UxNbbow20Xu0YOMCo
         UySbemnOFTITqUi22fC3Kg+pORyK4V8H8VcyVrI8bizhmYs1SO/Scj6robNoDU9FvTnv
         xtRPMWnWMHV/+6OAz139GYLcFN7UvzaigRY0hV02VaUUQqMUhu7ZghN0eTZbAiXpWQ/U
         e0eKG8/9iBdmR6aP7RUeiSs/cOMExRoUh81ZL2MCe86VCH+l97DshdNaFheA/uo20jyA
         Fr+Q==
X-Received: by 10.205.122.80 with SMTP id gf16mr1729482bkc.15.1359396798943;
        Mon, 28 Jan 2013 10:13:18 -0800 (PST)
Received: from rath-ubuntu (dslb-094-222-138-000.pools.arcor-ip.net. [94.222.138.0])
        by mx.google.com with ESMTPS id s10sm7064844bkw.3.2013.01.28.10.13.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 10:13:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ke69ta$1e4$1@ger.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214847>

On Mon, Jan 28, 2013 at 05:39:27PM +0100, Joachim Schmitz wrote:
> Ralf Thielow wrote:
> >Translate 11 new messages came from git.pot update
> >in 46bc403 (l10n: Update git.pot (11 new, 7 removed
> >messages)).
> >
> >Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> >---
> > po/de.po | 37 ++++++++++++++++++-------------------
> > 1 file changed, 18 insertions(+), 19 deletions(-)
> >
> >diff --git a/po/de.po b/po/de.po
> >index 3779f4c..ed8330a 100644
> >--- a/po/de.po
> >+++ b/po/de.po
> >@@ -5,7 +5,7 @@
> > #
> > msgid ""
> > msgstr ""
> >-"Project-Id-Version: git 1.8.1\n"
> >+"Project-Id-Version: git 1.8.2\n"
>=20
> Not "Projekt-Id-Version ..."?
>=20

I don't think that we need to translate this.

> > #: builtin/reset.c:33
> > msgid "mixed"
> >@@ -7916,9 +7915,9 @@ msgid "reset HEAD but keep local changes"
> > msgstr "setzt Zweigspitze (HEAD) zur=FCck, beh=E4lt aber lokale
> >=C4nderungen"
>=20
> Not "reset -> setze" and "keep" -> halte (imperativ)?
> Or is the enlish text wrong and should be "resets" and "keeps"
>=20

All translations which describe an option shown by "git <command> -h"
are (or should be) like this. The reading is like "This option..."
followed by such a messages. That's at least how it's done. I don't thi=
nk
it sounds bad.

According to the glossary, the translation here is wrong because "reset=
" is
not "*zur=FCck* setzen" but "neu setzen". I'll fix this (and perhaps ot=
her
messages) on a commit on top.

> Bye, Jojo
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
