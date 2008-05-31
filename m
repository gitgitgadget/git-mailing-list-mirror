From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH 2/3] Introduce core.showUntrackedFiles to make it possible
 to disable showing of untracked files.
Date: Sat, 31 May 2008 08:41:34 +0200
Message-ID: <4840F31E.7090801@trolltech.com>
References: <043361f81946d5657217e6be0f22f4df350fd13f.1212152269.git.marius@trolltech.com> <3088e5a9507aa55ee55f512fb3bd554f1658d2e3.1212152269.git.marius@trolltech.com> <7viqwvk04y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFAD35D744016940DF4B8B2E4"
Cc: Simon Hausmann <simon@lst.de>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 31 08:43:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Ko0-0002TU-MR
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 08:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbYEaGl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 02:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbYEaGl6
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 02:41:58 -0400
Received: from hoat.troll.no ([62.70.27.150]:55366 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbYEaGl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 02:41:56 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 3561820BBA;
	Sat, 31 May 2008 08:41:48 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 481EB20A83;
	Sat, 31 May 2008 08:41:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
In-Reply-To: <7viqwvk04y.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
OpenPGP: id=34EB4437
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83366>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFAD35D744016940DF4B8B2E4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> I wonder if we really need a new option that is half independent to an
> existing one.
=2E..
>         -u=3Dnone		shows nothing (i.e. (1))
>         -u=3Dnormal	shows summarized report (i.e. (2))
> 	-u=3Dall		shows all untracked files (i.e. (3))
=2E..
> Then, in the second patch, you can add support to 'status.showuntracked=
';
> you pretend that it is set to 'normal' if it is not defined in the
> configuration file.
>=20
> Hmm?

Sounds good to me. Will redo the patch. Thanks!

--
=2Emarius


--------------enigFAD35D744016940DF4B8B2E4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFIQPMiKzzXl/njVP8RAgMLAJ4kf65S2QsNR/uBc2L7xeW/vE88rACfRt+C
ADaD9RW6xwkCTrzuGpXZCqM=
=63bC
-----END PGP SIGNATURE-----

--------------enigFAD35D744016940DF4B8B2E4--
