From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/2] po/de.po: add German translation
Date: Mon, 6 Sep 2010 17:15:02 +0000
Message-ID: <AANLkTi=nwF5s4kWMrmFWmm_LCjgA2vFe_yc+f2nh1POJ@mail.gmail.com>
References: <AANLkTi=6ctLp-8FeqOGMZuhwvM_7DbaEp7+LK4nXfCaE@mail.gmail.com>
	<4c8197ab.1707e30a.3f10.714a@mx.google.com>
	<201009061741.27840.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Sam Reed <sam@reedyboy.net>, Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Sep 06 19:15:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsfHi-0008DI-NM
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 19:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693Ab0IFRPG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 13:15:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33765 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503Ab0IFRPE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 13:15:04 -0400
Received: by iwn5 with SMTP id 5so4410711iwn.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 10:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A67A0kwInm8ZCFkKej0AS1UnDtenri4+5zmVXd7DaxI=;
        b=Pd0qrRjLiaut2pDVLQlOzHI7f7A6RsVPO5Te4WxLFKYVNgRvb8GUHbXCJcSGthfKj3
         rOL1H1b/zcZnMqw/43fT2NeQj4uGBp4SfgujO9uMagbVaooHukRhDIChfY7WlwUiRlRG
         5eTltgMTU58Z+jJ2FDVVQp4SVe6DwdSN1p6K4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NI0btn58j4IFfBJWBNYyYUQJv/P5FgR689Y5l22truYjzb7dJRUUZp5fZtqV47Hyr5
         uztyElPojPTGHr5DETvFOPnH7mfPvb3L18ZJ1oHBKiAAOVh0YP9FS0m5Z5WQBT/8JJAz
         alq3+3Qw9Ihg8XwYn2meYVWozkQcQQyBmVwX0=
Received: by 10.231.176.79 with SMTP id bd15mr6599015ibb.151.1283793302832;
 Mon, 06 Sep 2010 10:15:02 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 6 Sep 2010 10:15:02 -0700 (PDT)
In-Reply-To: <201009061741.27840.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155585>

On Mon, Sep 6, 2010 at 15:41, Thomas Rast <trast@student.ethz.ch> wrote=
:
> Hi Jan
>
> First off thanks for taking on the mammoth job of translating this. =C2=
=A0I
> skimmed the entire file, and apart from the comments below everything
> looks sane, though I may of course have missed something.
>
> I already like the translation way better than the one that
> gitk/git-gui have, because it doesn't try so hard to translate *every=
*
> term. =C2=A0Maybe it would help to make a little translation glossary=
,
> here's a start:
>
> =C2=A0bare repository =C2=A0 =C2=A0 =C2=A0 Lager-Repository
> =C2=A0blob object =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Blob-Objekt
> =C2=A0branch =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0B=
ranch (m.)
> =C2=A0checkout =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ausche=
cken
> =C2=A0commit =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0C=
ommit/committen
> =C2=A0commit object =C2=A0 =C2=A0 =C2=A0 =C2=A0 Commit-Objekt
> =C2=A0dangling ... =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0... zeigt ins Le=
ere
> =C2=A0detached HEAD =C2=A0 =C2=A0 =C2=A0 =C2=A0 von HEAD abgetrennt =C2=
=A0[but see below]
> =C2=A0directory =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Verzeichnis
> =C2=A0fast-forward =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Update ohne Merg=
e
> =C2=A0fetch =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 h=
olen
> =C2=A0file system =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Dateisystem
> =C2=A0index =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I=
ndex
> =C2=A0merge =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 M=
erge
> =C2=A0object =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0O=
bjekt
> =C2=A0origin =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0U=
rsprung
> =C2=A0parent =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[=
unused, but would be interesting]
> =C2=A0pull =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0[dito]
> =C2=A0push =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0push [though only used as the command name so far]
> =C2=A0reference =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Referenz
> =C2=A0reflog =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0R=
eflog
> =C2=A0refspec =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Refspe=
c
> =C2=A0repository =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Repository
> =C2=A0resolve =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aufl=C3=
=B6sen
> =C2=A0revision =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Revisi=
on
> =C2=A0tag =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Tag
> =C2=A0tracking branch =C2=A0 =C2=A0 =C2=A0 ... verfolgt ...
> =C2=A0tree =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Tree
> =C2=A0unmerged =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0verble=
ibende Konflikte
> =C2=A0upstream branch =C2=A0 =C2=A0 =C2=A0 Ursprung [note collision w=
ith "origin"]
> =C2=A0working tree =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Arbeitsverzeichn=
is

git-gui/po/glossary/git-gui-glossary.txt also has something like
that. It would be useful to merge this and that into some
documentation in a top-level po/ glossary.

>> +#, c-format
>> +msgid ""
>> +" Lines starting\n"
>> +"# with '#' will be kept; you may remove them yourself if you want =
to.\n"
>> +"# An empty message aborts the commit.\n"
>> +msgstr ""
>> +" Zeilen, die mit '#'\n"
>> +"# anfangen, werden beibehalten; du kannst sie selbst entfernen, we=
nn du\n"
>> +"willst. Ein leerer Kommentar bricht den Commit ab.\n"
>
> The last line lacks a #.

Something msgfmt --check wouldn't flag, but running the test suite
under German would (I plan to add support for that down the line).

>> +msgid "Fast-forward"
>> +msgstr "Update ohne Merge"
>
> Clever!

I think Fast-forward should be changed to "Update without merge" in
the English version, although that might not be viable at this point.

It would probably improve Git for newbies a lot if we clearly told
them during every "git pull" that whether we did a merge or not by
using wording to that effect consistently.

A lot of people coming from svn/perforce/cvs don't understand why they
keep getting merge commits on "git pull", wording might help there.
