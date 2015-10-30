From: =?UTF-8?Q?Vladimir_'=cf=86-coder/phcoder'_Serbinenko?= 
	<phcoder@gmail.com>
Subject: Re: Anonymous commit (empty Author and Committer)
Date: Fri, 30 Oct 2015 21:09:04 +0100
Message-ID: <5633CE60.8060907@gmail.com>
References: <56337DF8.5050802@gmail.com> <5633CDCD.10004@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Bhdnco7q4G6txxEFdTJUjUbC6vupiKSlw"
To: The development of GNU GRUB <grub-devel@gnu.org>,
	git@vger.kernel.org, savannah-users@gnu.org
X-From: git-owner@vger.kernel.org Fri Oct 30 21:09:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsFz6-0003PT-SZ
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 21:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760833AbbJ3UJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 16:09:08 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34058 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760771AbbJ3UJH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 16:09:07 -0400
Received: by wikq8 with SMTP id q8so18117892wik.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 13:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-type;
        bh=S4EnCJxXbchtFiJ9q9KmjwsWwIeu3DCyo4VVuwZR1qA=;
        b=PUNMsk2gElPFahsL8FBywJlgq+1pj3DUOcvR51ERn1cskWSbE0Z4voFoib1REFNezY
         Z9Yo71NqNqyo/NWt4ImQZwmZEfnOq2OEsYDmZMyegWro0BgmSivHniQFtZYookdUy+GY
         thbzzcWSqTaMMDoSp9p3z3p+ljNu1DT+QZwENZ1OGrynVIuNT1qW2BMQEEU7oT3ulz7R
         1/tcBkualcNdrv68HRG15cgTyIlpILA1z2GCoE6k5US9N1LBFIc8fsufVLWoOZRM88Gl
         wGSvoyS6NolrLak779xOwxz8C37boz+8wHDCkpw+1HW3y7zwz6xl5tJOknvcoZPyuTLb
         rmiw==
X-Received: by 10.194.90.79 with SMTP id bu15mr12435719wjb.36.1446235745726;
        Fri, 30 Oct 2015 13:09:05 -0700 (PDT)
Received: from ?IPv6:2a02:1205:34c8:dc00:863a:4bff:fe50:abc4? ([2a02:1205:34c8:dc00:863a:4bff:fe50:abc4])
        by smtp.gmail.com with ESMTPSA id vr10sm8627085wjc.38.2015.10.30.13.09.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2015 13:09:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.3.0
In-Reply-To: <5633CDCD.10004@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280537>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Bhdnco7q4G6txxEFdTJUjUbC6vupiKSlw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.10.2015 21:06, Vladimir '=CF=86-coder/phcoder' Serbinenko wrote:
> On 30.10.2015 15:26, Andrei Borzenkov wrote:
>> See
>> http://git.savannah.gnu.org/cgit/grub.git/commit/?id=3D206676601eb853f=
c319df14cd3398fbdfde665ac
>>
>>
>> I was not even aware that this is possible. Is there anything on serve=
r
>> side that can prevent it?
>>
>> Would be good if commit were amended and force pushed to fix it.
>>
> It is a bug in SGit. I'll investigate how it happened
>> _______________________________________________
>> Grub-devel mailing list
>> Grub-devel@gnu.org
>> https://lists.gnu.org/mailman/listinfo/grub-devel
>> .
>>
>=20
>=20



--Bhdnco7q4G6txxEFdTJUjUbC6vupiKSlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREKAAYFAlYzzmAACgkQmBXlbbo5nOviygD+KOxrSqixWXZTdamko2tJMzdN
99Eqbdl2GIj+hx1nsKMBAIzU751rzyg3M0hWQGcHH//qMuDhaZMXVgzSXKkAcQiG
=OBGf
-----END PGP SIGNATURE-----

--Bhdnco7q4G6txxEFdTJUjUbC6vupiKSlw--
