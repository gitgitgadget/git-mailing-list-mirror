From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Wed, 25 Feb 2009 07:46:45 +0100
Message-ID: <49A4E955.7000103@storm-olsen.com>
References: <1235227723-11471-1-git-send-email-git@storm-olsen.com> <7v8wnzr3k9.fsf@gitster.siamese.dyndns.org> <49A05958.7050703@trolltech.com> <20090223154237.GH22848@spearce.org> <49A2C8D1.3080104@trolltech.com> <20090223161657.GL22848@spearce.org> <7vab8cpqgl.fsf@gitster.siamese.dyndns.org> <49A40372.2060600@tedpavlic.com> <49A40858.6010108@trolltech.com> <49A414B8.8010906@tedpavlic.com> <7vljrvixa3.fsf@gitster.siamese.dyndns.org> <49A44EC6.3070800@storm-olsen.com> <7vk57fdp59.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig39741D01E9E778196D3B255A"
Cc: Ted Pavlic <ted@tedpavlic.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Marius Storm-Olsen <git@storm-olsen.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 07:48:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcDZ6-0004oM-9D
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 07:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792AbZBYGqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 01:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbZBYGqw
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 01:46:52 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:52911 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbZBYGqw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 01:46:52 -0500
Received: by bwz5 with SMTP id 5so6465256bwz.13
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 22:46:48 -0800 (PST)
Received: by 10.223.127.8 with SMTP id e8mr543331fas.95.1235544407830;
        Tue, 24 Feb 2009 22:46:47 -0800 (PST)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id c5sm8064827nfi.68.2009.02.24.22.46.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 22:46:47 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.19) Gecko/20081209 Lightning/0.9 Thunderbird/2.0.0.19 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <7vk57fdp59.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111376>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig39741D01E9E778196D3B255A
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano said the following on 25.02.2009 07:08:
> Marius Storm-Olsen <marius@storm-olsen.com> writes:
>> Junio, unfortunately you applied the incorrect version.
>>
>> It was v3 (Message-Id:
>> <1235244057-16912-1-git-send-email-git@storm-olsen.com>) which was the=

>> correct one, since it's the one that avoids the "GIT_DIR!" in a bare
>> repo. :-/
>=20
> Sorry, I only was looking at the thread that had Shawn's Ack.
> Is this interdiff as a fix-up Ok?

Yup, looks sane to me. Thanks.

--
=2Emarius


--------------enig39741D01E9E778196D3B255A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFJpOlWKzzXl/njVP8RAvq+AKCYyPCwcpjO1LcE8tj7S6C+Mhm5/ACfaC4Z
nlI0V8omKRK7iF8XOPRIAkM=
=RXCJ
-----END PGP SIGNATURE-----

--------------enig39741D01E9E778196D3B255A--
