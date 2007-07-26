From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 11:30:11 +0200
Message-ID: <46A869A3.6050707@trolltech.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>  <693D0FFF-B271-4781-BCE2-3BF00C8BF426@zib.de> <316a20a40707250958w1fe9f6fdn41d75ca704aeb9cd@mail.gmail.com> <alpine.LFD.0.999.0707251131540.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig71A523CE0C82BDA5D6733C76"
Cc: Stephen Cuppett <cuppett@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 11:29:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDzfA-00037C-SJ
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 11:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090AbXGZJ3h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 05:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbXGZJ3h
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 05:29:37 -0400
Received: from esparsett.troll.no ([62.70.27.18]:55811 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbXGZJ3g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 05:29:36 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 457EE7424E; Thu, 26 Jul 2007 11:29:34 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 10E48741EE; Thu, 26 Jul 2007 11:29:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.5) Gecko/20070716 Thunderbird/2.0.0.5 Mnenhy/0.7.5.666
In-Reply-To: <alpine.LFD.0.999.0707251131540.3607@woody.linux-foundation.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53813>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig71A523CE0C82BDA5D6733C76
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Linus Torvalds said the following on 25.07.2007 20:43:
> On Wed, 25 Jul 2007, Stephen Cuppett wrote:
>> I don't know if the performance problems are cygwin or not.  More
>>  knowledgeable people might be able to answer, it's just what I'm
>>  observing right now.  It could be more fundamental to the types
>> of access being performed en masse on inode-based versus NTFS
>> systems.
>=20
> I think cygwin may add some overhead, but people should really
> realize that Linux is quite often an order of magnitude faster (or
> more) than other systems on some very basic operations.
>=20
(..snip..)
>=20
> (It will just not be so *blazingly* fast, ie things like "git
> status" will generally not be instantaneous).

Let me present some numbers:
My repository is ~680MB, and 19323 tracked files, in 2264 directories.
When in a compiled state the total is 27540 files, in 4885 directories.

When file system cache is warm, I get the following times:
 Native: dir /B /S               1.077s
         dir /S                  1.707s (shows time, size/type)
 MSys:   ls -f1AUR              34.608s
         find . -type f          6.718s
         git diff (empty diff)   1.18s
         git status              5.5s
and when the system cach is cold:
         git status             54.55s

Maybe you guys have other git commands which are also/more interesting
to look at/benchmark?

Windows people should also be aware that it's possible to tweak the
amount of memory which the OS uses for the file cache. On XP you can
change it _roughly_ in System Properties panel (Right-click on My
Computer), then Advanced - Performance Settings - Advanced -
Memory Usage:
Normal setting is "Programs" for non-servers Windows systems, while
you can select "System cache" make the OS allocate more memory for
the system caches. I've tried both, and the setting doesn't really
affect the file operations much when the cache is warm, but it
probably affects how long the cache stays warm.

Also note that you can use Sysinternal's CacheSet (free), to
manipulate the working-set parameters of the system file cache.
You'll find that here:
    http://www.microsoft.com/technet/sysinternals/FileAndDisk/CacheSet.ms=
px

--=20
=2Emarius


--------------enig71A523CE0C82BDA5D6733C76
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGqGmkKzzXl/njVP8RAs4RAKDRov5kVaeCaf/UlI/l4WMEzLwiFACeOr14
o56+qHDjLdl7mliJTQxjiv8=
=QBgP
-----END PGP SIGNATURE-----

--------------enig71A523CE0C82BDA5D6733C76--
