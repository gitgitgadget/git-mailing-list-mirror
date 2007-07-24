From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Tue, 24 Jul 2007 13:14:39 +0200
Message-ID: <46A5DF1F.2030307@trolltech.com>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site> <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk> <Pine.LNX.4.64.0707222223460.14781@racer.site> <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk> <Pine.LNX.4.64.0707222255010.14781@racer.site> <Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk> <Pine.LNX.4.64.0707230000020.14781@racer.site> <20070723035644.GC32566@spearce.org> <7v1wezohi4.fsf@assigned-by-dhcp.cox.net> <46A5B5F5.6000202@trolltech.com> <Pine.LNX.4.64.0707241002410.14781@racer.site> <7vd4yigmla.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig96837D3F1A989D00AC9CA5ED"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 13:14:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDILE-0000ZP-I3
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 13:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932925AbXGXLOJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 07:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765001AbXGXLOI
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 07:14:08 -0400
Received: from esparsett.troll.no ([62.70.27.18]:34070 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762994AbXGXLOG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 07:14:06 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 387287424E; Tue, 24 Jul 2007 13:14:04 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 2185D74232; Tue, 24 Jul 2007 13:14:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.5) Gecko/20070716 Thunderbird/2.0.0.5 Mnenhy/0.7.5.666
In-Reply-To: <7vd4yigmla.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.95.2
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53567>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig96837D3F1A989D00AC9CA5ED
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano said the following on 24.07.2007 11:47:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>> While you guys are discussing this, please please keep in mind
>>> that there are Windows users (/me raises his hand) out there
>>> that really really want this too. So, please try to keep it
>>> light on the symlinks.
>> Easy: use cygwin.
>>=20
>> Okay, a bit more seriously again: in the recent weeks, it seems
>> that more and more Windows users are asking for features.  Since
>> I guess you are a developer (why else would you want to use git),
>> IMHO it is your itch to scratch.

Yes, I fully agree with this, and I don't have the attitude that=20
others should work for me. I'm trying to free up some 'spare time'=20
resources so I can pitch in on the effort of making Git work neatly on=20
Windows. However, I feared I won't be able to get working on it before=20
you guys had decided on a design, so I just wanted voice my opinion on=20
the design, so Windows users are not lost in this.


> I do not know this is an appropriate itch to scratch for a Windows
> developer to begin with.  The new-workdir setting *is* about
> symlinked .git/ metainfo space.  If somebody wants to work on a
> filesystem without symlink, he should not be using new-workdir but
> something else.  E.g. GIT_DIR + GIT_WORK_TREE, or perhaps GIT_DIR +
> core.worktree comes to mind.

That's is definitely an option, though it seems to me that its more=20
like giving up than a finding a proper solution. In any case, it would=20
result in two completely different workflows on systems with and=20
without symlink support. I work on both, and would like my workflow to=20
be consistent. Of course I could easily add my own scripts on top to=20
achieve this, but then we're going back into h4x0r land and not making=20
Git more 'available'.

The new-workdir feature doesn't *have* to be about symlinked .git/=20
metainfo space, but could also be about symref'ed .git/ metainfo.
(A discussion was done in 2005s "Getting rid of symlinks in .git?",=20
but the conclusion was that it would slow it down too much? *ponder*)

I think you're right in that this is probably not the appropriate itch=20
to scratch for a Windows developer to start with, and I have my own=20
list of issues to work on when I get the time. File stat'ing=20
(daemon/service), CRLF issues, de-SH'ifying commands, non-MinGW native=20
build of Git, etc.. Lots to keep my fingers busy :-)

Though, let me also say that I already love working with Git on=20
Windows. And I thank each and every one who's working on it, for=20
providing such an excellent tool.

--=20
=2Emarius


--------------enig96837D3F1A989D00AC9CA5ED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGpd8fKzzXl/njVP8RAkaGAJ9G3kAUa0RL1Qgwjy8KJJhzC8vBDACgtayC
vTa/40fRTvdL9Z0BzoDhgX4=
=cbUs
-----END PGP SIGNATURE-----

--------------enig96837D3F1A989D00AC9CA5ED--
