From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Oops, I screwed it up
Date: Sat, 11 Dec 2010 00:01:05 +0100
Message-ID: <m239q58c7i.fsf@igel.home>
References: <AANLkTinyZ-dqV5=yaucLZTj14hdxS61v=VT-j82SqN7r@mail.gmail.com>
	<AANLkTi=eFmCjdBYHx9Jy=Q7993GghuV1dp12E4Aj7pkZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?P=C3=A9ter_Andr=C3=A1s_Felv=C3=A9gi?= <petschy@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 11 00:01:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRBxk-0004IM-Jx
	for gcvg-git-2@lo.gmane.org; Sat, 11 Dec 2010 00:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566Ab0LJXBJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Dec 2010 18:01:09 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:35351 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506Ab0LJXBH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 18:01:07 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id ADE441C0F56E;
	Sat, 11 Dec 2010 00:01:05 +0100 (CET)
Received: from igel.home (ppp-88-217-110-181.dynamic.mnet-online.de [88.217.110.181])
	by mail.mnet-online.de (Postfix) with ESMTP id A26D31C001B7;
	Sat, 11 Dec 2010 00:01:05 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 713BBCA2A0; Sat, 11 Dec 2010 00:01:05 +0100 (CET)
X-Yow: Why don't you ever enter any CONTESTS, Marvin??
 Don't you know your own ZIPCODE?
In-Reply-To: <AANLkTi=eFmCjdBYHx9Jy=Q7993GghuV1dp12E4Aj7pkZ@mail.gmail.com>
	(=?utf-8?Q?=22P=C3=A9ter_Andr=C3=A1s_Felv=C3=A9gi=22's?= message of "Fri,
 10 Dec 2010 19:31:23
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163446>

P=C3=A9ter Andr=C3=A1s Felv=C3=A9gi <petschy@gmail.com> writes:

> This is what I did precisely:
> - added 3 files to the index, then committed (#1)
> - realized that a file was left out (not yet tracked), so added + com=
mitted it

=46WIW, at this point doing "git commit --amend" would have been easier
and avoided the need to stash.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
