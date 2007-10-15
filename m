From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Mon, 15 Oct 2007 08:04:02 +0200
Message-ID: <471302D2.6010405@trolltech.com>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org> <F32B0EEF-496C-4D6D-BD9A-B6A0C04E0EE3@wincent.com> <854pgtonp5.fsf@lola.goethe.zz> <200710141709.51579.chriscool@tuxfamily.org> <4712400C.2080900@lsrfire.ath.cx> <85y7e5ll38.fsf@lola.goethe.zz> <522E90CF-FC15-472F-B0A8-91C310CAF9BF@wincent.com> <471250BC.7070307@trolltech.com> <85d4vhlh8y.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4D8BCB525D06996BC8E8D45A"
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Wincent Colaiuta <win@wincent.com>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 08:04:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhJ3t-0005G2-78
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 08:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbXJOGEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 02:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbXJOGEG
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 02:04:06 -0400
Received: from esparsett.troll.no ([62.70.27.18]:41518 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbXJOGEF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 02:04:05 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 2A66E74265; Mon, 15 Oct 2007 08:04:02 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id EE6DF74247; Mon, 15 Oct 2007 08:04:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <85d4vhlh8y.fsf@lola.goethe.zz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60948>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4D8BCB525D06996BC8E8D45A
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

David Kastrup said the following on 14.10.2007 19:48:
> Marius Storm-Olsen <marius@trolltech.com> writes:
>=20
>> Wincent Colaiuta said the following on 14.10.2007 18:35:
>>
>>> "undecided" sounds good to me. It should be clear to non-native
>>> speakers of English (at least, clearer than "dunno").
>> What about just "unknown"?
>=20
> I tend to nitpick to the degree of silliness when my own suggestions
> are concerned, but "unknown" sounds to me like the state _before_ the
> test.  If a person says he is "undecided" about something that means
> that he _has_ thought about it already.  "Undecidable" might bring
> this distinction across more strongly, but it is a more complicated
> word and it insinuates that it is _impossible_ to come to a decision
> regardless of the spent effort.
>=20
> "unknown" clearly is much better than "dunno" though even if my own
> favorite would be "undecided".

What then about a good'ol programming favorite, "void"? :-)

I agree that "unknown" might be a state even _before_ a person has=20
determined if a case is good or bad (same for 'dunno' actually: "- Do=20
you know if it works? - I dunno yet") When I think more about it, I=20
really like "void"..

"Argh, this test is void, because someone messed with it"
"We can't make heads or tails of this one, so it must be void"

--=20
=2Emarius


--------------enig4D8BCB525D06996BC8E8D45A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFHEwLSKzzXl/njVP8RAsmKAKCM+GpEPPdaK/+Tlw7ByM5J6L/yJQCcDejv
s2eHHtpoKwkqG9GwDeJPp54=
=OiQo
-----END PGP SIGNATURE-----

--------------enig4D8BCB525D06996BC8E8D45A--
