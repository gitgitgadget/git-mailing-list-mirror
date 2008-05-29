From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] "git checkout -- paths..." should signal error
Date: Thu, 29 May 2008 08:28:25 +0200
Message-ID: <483E4D09.1070400@trolltech.com>
References: <483AC2CE.7090801@gmail.com> <7vy75vvtxo.fsf@gitster.siamese.dyndns.org> <32541b130805280933r573d59d0mf9cdc09f5e5a6a17@mail.gmail.com> <7vfxs2uytm.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0805281326520.19665@iabervon.org> <7vskw2tgu2.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0805281455100.19665@iabervon.org> <7v7idetb1h.fsf@gitster.siamese.dyndns.org> <7vtzgirus5.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA207A9851A8E88C6FC3BC970"
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 08:29:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1bdd-0002bB-BN
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 08:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbYE2G2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 02:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbYE2G2b
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 02:28:31 -0400
Received: from hoat.troll.no ([62.70.27.150]:32957 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182AbYE2G2a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 02:28:30 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 0AA3C20459;
	Thu, 29 May 2008 08:28:25 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id F121E2041E;
	Thu, 29 May 2008 08:28:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <7vtzgirus5.fsf_-_@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83177>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA207A9851A8E88C6FC3BC970
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano said the following on 28.05.2008 23:19:
> When "git checkout -- paths..." cannot update work tree for whatever
> reason, checkout_entry() correctly issued an error message for the path=
 to
> the end user, but the command ignored the error, causing the entire
> command to succeed.  This fixes it.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>=20
>  * Now that we detect this failure, post-checkout-hook _might_ want to
>    know that what we have is an incomplete checkout.  Not calling the h=
ook
>    in such a case may be another option, but we always called the hook =
and
>    that would be a change in behaviour.
>=20
>  builtin-checkout.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/builtin-checkout.c b/builtin-checkout.c

I'd like to just chip in that you actually _can_ create those files=20
(nul, con, prn, all which are "special" filenames on Windows), but=20
need a slight different construct to create them. That, and most tools=20
will break on _using_ them, since they's also have to refer to them in=20
a certain way.

So, certainly msysgit could write a workaround to handle such cases.=20
(Git would also know how to remove these files on Windows)

Though, I still think that your patch is a Good Thing(tm).


For example, if you:

D:\some\path> echo foo > nul    # Ok, an no output, nor file created
D:\some\path> echo foo > .\nul  # Same thing
D:\some\path> echo foo > \\.\d:\some\path\nul  # Creates the nul file

  Directory of D:\some\path

29.05.2008  08:23    <DIR>          .
29.05.2008  08:23    <DIR>          ..
29.05.2008  08:23                 6 con
29.05.2008  08:22                 6 nul
29.05.2008  08:23                 6 prn
                3 File(s)             18 bytes

D:\some\path> del .\nul
The filename, directory name, or volume label syntax is incorrect.

D:\some\path> del \\.\d:\some\path\nul  # Success

--=20
=2Emarius [@trolltech.com]
'if you know what you're doing, it's not research'


--------------enigA207A9851A8E88C6FC3BC970
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFIPk0JKzzXl/njVP8RAtl7AJ0ZU4NiLxCHShLlA12WT9wQvVXlcACeKbUo
/5R+yKHngmfUl3XyaBE3m6E=
=Gphb
-----END PGP SIGNATURE-----

--------------enigA207A9851A8E88C6FC3BC970--
