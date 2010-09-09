From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] po/hi.po: Add Hindi Translation
Date: Thu, 9 Sep 2010 19:32:09 +0530
Message-ID: <20100909140205.GA13472@kytes>
References: <1283971131-25106-1-git-send-email-artagnon@gmail.com>
 <AANLkTi=geJoBzDw4z-pWytCi9XmzwXvzyzFHUpVYnmMJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Antriksh Pany <antriksh.pany@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 16:04:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Othjf-0004Gw-Uj
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 16:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814Ab0IIOEP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Sep 2010 10:04:15 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46649 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857Ab0IIOEO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 10:04:14 -0400
Received: by pwi3 with SMTP id 3so514563pwi.19
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 07:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=IVh+HtbVuRTHaCt16CuzZ1eloTfeDGOi83qYJ3Mmu8s=;
        b=gI7v7jKIJGh0UPTN5UykZxEkxSp096eVHA4+JoIooi70z7fyZHjbgoqlMy207GcWZv
         Fqn9BAb90+0OkORBh49w0cdXgp024kUD9ggK1FFmHYlbQwKgx7Iq7ijVP36UrK1GGEmb
         PEjEGvRPXEXQxLCPePJjbq9V74cFZrAU3a6d0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LkhkUH/cwGPqJPaGOqZAYP8Ho1fkB4VhnpIL2Ib/beiyLOWDleUNJrP5doOGBDQGUl
         zve0qJDQnJ3HKxduE4cdr25JwvHnYWOw6ob7bwo6AmzjZdDzQUWAR8iWguu85xvyXSMn
         gaW6i3u0HjjPDAHB492b4HGR6vDr6AL9XqysE=
Received: by 10.114.134.5 with SMTP id h5mr812161wad.145.1284041052565;
        Thu, 09 Sep 2010 07:04:12 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id c24sm2350949wam.19.2010.09.09.07.04.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Sep 2010 07:04:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=geJoBzDw4z-pWytCi9XmzwXvzyzFHUpVYnmMJ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155858>

Hi,

Antriksh Pany writes:
> > +#, c-format
> > +msgid "insanely long template path %s"
> > +msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=
=87=E0=A4=9F %s =E0=A4=95=E0=A5=80 [path] =E0=A4=85=E0=A4=A4=E0=A5=8D=E0=
=A4=AF=E0=A4=82=E0=A4=A4 =E0=A4=B2=E0=A4=82=E0=A4=AC=E0=A4=BE"
>=20
> Now this would become 'ka', 'path' being masculine :)

=46ixed, thanks.

> > +
> > +#, c-format
> > +msgid "templates not found %s"
> > +msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=
=87=E0=A4=9F %s =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=AE=E0=A4=BF=
=E0=A4=B2=E0=A4=BE"
>=20
> This can instead be "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=
=A4=B2=E0=A5=87=E0=A4=9F=E0=A5=8D=E0=A4=B8 %s =E0=A4=A8=E0=A4=B9=E0=A5=80=
=E0=A4=82 =E0=A4=AE=E0=A4=BF=E0=A4=B2=E0=A5=87" to keep the plural form=
=2E
> Also, the '%s' here indicates a template directory, so in the Hindi v=
ersion
> also you may want to stick it at the end.

=46ixed, thanks.

> If this patch is being taken in, looks good for a first draft. And if=
 I may,
> Acked-by: Antriksh Pany <antriksh.pany@gmail.com>

Thanks. Here's a new version.

-- 8< --
=46rom: Ramkumar Ramachandra <artagnon@gmail.com>
Date: Sun, 5 Sep 2010 23:49:38 +0530
Subject: [PATCH] po/hi.po: Add Hindi Translation
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Translate a few Git messages to Standard Hindi. It uses a phonetic
script called Devanagari. Focus especially on transforming grammar and
tense in a sane manner to serve as a guideline for future translators.

Note that Devanagari rendering is broken on many applications by
default at this time- the latest Emacs, Vim and Chrome render it
incorrectly.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Acked-by: Antriksh Pany <antriksh.pany@gmail.com>
Cc: Sitaram Chamarty <sitaramc@gmail.com>
Cc: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 po/hi.po |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)
 create mode 100644 po/hi.po

