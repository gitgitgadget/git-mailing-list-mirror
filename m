From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH v3 3/4] Add map_user() and clear_mailmap() to mailmap
Date: Wed, 04 Feb 2009 10:24:41 +0100
Message-ID: <49895ED9.90209@trolltech.com>
References: <cover.1233584536.git.marius@trolltech.com> <36adb0d2cc4c20c4efb3b03a912b27e67c166855.1233584536.git.marius@trolltech.com> <76e643ff7e99985ce46b6bf36ec967124d7fc6aa.1233584536.git.marius@trolltech.com> <53facc1773745ae477f15103718e08ea6a5ae58d.1233584536.git.marius@trolltech.com> <7v3aeu66hv.fsf@gitster.siamese.dyndns.org> <498956E9.3050606@trolltech.com> <20090204181520.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEF25326D480706C506BC5F96"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 10:26:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUe1K-0006NO-1r
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 10:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbZBDJYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 04:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbZBDJYn
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 04:24:43 -0500
Received: from hoat.troll.no ([62.70.27.150]:47749 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbZBDJYl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 04:24:41 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 9767720C0B;
	Wed,  4 Feb 2009 10:24:39 +0100 (CET)
Received: from [172.24.90.95] (unknown [172.24.90.95])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 8926220BFC;
	Wed,  4 Feb 2009 10:24:39 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.19) Gecko/20081209 Lightning/0.9 Thunderbird/2.0.0.19 Mnenhy/0.7.5.666
In-Reply-To: <20090204181520.6117@nanako3.lavabit.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108322>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEF25326D480706C506BC5F96
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Nanako Shiraishi said the following on 04.02.2009 10:15:
>> Right, I saw the patch on the list, but I based the patch series
>> on master, which I don't think had the update at the time?
>> Anyways, do you prefer the patches based on next instead?=20
>> (Documentation/SubmittingPatches says master, but maybe that has=20
>> changed)
>=20
> According to "What's in git.git (Feb 2009, #01; Sun, 01), the
> commit has been in master for the past few days.

Ah, I see my series was based on master at a34a9dbbced, which was on=20
the 29th of January.

--=20
=2Emarius [@trolltech.com]
'if you know what you're doing, it's not research'


--------------enigEF25326D480706C506BC5F96
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFJiV7ZKzzXl/njVP8RAlO+AJ0agsn1KKpdXMMSFIoFGgOmAjosLwCggUbi
PTXFFwTC5B/tT3t4zeDuMLw=
=evFc
-----END PGP SIGNATURE-----

--------------enigEF25326D480706C506BC5F96--
