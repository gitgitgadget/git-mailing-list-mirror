From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] po/hi.po: Add Hindi Translation
Date: Mon, 6 Sep 2010 09:59:45 +0530
Message-ID: <20100906042942.GA32387@kytes>
References: <1283711267-27679-1-git-send-email-artagnon@gmail.com>
 <AANLkTinGvySGu=rQxccCJ6v3ct6s6kf3butEcZvSMPpB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 06:32:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsTNE-0005Ze-Ua
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 06:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858Ab0IFEbr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 00:31:47 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44144 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab0IFEbq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 00:31:46 -0400
Received: by iwn5 with SMTP id 5so3842210iwn.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 21:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=PHbSZkVb8JMstj0nw68y1s1yTduqfx6YVeTMYf2+57M=;
        b=JbFPlLDb+Plz0ciYh+qOap6UZEKJVj+3wHAvwH9JMvxIEIzdMBhFQx+j7iamY8fHG8
         HPEIBkGXWen0Nejr1kRcS9bPUm+kIFvE8Pm5z6rGN/Yq25QmbAMkhQtMQTWbys1quwlh
         aUwRztcnAW5fu0Pl0fbkdPUwcP2NspHigL6DA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=jy2vzJa2I/rhSWLKMB609mSPwIRKi0h9jUuc0zKsppdGnXw0v9QAbpp3cxCukuJsSn
         PZUtDPcnjKgFTTNcmebBxWa6inxl/hvsaF+lvKR6T3fBJxQ9uo4EAjBqVDxx+RAp40TX
         e4ZUpX3VlenYV5YJCfW/UjQSPCqOvJf8Ub/Xc=
Received: by 10.231.174.5 with SMTP id r5mr5485912ibz.132.1283747505651;
        Sun, 05 Sep 2010 21:31:45 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id g31sm5391315ibh.10.2010.09.05.21.31.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 21:31:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinGvySGu=rQxccCJ6v3ct6s6kf3butEcZvSMPpB@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155519>

Hi Sitaram,

Sitaram Chamarty writes:
> looks OK to me.  Some of those words will never be encountered in
> colloquial Hindi (I had to think for a bit on =E0=A4=A8=E0=A4=BF=E0=A4=
=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=E0=A4=BF=E0=A4=95=E0=A4=BE and
> =E0=A4=AA=E0=A5=8D=E0=A4=B0=E0=A4=A4=E0=A5=80=E0=A4=95=E0=A4=BE=E0=A4=
=A4=E0=A5=8D=E0=A4=AE=E0=A4=95 =E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95!) ,=
 but that's the way it always is.  We end up just
> using the English word within Hindi/Telugu/whatever :-)

Thanks for the feedback. Yes, that's true- even among my friends, only
a few expert Hindi speakers were able to follow hindi.po
completely. However, I figured that only those people who are more
comfortable in Hindi than English will actually use hindi.po, so we
might as well do it right :)

I also discovered another thing- even expert Hindi speakers don't seem
to understand Hindi grammar very well :p After a few hours of
studying, I was able to correct a few more mistakes that others
weren't able to spot. Here's the diff.

Junio: Please squash this into the first revision of the patch.

diff --git a/po/hi.po b/po/hi.po
index d31e60b..a5464b3 100644
--- a/po/hi.po
+++ b/po/hi.po
@@ -12,11 +12,11 @@ msgstr ""
=20
 #, c-format
 msgid "Could not make %s writable by group"
-msgstr "%s =E0=A4=95=E0=A5=8B =E0=A4=B8=E0=A4=AE=E0=A5=82=E0=A4=B9 =E0=
=A4=A6=E0=A5=8D=E0=A4=B5=E0=A4=BE=E0=A4=B0=E0=A4=BE =E0=A4=B2=E0=A4=BF=E0=
=A4=96=E0=A4=A8=E0=A5=87 =E0=A4=AF=E0=A5=8B=E0=A4=97=E0=A5=8D=E0=A4=AF =
=E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=AC=E0=A4=A8=E0=A4=BE =E0=A4=
=B8=E0=A4=95=E0=A5=87"
+msgstr "%s =E0=A4=95=E0=A5=8B =E0=A4=B8=E0=A4=AE=E0=A5=82=E0=A4=B9 =E0=
=A4=A6=E0=A5=8D=E0=A4=B5=E0=A4=BE=E0=A4=B0=E0=A4=BE =E0=A4=B2=E0=A4=BF=E0=
=A4=96=E0=A4=A8=E0=A5=87 =E0=A4=95=E0=A5=80 =E0=A4=87=E0=A4=9C=E0=A4=BE=
=E0=A4=9C=E0=A4=BC=E0=A4=A4 =E0=A4=A8=E0=A4=B9=E0=A5=80 =E0=A4=A6=E0=A5=
=87 =E0=A4=B8=E0=A4=95=E0=A5=87"
=20
 #, c-format
 msgid "insanely long template name %s"
-msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F =E0=A4=95=E0=A4=BE =E0=A4=A8=E0=A4=BE=E0=A4=AE =E0=A4=AC=E0=A4=
=B9=E0=A5=81=E0=A4=A4 =E0=A4=B2=E0=A4=82=E0=A4=AC=E0=A4=BE =E0=A4=B9=E0=
=A5=88: %s"
+msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F %s =E0=A4=95=E0=A4=BE =E0=A4=A8=E0=A4=BE=E0=A4=AE =E0=A4=AC=E0=
=A4=B9=E0=A5=81=E0=A4=A4 =E0=A4=B2=E0=A4=82=E0=A4=AC=E0=A4=BE =E0=A4=B9=
=E0=A5=88"
=20
 #, c-format
 msgid "cannot stat '%s'"
@@ -28,40 +28,40 @@ msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=
=E0=A4=B2=E0=A5=87=E0=A4=9F '%s' =E0=A4=95=E0=A5=8B [stat] =E0=A4=A8=E0=
=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B8=E0=A4=95
=20
 #, c-format
 msgid "cannot opendir '%s'"
-msgstr "=E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=
=E0=A4=BF=E0=A4=95=E0=A4=BE =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=
=96=E0=A5=8B=E0=A4=B2 =E0=A4=B8=E0=A4=95=E0=A5=87: '%s'"
+msgstr "=E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=
=E0=A4=BF=E0=A4=95=E0=A4=BE '%s' =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=
=A4=96=E0=A5=8B=E0=A4=B2 =E0=A4=B8=E0=A4=95=E0=A5=87"
=20
 #, c-format
 msgid "cannot readlink '%s'"
-msgstr "=E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95 =E0=A4=A8=E0=A4=B9=E0=A5=80=
=E0=A4=82 =E0=A4=AA=E0=A4=A2=E0=A4=BC =E0=A4=B8=E0=A4=95=E0=A5=87: '%s'=
"
+msgstr "=E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95 '%s' =E0=A4=A8=E0=A4=B9=E0=
=A5=80=E0=A4=82 =E0=A4=AA=E0=A4=A2=E0=A4=BC =E0=A4=B8=E0=A4=95=E0=A5=87=
"
=20
 #, c-format
 msgid "insanely long symlink %s"
-msgstr "=E0=A4=AA=E0=A5=8D=E0=A4=B0=E0=A4=A4=E0=A5=80=E0=A4=95=E0=A4=BE=
=E0=A4=A4=E0=A5=8D=E0=A4=AE=E0=A4=95 =E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95=
 =E0=A4=AC=E0=A4=B9=E0=A5=81=E0=A4=A4 =E0=A4=B2=E0=A4=82=E0=A4=AC=E0=A4=
=BE =E0=A4=B9=E0=A5=88: %s"
+msgstr "=E0=A4=AA=E0=A5=8D=E0=A4=B0=E0=A4=A4=E0=A5=80=E0=A4=95=E0=A4=BE=
=E0=A4=A4=E0=A5=8D=E0=A4=AE=E0=A4=95 =E0=A4=B2=E0=A4=BF=E0=A4=82=E0=A4=95=
 %s =E0=A4=AC=E0=A4=B9=E0=A5=81=E0=A4=A4 =E0=A4=B2=E0=A4=82=E0=A4=AC=E0=
=A4=BE =E0=A4=B9=E0=A5=88"
=20
 #, c-format
 msgid "cannot symlink '%s' '%s'"
-msgstr "'%s' =E0=A4=B8=E0=A5=87 '%s' =E0=A4=AA=E0=A5=8D=E0=A4=B0=E0=A4=
=A4=E0=A5=80=E0=A4=95=E0=A4=BE=E0=A4=A4=E0=A5=8D=E0=A4=AE=E0=A4=95 =E0=A4=
=B2=E0=A4=BF=E0=A4=82=E0=A4=95 =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=
=A4=AC=E0=A4=A8=E0=A4=BE =E0=A4=B8=E0=A4=95=E0=A5=87"
+msgstr "'%s' =E0=A4=95=E0=A4=BE =E0=A4=AA=E0=A5=8D=E0=A4=B0=E0=A4=A4=E0=
=A5=80=E0=A4=95=E0=A4=BE=E0=A4=A4=E0=A5=8D=E0=A4=AE=E0=A4=95 =E0=A4=B2=E0=
=A4=BF=E0=A4=82=E0=A4=95 '%s' =E0=A4=AE=E0=A5=87=E0=A4=82 =E0=A4=A8=E0=A4=
=B9=E0=A5=80=E0=A4=82 =E0=A4=AC=E0=A4=A8=E0=A4=BE =E0=A4=B8=E0=A4=95=E0=
=A5=87"
=20
 #, c-format
 msgid "cannot copy '%s' to '%s'"
-msgstr "'%s' =E0=A4=95=E0=A4=BE =E0=A4=A8=E0=A4=95=E0=A4=B2 '%s' =E0=A4=
=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=AC=E0=A4=A8=E0=A4=BE =E0=A4=B8=E0=
=A4=95=E0=A5=87"
+msgstr "'%s' =E0=A4=95=E0=A4=BE =E0=A4=85=E0=A4=A8=E0=A5=81=E0=A4=95=E0=
=A5=83=E0=A4=A4=E0=A4=BF '%s' =E0=A4=AE=E0=A5=87=E0=A4=82 =E0=A4=A8=E0=A4=
=B9=E0=A5=80=E0=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B8=E0=A4=95=E0=A5=87"
=20
 #, c-format
 msgid "ignoring template %s"
-msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F =E0=A4=95=E0=A5=8B =E0=A4=89=E0=A4=AA=E0=A5=87=E0=A4=95=E0=A5=
=8D=E0=A4=B7=E0=A4=BE =E0=A4=95=E0=A4=B0 =E0=A4=B0=E0=A4=B9=E0=A5=87 =E0=
=A4=B9=E0=A5=88: %s"
+msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F %s =E0=A4=95=E0=A4=BE =E0=A4=89=E0=A4=AA=E0=A5=87=E0=A4=95=E0=
=A5=8D=E0=A4=B7=E0=A4=BE =E0=A4=95=E0=A4=B0 =E0=A4=B0=E0=A4=B9=E0=A5=87=
 =E0=A4=B9=E0=A5=88"
=20
 #, c-format
 msgid "insanely long template path %s"
-msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F =E0=A4=95=E0=A4=BE =E0=A4=86=E0=A4=95=E0=A4=BE=E0=A4=B0 =E0=A4=
=AC=E0=A4=B9=E0=A5=81=E0=A4=A4 =E0=A4=B2=E0=A4=82=E0=A4=AC=E0=A4=BE =E0=
=A4=B9=E0=A5=88: %s"
+msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F %s =E0=A4=95=E0=A4=BE =E0=A4=86=E0=A4=95=E0=A4=BE=E0=A4=B0 =E0=
=A4=AC=E0=A4=B9=E0=A5=81=E0=A4=A4 =E0=A4=B2=E0=A4=82=E0=A4=AC=E0=A4=BE =
=E0=A4=B9=E0=A5=88"
=20
 #, c-format
 msgid "templates not found %s"
-msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=AE=E0=A4=BF=E0=A4=
=B2=E0=A4=BE: %s"
+msgstr "=E0=A4=9F=E0=A5=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=
=E0=A4=9F %s =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=AE=E0=A4=BF=E0=
=A4=B2=E0=A4=BE"
=20
 #, c-format
 msgid "not copying templates of a wrong format version %d from '%s'"
-msgstr "'%s' =E0=A4=B8=E0=A5=87 =E0=A4=97=E0=A4=B2=E0=A4=A4 =E0=A4=B8=E0=
=A5=8D=E0=A4=B5=E0=A4=B0=E0=A5=82=E0=A4=AA =E0=A4=B8=E0=A4=82=E0=A4=B8=E0=
=A5=8D=E0=A4=95=E0=A4=B0=E0=A4=A3 %d =E0=A4=95=E0=A4=BE =E0=A4=9F=E0=A5=
=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=E0=A4=9F =E0=A4=A8=E0=A4=
=95=E0=A4=B2 =E0=A4=A8=E0=A4=B9=E0=A5=80=E0=A4=82 =E0=A4=95=E0=A4=B0 =E0=
=A4=B0=E0=A4=B9=E0=A5=87 =E0=A4=B9=E0=A5=88"
+msgstr "'%s' =E0=A4=B8=E0=A5=87 =E0=A4=97=E0=A4=B2=E0=A4=A4 =E0=A4=B8=E0=
=A5=8D=E0=A4=B5=E0=A4=B0=E0=A5=82=E0=A4=AA =E0=A4=B8=E0=A4=82=E0=A4=B8=E0=
=A5=8D=E0=A4=95=E0=A4=B0=E0=A4=A3 %d =E0=A4=95=E0=A5=87 =E0=A4=9F=E0=A5=
=87=E0=A4=AE=E0=A5=8D=E0=A4=AA=E0=A4=B2=E0=A5=87=E0=A4=9F=E0=A5=8D=E0=A4=
=B8 =E0=A4=95=E0=A5=87 =E0=A4=A8=E0=A4=95=E0=A4=B2 =E0=A4=A8=E0=A4=B9=E0=
=A5=80=E0=A4=82 =E0=A4=95=E0=A4=B0 =E0=A4=B0=E0=A4=B9=E0=A5=87 =E0=A4=B9=
=E0=A5=88"
=20
 #, c-format
 msgid "insane git directory %s"
-msgstr "=E0=A4=96=E0=A4=B0=E0=A4=BE=E0=A4=AC =E0=A4=97=E0=A4=BF=E0=A4=9F=
 =E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=E0=A4=BF=
=E0=A4=95=E0=A4=BE %s"
+msgstr "%s =E0=A4=96=E0=A4=B0=E0=A4=BE=E0=A4=AC =E0=A4=97=E0=A4=BF=E0=A4=
=9F =E0=A4=A8=E0=A4=BF=E0=A4=B0=E0=A5=8D=E0=A4=A6=E0=A5=87=E0=A4=B6=E0=A4=
=BF=E0=A4=95=E0=A4=BE =E0=A4=B9=E0=A5=88"
