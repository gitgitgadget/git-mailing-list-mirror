From: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
Subject: Re: builtin-add.c patch
Date: Wed, 10 Dec 2008 10:01:48 -0600
Message-ID: <200812101001.53738.bss03@volumehost.net>
References: <200812101238.mBACcWQk023480@axiom-developer.org> <20081210142632.GA4137@myhost>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4235280.kCDiMEPY1A";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: daly@axiom-developer.org, git@vger.kernel.org
To: Alexander Potashev <aspotashev@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 17:03:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LARWn-0002Jf-G9
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 17:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029AbYLJQBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 11:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754009AbYLJQBu
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 11:01:50 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:49291 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959AbYLJQBu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 11:01:50 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20081210160149.JBHG8485.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 10 Dec 2008 11:01:49 -0500
Received: from [10.0.0.123] ([72.204.50.125])
	by fed1rmimpo02.cox.net with bizsmtp
	id pU1o1a00B2i4SyG04U1oyv; Wed, 10 Dec 2008 11:01:49 -0500
X-Authority-Analysis: v=1.0 c=1 a=nEQGfrJnAAAA:8 a=w8O3Re80UUIvtbRo6TMA:9
 a=J5dJ5qmkj2z3sIpT_5mfxZZTshEA:4 a=B7iFY6Z7H_gA:10 a=LY0hPdMaydYA:10
 a=JGSsVXMVDCkLigxfH1QA:9 a=6Nr9MsWAE-yzKlB72y73AzdtovwA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
User-Agent: KMail/1.9.9
In-Reply-To: <20081210142632.GA4137@myhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102694>

--nextPart4235280.kCDiMEPY1A
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 2008 December 10 08:26:32 Alexander Potashev wrote:
>> diff --git a/builtin-add.c b/builtin-add.c
>> index ea4e771..5f2e68b 100644
>> --- a/builtin-add.c
>> +++ b/builtin-add.c
>> @@ -23,7 +23,7 @@ static void fill_pathspec_matches(const char **pathspe=
c,
>> char *seen, int specs) int num_unmatched =3D 0, i;
>>
>>  	/*
>> -	 * Since we are walking the index as if we are warlking the directory,
>> +	 * Since we are walking the index as if we are walking the directory,
>
>We probably should use subjunctive here:
>"Since we are walking the index as if we _were_ walking the directory,".
>
>Are there any native English speakers? :)

Southern bah the grace o' gawd. :)

Yes, the subjunctive is the appropriate tense for use in hypotheticals ("as=
=20
if").
=2D-=20
Boyd Stephen Smith Jr. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ,=3D ,-_-. =
=3D.=20
bss03@volumehost.net =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((_/)o o(\_=
))
ICQ: 514984 YM/AIM: DaTwinkDaddy =A0 =A0 =A0 =A0 =A0 `-'(. .)`-'=20
http://iguanasuicide.org/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\_/ =
=A0 =A0=20

--nextPart4235280.kCDiMEPY1A
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkk/5/EACgkQdNbfk+86fC0dYwCfUG4WmuTWFNQz/9U+pU4Cqeod
Ek4An2dsUmrbZQ7ij6zf9pY61XHlV1pK
=W3AB
-----END PGP SIGNATURE-----

--nextPart4235280.kCDiMEPY1A--
