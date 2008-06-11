From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH 0/2] Respecting core.autocrlf when showing objects
Date: Wed, 11 Jun 2008 08:01:11 +0200
Message-ID: <484F6A27.1040602@trolltech.com>
References: <7vprqqdwh7.fsf@gitster.siamese.dyndns.org> <cover.1213084587.git.marius@trolltech.com> <alpine.DEB.1.00.0806101632570.1783@racer> <7vk5gxc4gz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig485FABC17B8825B4C48CB666"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 08:02:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6JPO-0003GL-H6
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 08:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbYFKGBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 02:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbYFKGBR
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 02:01:17 -0400
Received: from hoat.troll.no ([62.70.27.150]:36712 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057AbYFKGBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 02:01:16 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 301C420B00;
	Wed, 11 Jun 2008 08:01:11 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 2114820A5B;
	Wed, 11 Jun 2008 08:01:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <7vk5gxc4gz.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84591>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig485FABC17B8825B4C48CB666
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano said the following on 11.06.2008 00:25:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> On Tue, 10 Jun 2008, Marius Storm-Olsen wrote:
>>> When you use 'git show <rev>:<file>' or 'git show :<stage>:<file>', t=
he=20
>>> objects are shows as they are in the object store, ignoring the=20
>>> core.autocrlf configuration.
>> I think this is the correct behaviour: inside the object repository, t=
he=20
>> files are supposed to be LF clean.
>>
>> Likewise, things in the unmerged stages are in the index, which again =
is=20
>> not the working directory, so they should be LF clean.
>>
>> _Only_ when writing a file to the working directory, it should get=20
>> clobbered.
>=20
> I'd agree with your argument on general principle, but it might make se=
nse
> to give an option to let you say "here is a blob contents, and use the
> attribute for this path to munge it out to the filesystem."  I am not s=
ure
> if that belongs to "git show" Porcelain, though.  It _could_ be more li=
ke:
>=20
>         git checkout-blob $blob_sha1 $path
>=20
> that (1) reads the blob object specified by its object name, (2)
> grabs attribute for the $path, and (3) applies convert_to_worktree()
> filtering given that attribute and deposits the results to $path.
>=20
> Alternatively, the interface could be:
>=20
>         git cat-file blob $blob_sha1 |
>         git filter-blob --use-attr-for=3D$path >$path.old
>=20
> so that you can then do:
>=20
> 	git diff --no-index $path.old $path
>=20
> I dunno.

Well, consider this:
Say you are merging two branches, and know that you want to just use=20
the parts which conflict from the branch being merged in. Then you=20
simply do:
	git merge side
	git show :3:file.txt > file.txt
	git add file.txt
	git commit ...blah blah...

Now, with the current behavior, this workflow breaks for=20
core.autocrlf=3Dtrue repos. Given that 'git show' *is* porcelain, I'd=20
expect it to work 'naturally' in my workflow, and not dump raw object=20
store content.
However, I also see that it can be useful at times. Almost makes me=20
consider a --raw option to 'git show' for those seldom cases. IMO,=20
'git show' *should* care about autocrlf. Not doing so is just=20
confusing to the end-user.

The fact that the stage files are in the index doesn't matter. I'd=20
want CRLF files from 'git show v1.5.6-rc0:builtin-log.c' as well.

--=20
=2Emarius [@trolltech.com]
'if you know what you're doing, it's not research'


--------------enig485FABC17B8825B4C48CB666
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFIT2onKzzXl/njVP8RAolbAKDedaO2BuZp9XRVrxBu2Cc0r5M7RQCglm3J
yIxIZvuNj0miNW3+Yvcf9nk=
=3QUO
-----END PGP SIGNATURE-----

--------------enig485FABC17B8825B4C48CB666--
