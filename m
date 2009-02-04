From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH v3 3/4] Add map_user() and clear_mailmap() to mailmap
Date: Wed, 04 Feb 2009 09:50:49 +0100
Message-ID: <498956E9.3050606@trolltech.com>
References: <cover.1233584536.git.marius@trolltech.com> <36adb0d2cc4c20c4efb3b03a912b27e67c166855.1233584536.git.marius@trolltech.com> <76e643ff7e99985ce46b6bf36ec967124d7fc6aa.1233584536.git.marius@trolltech.com> <53facc1773745ae477f15103718e08ea6a5ae58d.1233584536.git.marius@trolltech.com> <7v3aeu66hv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2D81DB4068D8F9B3DF3DAE2E"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 09:52:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUdUd-0004Rk-O3
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 09:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbZBDIuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 03:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbZBDIuz
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 03:50:55 -0500
Received: from hoat.troll.no ([62.70.27.150]:40603 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698AbZBDIuy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 03:50:54 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 3B30620B7F;
	Wed,  4 Feb 2009 09:50:48 +0100 (CET)
Received: from [172.24.90.95] (unknown [172.24.90.95])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 2D43520B32;
	Wed,  4 Feb 2009 09:50:48 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.19) Gecko/20081209 Lightning/0.9 Thunderbird/2.0.0.19 Mnenhy/0.7.5.666
In-Reply-To: <7v3aeu66hv.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108315>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2D81DB4068D8F9B3DF3DAE2E
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano said the following on 04.02.2009 07:50:
> Marius Storm-Olsen <marius@trolltech.com> writes:
> Use of ample paragraph breaks would make it much easier to eyes.

Ok.

> Also, the example shows how lines would look line in a mailmap
> file.  I would avoid giving a false impression that the parser
> should take C++ style comment introducer // by using '#' which is a
> documented one (I suspect anything that follows the last angle
> bracket is simply ignored, though).

Right, it is, but I agree with your point.


>> @@ -86,6 +95,27 @@ Jane Doe <jane@desktop.(none)>
>>  Joe R. Developer <joe@random.com>
>=20
> This context line was updated a few days ago (not a big deal, just in c=
ase
> you didn't know).

Right, I saw the patch on the list, but I based the patch series on=20
master, which I don't think had the update at the time? Anyways, do=20
you prefer the patches based on next instead?=20
(Documentation/SubmittingPatches says master, but maybe that has changed)=



>> +#if DEBUG_MAILMAP
>> +#define debug_mm(...) fprintf(stderr, __VA_ARGS__)
>> +#else
>> +inline void debug_mm(const char *format, ...) {}
>> +#endif
>=20
> "static inline void ...";

Sure. (I seriously hope that the compiler optimizes that empty=20
function call away for me though, without specifying inline :-)


>> @@ -37,25 +117,65 @@ static int read_single_mailmap(struct string_list=
 *map, const char *filename, ch
>> ...
>> +		/* Locate 2nd name and email. Possible mappings in mailmap file are=
:
>> +		 *   proper_name <commit_email>
>> +		 *   proper_name <proper_email> <commit_email>
>> +		 *   proper_name <proper_email> commit_name <commit_email>
>> +		 */
>=20
> 	/*
>          * We tend to write a multi line comment block
>          * like this.
>          */

Ok.

>> +		do {
=2E..
>> +			if ((left_bracket2 =3D strchr(right_bracket1, '<')) =3D=3D NULL)
>> +				continue;
=2E..
>> +		} while(0);
>=20
> Yuck.  Is it just me or is this new codeblock especially denser
> than existing code?  I wonder use of a few smaller helper functions
> (that the compiler may be able to inline without being told for us)
> would make this easier to read without funny-looking "do { ... if
> (...) continue; } while (0)" trick?

Heh, It was mostly a copy'n'paste from the previous code block, with=20
minor tweaks and variable renaming. I'll factor things out to make it=20
an easier read.

> Two "char *tmp" in this scope are both decl-after-statement errors.

Yikes! I wonder why I never got any compiler notification about those.=20
They should never have been there, sorry.

--=20
=2Emarius [@trolltech.com]
'if you know what you're doing, it's not research'


--------------enig2D81DB4068D8F9B3DF3DAE2E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFJiVbpKzzXl/njVP8RAg7RAKCHeDMB128cjfPeXul8PIXSjUL2IACcDn2V
NW3qR14D48GHmwNhpIlmSKw=
=eJMz
-----END PGP SIGNATURE-----

--------------enig2D81DB4068D8F9B3DF3DAE2E--
