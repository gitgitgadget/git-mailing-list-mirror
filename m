From: Phillip Sz <phillip.szelat@gmail.com>
Subject: Re: [PATCH 1/7] part1: l10n: de.po: use imperative form for command
 options
Date: Fri, 19 Sep 2014 21:11:51 +0200
Message-ID: <541C7FF7.1020105@gmail.com>
References: <1411146770-8508-1-git-send-email-ralf.thielow@gmail.com> <1411146770-8508-2-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com
To: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 19 21:12:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XV3bC-0001We-Kw
	for gcvg-git-2@plane.gmane.org; Fri, 19 Sep 2014 21:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757413AbaISTLy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2014 15:11:54 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:43811 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756107AbaISTLy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2014 15:11:54 -0400
Received: by mail-wi0-f181.google.com with SMTP id z2so95292wiv.8
        for <git@vger.kernel.org>; Fri, 19 Sep 2014 12:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yf3eHKvo23Axk5lZkgUGroHr40UgG/6Y1OwaFZ1Bw3c=;
        b=tLuVQIKQJcs2EffX+FDieTFlSnFFo6wnr9QosaXMqLQT8UVjYkrKlcD/dXrQSimb4U
         7rLpDgV3dwUPaG62oqY/UruLvg+AYyRFM4AvYgFxt807DXNiTkjMl5ScqDcHUOyuobMF
         rPTSEm6HY9dm8mgNfk9UUdXsYMOsmOEYCPknW/gsklSd2mXdGUadQjJZrOLRTSMhC12r
         WZCYhixxAwWg+++wRe6QipON8bn4+a7I3m1w+9NWYMmdCpMtow/xYnNfAUhDo1WsvBzm
         Xhbb6DQpd+XaHpXbyZZvoyRhH3Q7+qgCdhaI8aNzQzI7GlkeZjoPRDayHnVogyvI2HrU
         u1Tg==
X-Received: by 10.194.95.234 with SMTP id dn10mr2985394wjb.73.1411153912796;
        Fri, 19 Sep 2014 12:11:52 -0700 (PDT)
Received: from [192.168.178.43] (i577ABD2D.versanet.de. [87.122.189.45])
        by mx.google.com with ESMTPSA id xm4sm3035440wib.9.2014.09.19.12.11.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Sep 2014 12:11:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <1411146770-8508-2-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257305>

Hi,

>  #: archive.c:351 builtin/archive.c:91
>  msgid "retrieve the archive from remote repository <repo>"
> -msgstr "ruft das Archiv von Remote-Repository <Repository> ab"
> +msgstr "Archiv von Remote-Repository <Repository> abrufen"
>=20

"Archiv vom Remote-Repository <Repository> abrufen" sounds better to me=
=2E

>  #: builtin/add.c:256
>  msgid "record only the fact that the path will be added later"
> -msgstr "speichert nur, dass der Pfad sp=C3=A4ter hinzugef=C3=BCgt we=
rden soll"
> +msgstr "nur speichern, dass der Pfad sp=C3=A4ter hinzugef=C3=BCgt we=
rden soll"
>=20

"nur speichern, so dass der Pfad sp=C3=A4ter hinzugef=C3=BCgt werden so=
ll" maybe
use a full sentence?

>  #: builtin/apply.c:4378
>  msgid "instead of applying the patch, see if the patch is applicable=
"
> @@ -2472,27 +2472,27 @@ msgstr ""
>  #: builtin/apply.c:4380
>  msgid "make sure the patch is applicable to the current index"
>  msgstr ""
> -"stellt sicher, dass der Patch in der aktuellen Staging-Area angewen=
det "
> +"sicher stellen, dass der Patch in der aktuellen Staging-Area angewe=
ndet "
>  "werden kann"
> =20

"stellen Sie sicher, dass der Patch in der aktuellen Staging-Area
angewendet "
"werden kann" Someone is addressed dirctly.

Phillip