diff --git a/po/hi.po b/po/hi.po
new file mode 100644
index 0000000..85890fa
--- /dev/null
+++ b/po/hi.po
@@ -0,0 +1,67 @@
+msgid ""
+msgstr ""
+"Project-Id-Version: Git\n"
+"Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
+"Language-Team: Git Mailing List <git@vger.kernel.org>\n"
+"Last-Translator: Ramkumar Ramachandra <artagnon@gmail.com>\n"
+"POT-Creation-Date: 2010-09-05 16:05+0530\n"
+"Language: hi\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+#, c-format
+msgid "Could not make %s writable by group"
+msgstr "%s =E0=A4=95=E0=A5=8B =E0=A4=B8=E0=A4=AE=E0=A5=82=E0=A4=B9 =E0=
=A4=A6=E0=A5=8D=E0=A4=B5=E0=A4=BE=E0=A4=B0=E0=A4=BE =E0=A4=B2=E0=A4=BF=E0=
=A4=96=E0=A4=A8=E0=A5=87 =E0=A4=95=E0=A5=80 =E0=A4=87=E0=A4=9C=E0=A4=BE=
=E0=A4=9C=E0=A4=BC=E0=A4=A4 =E0=A4=A8=E0=A4=B9=E0=A5=80 =E0=A4=A6=E0=A5=
=87 =E0=A4=B8=E0=A4=95=E0=A5=87"
+
+#, c-format
+msgid "insanely long template name %s"
+msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F %s =E0=A4=95=E0=A4=BE =E0=A4=A8=E0=A4=BE=E0=A4=AE =E0=A4=85=E0=
=A4=A4=E0=A5=8D=E0=A4=AF=E0=A4=82=E0=A4=A4 =E0=A4=B2=E0=A4=82=E0=A4=AC=E0=
=A4=BE"
+
+#, c-format
+msgid "cannot stat '%s'"
+msgstr "'%s' =E0=A4=95=E0=A5=8B [stat] =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=
=82 =E0=A4=95=E0=A4=B0 =E0=A4=B8=E0=A4=95=E0=A5=87"
+
+#, c-format
+msgid "cannot stat template '%s'"
+msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F '%s' =E0=A4=95=E0=A5=8B [stat] =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=
=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B8=E0=A4=95=E0=A5=87"
+
+#, c-format
+msgid "cannot opendir '%s'"
+msgstr "=E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=
=E0=A4=BF=E0=A4=95=E0=A4=BE '%s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=
=A4=96=E0=A5=8B=E0=A4=B2 =E0=A4=B8=E0=A4=95=E0=A5=87"
+
+#, c-format
+msgid "cannot readlink '%s'"
+msgstr "=E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95 '%s' =E0=A4=A8=E0=A4=B9=E0=
=A5=80=E0=A4=82 =E0=A4=AA=E0=A4=A2=E0=A4=BC =E0=A4=B8=E0=A4=95=E0=A5=87=
"
+
+#, c-format
+msgid "insanely long symlink %s"
+msgstr "=E0=A4=AA=E0=A5=8D=E0=A4=B0=E0=A4=A4=E0=A5=80=E0=A4=95=E0=A4=BE=
=E0=A4=A4=E0=A5=8D=E0=A4=AE=E0=A4=95 =E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95=
 %s =E0=A4=85=E0=A4=A4=E0=A5=8D=E0=A4=AF=E0=A4=82=E0=A4=A4 =E0=A4=B2=E0=
=A4=82=E0=A4=AC=E0=A4=BE"
+
+#, c-format
+msgid "cannot symlink '%s' '%s'"
+msgstr "'%s' =E0=A4=95=E0=A4=BE =E0=A4=AA=E0=A5=8D=E0=A4=B0=E0=A4=A4=E0=
=A5=80=E0=A4=95=E0=A4=BE=E0=A4=A4=E0=A5=8D=E0=A4=AE=E0=A4=95 =E0=A4=B2=E0=
=A4=BF=E0=A4=82=E0=A4=95 '%s' =E0=A4=AE=E0=A5=87=E0=A4=82 =E0=A4=A8=E0=A4=
=B9=E0=A5=80=E0=A4=82 =E0=A4=AC=E0=A4=A8=E0=A4=BE =E0=A4=B8=E0=A4=95=E0=
=A5=87"
+
+#, c-format
+msgid "cannot copy '%s' to '%s'"
+msgstr "'%s' =E0=A4=95=E0=A5=80 =E0=A4=85=E0=A4=A8=E0=A5=81=E0=A4=95=E0=
=A5=83=E0=A4=A4=E0=A4=BF '%s' =E0=A4=AE=E0=A5=87=E0=A4=82 =E0=A4=A8=E0=A4=
=B9=E0=A5=80=E0=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B8=E0=A4=95=E0=A5=87"
+
+#, c-format
+msgid "ignoring template %s"
+msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F %s =E0=A4=95=E0=A5=80 =E0=A4=89=E0=A4=AA=E0=A5=87=E0=A4=95=E0=
=A5=8D=E0=A4=B7=E0=A4=BE =E0=A4=95=E0=A4=B0 =E0=A4=B0=E0=A4=B9=E0=A5=87=
 =E0=A4=B9=E0=A5=88=E0=A4=82"
+
+#, c-format
+msgid "insanely long template path %s"
+msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F %s =E0=A4=95=E0=A4=BE [path] =E0=A4=85=E0=A4=A4=E0=A5=8D=E0=A4=
=AF=E0=A4=82=E0=A4=A4 =E0=A4=B2=E0=A4=82=E0=A4=AC=E0=A4=BE"
+
+#, c-format
+msgid "templates not found %s"
+msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F=E0=A5=8D=E0=A4=B8 =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=
=AE=E0=A4=BF=E0=A4=B2=E0=A5=87: %s"
+
+#, c-format
+msgid "not copying templates of a wrong format version %d from '%s'"
+msgstr "'%s' =E0=A4=B8=E0=A5=87 =E0=A4=97=E0=A4=B2=E0=A4=A4 =E0=A4=B8=E0=
=A5=8D=E0=A4=B5=E0=A4=B0=E0=A5=82=E0=A4=AA =E0=A4=B8=E0=A4=82=E0=A4=B8=E0=
=A5=8D=E0=A4=95=E0=A4=B0=E0=A4=A3 %d =E0=A4=95=E0=A5=87 =E0=A4=9F=E0=A5=
=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=E0=A4=9F=E0=A5=8D=E0=A4=
=B8 =E0=A4=95=E0=A5=80 =E0=A4=A8=E0=A4=95=E0=A4=B2 =E0=A4=A8=E0=A4=B9=E0=
=A5=80=E0=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B0=E0=A4=B9=E0=A5=87 =E0=A4=B9=
=E0=A5=88=E0=A4=82"
+
+#, c-format
+msgid "insane git directory %s"
+msgstr "=E0=A4=96=E0=A4=B0=E0=A4=BE=E0=A4=AC =E0=A4=97=E0=A4=BF=E0=A4=9F=
 =E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=E0=A4=BF=
=E0=A4=95=E0=A4=BE %s"
--=20
1.7.2.2.409.gdbb11.dirty
