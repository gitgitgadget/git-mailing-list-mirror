From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH de.po 5/5] de.po: collection of suggestions
Date: Wed, 02 May 2012 21:42:06 +0200
Organization: Alumni Technische =?UTF-8?B?VW5pdmVyc2l0w6R0?= Hamburg-Harburg
Message-ID: <3137881.zK1NKVIFJ3@cs-pc>
References: <cover.1335966202.git.trast@student.ethz.ch> <abfde735e408a8fc34e143ec25d1a345b6fcbd27.1335966202.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@googlemail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jan =?ISO-8859-1?Q?Kr=FCger?= <jk@jk.gs>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 02 21:42:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPfRV-0001xc-2i
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 21:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756636Ab2EBTmY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 15:42:24 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:44899 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756196Ab2EBTmX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2012 15:42:23 -0400
X-Greylist: delayed 1677 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 May 2012 15:42:22 EDT
Received: from mail.tu-harburg.de (mail.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id q42JgCLi029080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 2 May 2012 21:42:12 +0200
Received: from cs-pc.localnet (e176204125.adsl.alicedsl.de [85.176.204.125])
	(user=alucst mech=LOGIN bits=0)
	by mail.tu-harburg.de (8.13.8/8.13.8) with ESMTP id q42JgBfp010489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 2 May 2012 21:42:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2012-18;
	t=1335987731; bh=kO4guELRwzoATCVwaw0rBhutbfO9buC/mfz4InfYXoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=iH7oUbfNoPtO6v/FdRvbM9cg7qG+w53O6dye47vcZBhwST1YQasB3s/uwMsoXfFqO
	 JqVRbA5VyJy8UPJIORXpxaOnhGPLj1/7ob26fnujlzVcudW7py26Er3RFDNPX8Cq3+
	 FBOQCtUUo3cBcM8nuPORJJJIyyeFCOmKuqNUYPqE=
User-Agent: KMail/4.7.3 (Linux/3.0.0-17-generic; KDE/4.7.4; x86_64; ; )
In-Reply-To: <abfde735e408a8fc34e143ec25d1a345b6fcbd27.1335966202.git.trast@student.ethz.ch>
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196856>

As one of the earlier translators: I agree with most of those as well. =
Thanks=20
a lot. However, one small remark:

Am Mittwoch, 2. Mai 2012, 15:49:27 schrieb Thomas Rast:
> @@ -676,11 +675,11 @@ msgstr "hinter "
>=20
>  #: wt-status.c:908 wt-status.c:911
>  msgid "ahead "
> -msgstr "=FCber "
> +msgstr "weiter: "
>=20
>  #: wt-status.c:913
>  msgid ", behind "
> -msgstr ", hinter "
> +msgstr ", zur=FCckgefallen "
>=20
>  #: builtin/add.c:62
>  #, c-format
> @@ -903,12 +902,12 @@ msgstr "Zweig '%s' zeigt auf keine Version"
>  #: builtin/branch.c:396
>  #, c-format
>  msgid "behind %d] "
> -msgstr "hinter %d] "
> +msgstr "%d hinterher] "
>=20
>  #: builtin/branch.c:398
>  #, c-format
>  msgid "ahead %d] "
> -msgstr "vor %d] "
> +msgstr "%d voraus] "

In the above hunk, you said "ahead =3D weiter" and "behind =3D zur=FCck=
gefallen",=20
but now you say "ahead =3D voraus" and "behind =3D hinterher". Is it he=
lpful to=20
use two different translations, or shouldn't those rather be chosen=20
identically? The second set sounds somewhat better to me, but the more=20
important question is whether both hunks should use the same translatio=
ns.

Best Regards,

Christian
