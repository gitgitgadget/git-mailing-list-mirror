From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH 0/2] Respecting core.autocrlf when showing objects
Date: Thu, 12 Jun 2008 11:03:03 +0200
Message-ID: <4850E647.7050602@trolltech.com>
References: <7vprqqdwh7.fsf@gitster.siamese.dyndns.org> <cover.1213084587.git.marius@trolltech.com> <alpine.DEB.1.00.0806101632570.1783@racer> <7vk5gxc4gz.fsf@gitster.siamese.dyndns.org> <484F6A27.1040602@trolltech.com> <alpine.DEB.1.00.0806112000400.1783@racer>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4E83A85D842A171D57BC86A9"
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 12 11:04:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6ij4-0006ts-IS
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 11:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758032AbYFLJDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 05:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757562AbYFLJDN
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 05:03:13 -0400
Received: from hoat.troll.no ([62.70.27.150]:58350 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754930AbYFLJDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 05:03:09 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 2DEFB20C0C;
	Thu, 12 Jun 2008 11:03:04 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id EC56720BEA;
	Thu, 12 Jun 2008 11:03:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <alpine.DEB.1.00.0806112000400.1783@racer>
X-Enigmail-Version: 0.95.6
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
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84737>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4E83A85D842A171D57BC86A9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin said the following on 11.06.2008 21:06:
> On Wed, 11 Jun 2008, Marius Storm-Olsen wrote:
>> Well, consider this:
>>
>> Say you are merging two branches, and know that you want to just use t=
he=20
>> parts which conflict from the branch being merged in. Then you simply =

>> do:
>>
>> 	git merge side
>> 	git show :3:file.txt > file.txt
>=20
> This is not really how I would do things.  I would do
>=20
> 	git checkout side file.txt here.

Uhm, 'git checkout side file.txt' is not the same file content=20
(ignoring EOLs please) as 'git show :3:file.txt'.
Ref: user-manual.html#conflict-resolution

> The _point_ is: "git show" is supposed to show you the contents _in the=
=20
> repository_.  For example, no smudge/clean filters will be heeded, and =

> neither other attributes.

You are describing "git cat-file".
IMO, "git show" should have more consideration towards the repo=20
settings. I doubt anyone, excluding yourself and a few more=20
old-timers, think the content they get out from "git show <file>" is=20
*not* the content they'll get when they decide to "git checkout=20
<file>". For most people the commands a mostly the same, except that=20
"show" just stdout-dumps the content, while "checkout" writes it to=20
disk. The subtle difference there is simply just confusing, and is=20
what we need to fix so people won't find Git so hard to use. It's all=20
about usability. Let "git cat-file" do raw dumps, and "git show" what=20
most people would expect.

Seen another way: If you "git show" any object, they are formated in a=20
nice way for the user to see the output; not raw dumps. There's no=20
reason why the user should even consider that when they show a plain=20
blob, *then* it's raw (in the sense that EOLs are not handled properly).

The "show" command is too nice and convenient for it to have such a=20
disrespect for the user.

> Further, "git show" will work without any problems in any bare reposito=
ry.

Sure, it writes to stdout, and not to file. People understand that.

> In other words: "git show" is _not_ an operation on a working directory=
=2E

See above. Nobody expect it to touch files. However, any repo (even=20
bare) still has a config file though, and "git show" should respect=20
its settings.

> "git checkout" is.  So use that instead.

"git checkout" doesn't munge :<stage>:, which is what the=20
documentation is referring to when it comes to conflict resolution.

>> Given that 'git show' *is* porcelain, I'd expect it to work 'naturally=
'=20
>> in my workflow, and not dump raw object store content.
>=20
> Do not confuse porcelain with "works on the working directory".

I don't. But I'm trying to see the workflow from a non-git-master POV,=20
you're obviously not.

>> The fact that the stage files are in the index doesn't matter. I'd wan=
t=20
>> CRLF files from 'git show v1.5.6-rc0:builtin-log.c' as well.
>=20
> But it _does_ matter!
> The index works on raw objects, not on smudged files.  Period.

You misunderstood me. I don't smudged files in the index.

--=20
=2Emarius [@trolltech.com]
'if you know what you're doing, it's not research'


--------------enig4E83A85D842A171D57BC86A9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFIUOZHKzzXl/njVP8RAjEXAJ4siUB/FbzBhoViMpOwtpjCMRo8EgCdFshe
aUKrRTaauoeSUeBzX1P9hOg=
=uu01
-----END PGP SIGNATURE-----

--------------enig4E83A85D842A171D57BC86A9--
