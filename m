From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 265 new messages
Date: Mon, 21 May 2012 09:21:49 +0800
Message-ID: <CANYiYbFRu1od=jiio1VgGGZDYpg1A_yJ+oKnnigvZExdMWo4Lg@mail.gmail.com>
References: <1337533755-29399-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de,
	Git List <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Mon May 21 03:22:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWHJr-0000HK-Nx
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 03:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845Ab2EUBVv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 May 2012 21:21:51 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43344 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754634Ab2EUBVu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 May 2012 21:21:50 -0400
Received: by yenm10 with SMTP id m10so3934976yen.19
        for <git@vger.kernel.org>; Sun, 20 May 2012 18:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=pselegDcH0ycJ+0rDxKwIja4D2p37h3v5NqnDuNm2A4=;
        b=TQWxo2HM7V6tVeOviUi8ztadg20Ns8LPl+oo1QoaSAw/UbyQ83S4ARdBiA3592G5V6
         /sN4gt9LgbpbBOWufVJ4QqCSyDxIv/Y2nfNHUss+Ha8BW+ac6wn4UJAYfWPuFogJnEOd
         TsN9yT4B71QBM74sAMP5abZd5bEPJg1MMPU6gglvpdsT1VLPTzmhiIfHagYN/JH7E07N
         kpDqfa8hGwPD3Uo0VyEPax72FbpA+kbM65c2lWysI7HDjJHRWyDPKEraNCRnBIRaQbny
         MtKMobIJ+oLlm81OKbkjG0Q2WkBnzbnmz14Lt+eJk63w/Q1i69fOTE4IHOrjF28RKWUn
         t91w==
Received: by 10.50.46.201 with SMTP id x9mr5452007igm.34.1337563309631; Sun,
 20 May 2012 18:21:49 -0700 (PDT)
Received: by 10.50.188.228 with HTTP; Sun, 20 May 2012 18:21:49 -0700 (PDT)
In-Reply-To: <1337533755-29399-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198074>

Hi Ralf,

Congratulations. You and Germany l10n team have done great work in
this around of l10n. As for Chinese, this work may be completed in two
weeks when I have much time.

Before you send me a pull request, I sync the git-po repository with up=
stream
and update the 'git.pot' again. There are 41 new l10n messages, and
you can make another commit for it.

Date: Mon, 21 May 2012 09:00:39 +0800
Subject: [PATCH] l10n: Update git.pot (41 new messages)

Generate po/git.pot from v1.7.10.2-548-g9de96:

 * 41 new l10n messages at lines:

   332, 337, 344, 349, 967, 1288, 1292, 1296, 1300, 1304, 1308, 1312,
   1316, 1320, 1324, 1328, 1332, 1336, 1340, 1344, 1348, 1352, 1356,
   1360, 1364, 1368, 1372, 1376, 1380, 1384, 1388, 1392, 1396, 4465,
   4469, 4473, 4477, 4481, 4485, 4489, 4493.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 po/git.pot | 171 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 1 file changed, 170 insertions(+), 1 deletion(-)


2012/5/21 Ralf Thielow <ralf.thielow@googlemail.com>:
> Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
> ---
> =A0po/de.po | 2296 ++++++++++++++++++++++++++++++++++++++++++++++++++=
------------
> =A01 Datei ge=E4ndert, 1855 Zeilen hinzugef=FCgt(+), 441 Zeilen entfe=
rnt(-)
>



--=20
Jiang Xin
