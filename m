From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: remote branches
Date: Sun, 13 Feb 2011 11:08:27 +0100
Message-ID: <m2wrl49rhg.fsf@whitebox.home>
References: <4D578B6D.9090803@inria.fr>
	<AANLkTi=WPAYXg1NCyO+XDw8Jk5v=QBH3nM78CEHytuVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Imbert <matthieu.imbert@inria.fr>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 11:08:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoYsh-0001zv-Bp
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 11:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143Ab1BMKIf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Feb 2011 05:08:35 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:37890 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112Ab1BMKId (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 05:08:33 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id AFAC01C08DED;
	Sun, 13 Feb 2011 11:08:31 +0100 (CET)
X-Auth-Info: d2Dj+5zEYTaNmBSG/6jNYcxhy8L6loY20yMC8kgOYdI=
Received: from linux.local (ppp-88-217-126-191.dynamic.mnet-online.de [88.217.126.191])
	by mail.mnet-online.de (Postfix) with ESMTPA id A09CD1C0010C;
	Sun, 13 Feb 2011 11:08:31 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
	id 6E2AA1E5438; Sun, 13 Feb 2011 11:08:29 +0100 (CET)
X-Yow: This TOPS OFF my partygoing experience!  Someone I DON'T LIKE
 is talking to me about a HEART-WARMING European film..
In-Reply-To: <AANLkTi=WPAYXg1NCyO+XDw8Jk5v=QBH3nM78CEHytuVQ@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 13 Feb
 2011 10:17:48
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166654>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Also because you specified --tags you're only getting the tags on "gi=
t
> fetch",

That's not what git-remote(1) says:

           With --tags option, git fetch <name> imports every tag from =
the
           remote repository.

There is no "only" in this sentence.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
