From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: [PATCH] .gitignore git-rerere and config.mak
Date: Wed, 08 Feb 2006 00:23:41 +0100
Message-ID: <43E92BFD.7060909@gorzow.mm.pl>
References: <20060207172234.41A975BF02@nox.op5.se> <7vk6c7uj21.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0602071951370.26070@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig75249AC97475F85017F0B87C"
Cc: Junio C Hamano <junkio@cox.net>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 01:47:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6dUj-0008RG-VZ
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 01:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbWBHArj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 19:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbWBHArj
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 19:47:39 -0500
Received: from goliat1.kalisz.mm.pl ([81.15.136.226]:40921 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S1030315AbWBHAri (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 19:47:38 -0500
Received: (qmail 1996 invoked from network); 8 Feb 2006 00:47:33 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.201.167])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <junkio@cox.net>; 8 Feb 2006 00:47:33 -0000
Received: from [192.168.0.1] (zen.uplink [192.168.0.1])
	by zen.uplink (Postfix) with ESMTP id 24403178696;
	Wed,  8 Feb 2006 00:23:46 +0100 (CET)
User-Agent: Thunderbird 1.4.1 (X11/20051010)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602071951370.26070@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15725>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig75249AC97475F85017F0B87C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> Hi,
>=20
> On Tue, 7 Feb 2006, Junio C Hamano wrote:
>=20
>> Andreas Ericsson <ae@op5.se> writes:
>>
>>> --- a/.gitignore
>>> +++ b/.gitignore
>>> @@ -123,3 +124,4 @@ git-core.spec
>>>  libgit.a
>>>  *.o
>>>  *.py[co]
>>> +config.mak
>> I am not sure about this part.  It is plausible that somebody
>> who privately uses config.mak has it in _his_ repository under
>> version control.  Should we list it in .gitignore?
>=20
> I have it in .gitignore. If there were changes to config.mak which I ha=
d=20
> in all my copies of git, I'd have them directly in the Makefile.
>=20
> Hth,
> Dscho

Somehow git-rerere didn't end up getting included in .gitignore...

--=20
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm


--------------enig75249AC97475F85017F0B87C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD6SwBlUMEU9HxC6IRArEVAJ9IoBaN8nxC5o5f1dSMsF7vcDqBFACgqaoS
4XdIXlc21KDs2ZQebGJKpdI=
=/5xP
-----END PGP SIGNATURE-----

--------------enig75249AC97475F85017F0B87C--
