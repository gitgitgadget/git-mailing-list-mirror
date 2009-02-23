From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Mon, 23 Feb 2009 08:52:31 +0100
Message-ID: <49A255BF.5040905@trolltech.com>
References: <1235227723-11471-1-git-send-email-git@storm-olsen.com> <7v8wnzr3k9.fsf@gitster.siamese.dyndns.org> <49A05958.7050703@trolltech.com> <7v63j22z92.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig039DCF2C6D0FAB426E842394"
Cc: Marius Storm-Olsen <git@storm-olsen.com>, spearce@spearce.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 08:54:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbVdd-0005oD-DO
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 08:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbZBWHwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 02:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbZBWHwg
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 02:52:36 -0500
Received: from hoat.troll.no ([62.70.27.150]:47471 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350AbZBWHwf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 02:52:35 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id D478B20F8E;
	Mon, 23 Feb 2009 08:52:31 +0100 (CET)
Received: from [172.24.90.95] (unknown [172.24.90.95])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id C4C6C20F7E;
	Mon, 23 Feb 2009 08:52:31 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.19) Gecko/20081209 Lightning/0.9 Thunderbird/2.0.0.19 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <7v63j22z92.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111115>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig039DCF2C6D0FAB426E842394
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano said the following on 22.02.2009 17:49:
> Marius Storm-Olsen <marius@trolltech.com> writes:
>>> There may be a different workflow where you would stay in a
>>> bare repository for an extended period of time and you would
>>> benefit from such a reminder like this patch adds, but I do not
>>> think of one.
>>>=20
>>> Care to enlighten?
>> Right, I have quite a few repos on my machine which are just
>> bare, as I use them gather branches and push out again.
>> (http://repo.or.cz/w/git/platforms.git is one of them) However,=20
>> it's probably just me, since I could just as easily put them in a
>> proper directory structure to indicate their bareness.
>=20
> Ah, so "gather branches and push out again" would look something
> like this?
>=20
>     $ cd /pub/some/where/platforms.git
>     $ git fetch platform1 ;# perhaps with master:one/master mapping
>     $ git fetch platform2 ;# perhaps with master:two/master
>     $ git push public
>=20
> Then it is very understandable that you would spend time inside a
> bare repository.  I do not understand the need for GIT_DIR! thing
> even less, but since we have that there already, I do not see a
> reason not to add this to the queue.

Indeed that's somewhat how I work.
Also, given the new GIT_DIR! "feature", I cannot simply keep my=20
"BARE:" in my own .bash_rc anymore, since then I'd just get
     (BARE:GIT_DIR!)
which is less than useful. So, given that the overhead and impact to=20
the current logic is minimal, I would appreciate the patch being queued.

Thanks!

--=20
=2Emarius [@trolltech.com]
'if you know what you're doing, it's not research'


--------------enig039DCF2C6D0FAB426E842394
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFJolW/KzzXl/njVP8RAi7cAJ9xta6XdB41Xu2eYNJCrl3nEys7CQCfSb0o
Ta6OJO8jAi3HkZV7K+OrrPM=
=QM8G
-----END PGP SIGNATURE-----

--------------enig039DCF2C6D0FAB426E842394--
