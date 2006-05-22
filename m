From: Donnie Berkholz <spyderous@gentoo.org>
Subject: Re: irc usage..
Date: Sun, 21 May 2006 21:19:48 -0700
Message-ID: <44713BE4.9040505@gentoo.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org> <20060520203911.GI6535@nowhere.earth> <446F95A2.6040909@gentoo.org> <Pine.LNX.4.64.0605201543260.3649@g5.osdl.org> <446FA262.7080900@gentoo.org> <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org> <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA08635C1B24AF965A5E68DE4"
Cc: Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 22 06:20:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi1tl-0006zr-Pc
	for gcvg-git@gmane.org; Mon, 22 May 2006 06:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbWEVET5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 00:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWEVET5
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 00:19:57 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:50363 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S1751114AbWEVET4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 00:19:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id AF27364412;
	Mon, 22 May 2006 04:19:55 +0000 (UTC)
Received: from smtp.gentoo.org ([127.0.0.1])
 by localhost (smtp.gentoo.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 14413-02; Mon, 22 May 2006 04:19:53 +0000 (UTC)
Received: from [192.168.1.105] (c-67-171-150-177.hsd1.or.comcast.net [67.171.150.177])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTP id 3C54864333;
	Mon, 22 May 2006 04:19:53 +0000 (UTC)
User-Agent: Thunderbird 1.5.0.2 (X11/20060513)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
X-Virus-Scanned: amavisd-new at gentoo.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20478>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA08635C1B24AF965A5E68DE4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
>=20
> On Sun, 21 May 2006, Linus Torvalds wrote:
>> Ok. It's still converting (that's a big archive), but it has passed th=
e=20
>> cvsps stage without errors for me, and the conversion so far seems ok.=
 But=20
>> it has only gotten to=20
>>
>> 	Author: vapier <vapier>  2002-09-23 12:32:42
>> 	Changed GPL to GPL-2 in LICENSE and updated SRC_URI to use mirror:
>>
>> so it has converted only slightly more than the first two years of=20
>> history in the roughly 30 minutes I've let it run. So it will take sev=
eral=20
>> hours.
>=20
> Btw, trying this import (which got interrupted by a thunderstorm and on=
e=20
> of our first power failures in a long time - just a few seconds, but=20
> enough to power off everything but my laptops) it became very obvious t=
hat=20
> "git cvsimport" really _really_ should re-pack the archive every once i=
n a=20
> while.

Fortunately the storms haven't been that bad down in Corvallis. cvsps
also worked fine for me, but git-cvsimport broke in the middle. The
command I'm using is 'git-cvsimport -P ../gentoo.cvsps -k -d
/media/scm_comparison -A ~/dev/Authors -v gentoo-x86 | tee cvsimport.log'=


Here's the last bits:

Fetching gnome-base/gnome-applets/gnome-applets-1.4.0.4-r1.ebuild   v 1.5=

Update gnome-base/gnome-applets/gnome-applets-1.4.0.4-r1.ebuild: 947 byte=
s
Fetching gnome-base/gnome-applets/gnome-applets-1.4.0.4-r2.ebuild   v 1.3=

Update gnome-base/gnome-applets/gnome-applets-1.4.0.4-r2.ebuild: 977 byte=
s
Fetching gnome-base/gnome-applets/gnome-applets-2.0.0-r1.ebuild   v 1.2
Update gnome-base/gnome-applets/gnome-applets-2.0.0-r1.ebuild: 2704 bytes=

Fetching gnome-base/gnome-applets/gnome-applets-2.0.0.ebuild   v 1.2
Update gnome-base/gnome-applets/gnome-applets-2.0.0.ebuild: 3031 bytes
Tree ID 4d19a84efce2de9cfb42ac0397e0036bbed2ad65
Parent ID ecb78bbe30369a76e2599d0d17de8fe922dca211
Committed patch 14615 (origin 2002-07-16 20:13:15)
Commit ID 4dd2179e0c1369e07cd268fb5c8b150c3a2a1094
Delete net-fs/openafs/openafs-1.2.2-r6.ebuild
Delete net-fs/openafs/files/digest-openafs-1.2.2-r6
Tree ID bfc7320883983655d7d2ea2c6d04f85b45365ce1
Parent ID 4dd2179e0c1369e07cd268fb5c8b150c3a2a1094
Committed patch 14616 (origin 2002-07-16 20:15:15)
Commit ID 7a36de9c4c9b93337ed789ae2341cad3d0991c6d
Unknown: error  Cannot allocate memory
Fetching profiles/package.mask   v 1.992
cat: write error: Broken pipe

Thanks,
Donnie


--------------enigA08635C1B24AF965A5E68DE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEcTvlXVaO67S1rtsRAkE2AJ9c6w67a+lLII/OSFTgl0WAiVeYnQCguqOc
3uQhFR3kcz0w7yPz8Pum3yY=
=WtC4
-----END PGP SIGNATURE-----

--------------enigA08635C1B24AF965A5E68DE4--
