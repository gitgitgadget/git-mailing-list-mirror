From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Teach core.autocrlf to 'git blame'
Date: Wed, 17 Oct 2007 12:57:47 +0200
Message-ID: <4715EAAB.3020705@trolltech.com>
References: <1191586411-7436-1-git-send-email-marius@trolltech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE2899E703EB986938226D816"
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 12:58:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii6bM-0003VB-Le
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 12:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758113AbXJQK5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 06:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757742AbXJQK5u
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 06:57:50 -0400
Received: from esparsett.troll.no ([62.70.27.18]:38350 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757703AbXJQK5s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 06:57:48 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 04715741CF; Wed, 17 Oct 2007 12:57:47 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id E3C4F741CA; Wed, 17 Oct 2007 12:57:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <1191586411-7436-1-git-send-email-marius@trolltech.com>
X-Enigmail-Version: 0.95.3
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61365>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE2899E703EB986938226D816
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Just a reminder of this one, as I didn't see it any "What's in"=20
reports, nor your http://repo.or.cz/w/git/spearce.git repo.
(It's normal git.git patch, not an msysgit patch :-)

--=20
=2Emarius

Marius Storm-Olsen said the following on 05.10.2007 14:13:
> Pass the fake commit through convert_to_git, so that the
> file is adjusted for local line-ending convention.
>=20
> Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
> ---
>  Added missing signoff in the previous mail.
>=20
>  builtin-blame.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/builtin-blame.c b/builtin-blame.c
> index e3112a2..8432b82 100644
> --- a/builtin-blame.c
> +++ b/builtin-blame.c
> @@ -2059,6 +2059,7 @@ static struct commit *fake_working_tree_commit(co=
nst char *path, const char *con
>  		if (strbuf_read(&buf, 0, 0) < 0)
>  			die("read error %s from stdin", strerror(errno));
>  	}
> +	convert_to_git(path, buf.buf, buf.len, &buf);
>  	origin->file.ptr =3D buf.buf;
>  	origin->file.size =3D buf.len;
>  	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);



--------------enigE2899E703EB986938226D816
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFHFeqrKzzXl/njVP8RAvasAJ9xf4NDFCpz0daL9W3IAh4sDxGTQgCfUtNV
h5apG1MfqEEHBbtSyOyontk=
=Pust
-----END PGP SIGNATURE-----

--------------enigE2899E703EB986938226D816--
