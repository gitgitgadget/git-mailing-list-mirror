From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH v2 0/4] Extend mailmap functionality
Date: Mon, 02 Feb 2009 09:07:42 +0100
Message-ID: <4986A9CE.9040009@trolltech.com>
References: <cover.1233520945.git.marius@trolltech.com> <7vpri1o801.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDD074D9FE93AEB5C2F2FF0DB"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 09:09:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTtrh-000205-1R
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 09:09:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbZBBIHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 03:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbZBBIHn
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 03:07:43 -0500
Received: from hoat.troll.no ([62.70.27.150]:59270 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbZBBIHm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 03:07:42 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 42E6420B11;
	Mon,  2 Feb 2009 09:07:41 +0100 (CET)
Received: from [172.24.90.95] (unknown [172.24.90.95])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 335CA209F5;
	Mon,  2 Feb 2009 09:07:41 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.19) Gecko/20081209 Lightning/0.9 Thunderbird/2.0.0.19 Mnenhy/0.7.5.666
In-Reply-To: <7vpri1o801.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.7
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108067>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDD074D9FE93AEB5C2F2FF0DB
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano said the following on 02.02.2009 04:03:
>> This extended mapping is necessary when a company wants to have
>> their repositories open to the public, but needs to protect the
>> identities of the developers. It enables you to only show nicks
>> and standardized emails, like 'Dev123 <bugs@company.xx>' in the
>> public repo, but by using an private mailmap file, map the name
>> back to 'John Doe <john.doe@company.xx>' inside the company.
>=20
> I do not find the "necessary" argument very convincing nor I find
> the particular use case sane.  You may want to do things that way,
> but I do not know if it is the best way to go about it.

Well, this is the use-case for my company. We have open-source repos,=20
which are the exact same repos which the company's developers work on,=20
not a modified mirror repo.
However, laws in some countries requires that employees information be=20
kept away from the public, should they so wish. So, for our developers=20
to work on the exact same repo as the open-source community, we need a=20
way to map both Names and Emails back to the original author, inside=20
the company without using a different repo.

Also, the company commit policy might be such that the email on the=20
commit is always the companys <bugs@company.xx>. This might be so that=20
if someone finds a bug to your commit, they send the bug report to the=20
companys bug-tracker instead of the individual email address.
However, that breaks the old mailmap system, since it requires unique=20
email addresses to map to a name.

> The new mapping however brings in more flexibility, and there may
> be other use cases where people benefit from that flexibility.  I
> am slightly in favor than neutral to this new feature.

You could use this feature in git.git itself, where for example
     Junio C Hamano <gitster@pobox.com>
     Junio C Hamano <gitster@pobox.com> <junio@twinsun.com>
(or any of the others in the .mailmap file with X number of different=20
email addresses), to ensure that you are always associated with one=20
specific email address.

--=20
=2Emarius [@trolltech.com]
'if you know what you're doing, it's not research'


--------------enigDD074D9FE93AEB5C2F2FF0DB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFJhqnOKzzXl/njVP8RAmAYAJ9tnpvEFXNo2MLayoTxc/NifMBGEgCbB6In
oobKt2Ts+r/S8lvhMOTq8Ic=
=MpIE
-----END PGP SIGNATURE-----

--------------enigDD074D9FE93AEB5C2F2FF0DB--
