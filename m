From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: broken bash completion
Date: Sat, 05 May 2012 14:22:08 +0200
Message-ID: <m2zk9mhl73.fsf@igel.home>
References: <4FA14016.8050503@rolf.leggewie.biz>
	<20120504233213.GF2164@goldbirke> <4FA4AB86.8020108@rolf.leggewie.biz>
	<20120505121319.GG2164@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rolf Leggewie <foss@rolf.leggewie.biz>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat May 05 14:22:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQe0I-0007O2-NS
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 14:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250Ab2EEMWS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 May 2012 08:22:18 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:41062 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390Ab2EEMWM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 08:22:12 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Vl8Nc52rXz4LDf5;
	Sat,  5 May 2012 14:22:08 +0200 (CEST)
Received: from igel.home (ppp-88-217-105-204.dynamic.mnet-online.de [88.217.105.204])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Vl8Nc4J4sz4KK22;
	Sat,  5 May 2012 14:22:08 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 50E2ACA2AA; Sat,  5 May 2012 14:22:08 +0200 (CEST)
X-Yow: Feel th' WHIRLING BUFFERS buffing away all that stress...
 Years of ROAD TAR gently washing away...
In-Reply-To: <20120505121319.GG2164@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of
	"Sat, 5 May 2012 14:13:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.96 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197110>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> While files and tags make no sense for 'git branch' itself, completin=
g
> them can be helpful to construct the name of a new branch.  I did the
> following at dayjob just the other day:
>
> # there are route_calculation.c and .h files in that project, and
> # there were some nasty bugs in there
> $ git branch ro<TAB>

You can force filename completion with M-/.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
