From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Problem in Patches with commit-messages containing non-ascii
Date: Fri, 03 Dec 2010 20:03:22 +0100
Message-ID: <m2r5dyd6h1.fsf@igel.home>
References: <4CF8D243.50108@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Martin =?utf-8?Q?Kr=C3=BCger?= <martin.krueger@gmx.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 20:03:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POauo-0008Qj-6f
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 20:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899Ab0LCTDZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 14:03:25 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:47320 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab0LCTDY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 14:03:24 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id EEE2A188A189;
	Fri,  3 Dec 2010 20:03:22 +0100 (CET)
Received: from igel.home (ppp-93-104-128-221.dynamic.mnet-online.de [93.104.128.221])
	by mail.mnet-online.de (Postfix) with ESMTP id E40E41C000A0;
	Fri,  3 Dec 2010 20:03:22 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 7D060CA2A0; Fri,  3 Dec 2010 20:03:22 +0100 (CET)
X-Yow: How many retired bricklayers from FLORIDA are out purchasing
 PENCIL SHARPENERS right NOW??
In-Reply-To: <4CF8D243.50108@gmx.com> ("Martin =?utf-8?Q?Kr=C3=BCger=22's?=
 message of "Fri, 03
	Dec 2010 12:19:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162827>

Martin Kr=C3=BCger <martin.krueger@gmx.com> writes:

> Then git generates this patch:
>
> From ea2cd63dfe9b3ac3581b6cff8b13a52e69066242 Mon Sep 17 00:00:00 200=
1
> From: martin <martin@chad.upnx.de>
> Date: Fri, 19 Nov 2010 18:58:58 +0100
> Subject: [PATCH] =3D?UTF-8?q?Methoden=3D20=3DC3=3DBCberall=3D20angepa=
sst.?=3D
>  =3D?UTF-8?q?Ausser=3D20Aussnahmen?=3D
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Applyin leads to a correct commit-Messsage:
>
> commit 62d06e3415ec0726dbd58c11ed93771502b77805
> Author: martin <martin@chad.upnx.de>
> Date:   Fri Nov 19 18:58:58 2010 +0100
>
>     Methoden =C3=BCberall angepasst.Ausser Aussnahmen

That's at least missing a space after the period.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
