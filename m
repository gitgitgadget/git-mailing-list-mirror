From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: GIT on MinGW problem
Date: Tue, 29 May 2007 15:05:26 +0200
Message-ID: <465C2516.7040607@trolltech.com>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org> <465C064F.B9CE9379@eudaptics.com> <465C1252.9020801@trolltech.com> <Pine.LNX.4.64.0705291305540.4648@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig722EFC81590DED496CCEF973"
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 29 15:07:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht1QN-0001mo-1V
	for gcvg-git@gmane.org; Tue, 29 May 2007 15:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbXE2NHa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 09:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbXE2NHa
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 09:07:30 -0400
Received: from esparsett.troll.no ([62.70.27.18]:40702 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbXE2NH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 09:07:29 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 38BC060057; Tue, 29 May 2007 15:07:27 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id DADB060002; Tue, 29 May 2007 15:07:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.3) Gecko/20070326 Thunderbird/2.0.0.0 Mnenhy/0.7.5.666
In-Reply-To: <Pine.LNX.4.64.0705291305540.4648@racer.site>
X-Enigmail-Version: 0.95.0
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48689>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig722EFC81590DED496CCEF973
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin said the following on 29.05.2007 14:11:
>> Also, the /bin/gitk.bat file should rather be=20
>> @"%~d0%~p0wish84.exe" "%~d0%~p0gitk" %* than the current
>> hardcoded path. (Probably won't work with command.com, but who
>> uses that for development nowadays anyways, right ;-)
>=20
> We're open source, so we _can_ do better than leaving people stuck
> on older hardware behind.
>=20
> And I don't know what this garbage means. (I checked with GMane,
> and it looks the same there.) I'd rather have something readable,
> even if it is slightly slower or has to be adjusted when
> installing.

%~d0 =3D expands %0 to a drive letter only
%~p0 =3D expands %0 to a path only

so, for
     C:\foo\bar\baz\gitk.bat
%~d0%~p0gitk would expand to
     C:\foo\bar\baz\gitk

Looking at the docs for cmd's call (run 'help call'), I see now that=20
it can be written
     %~dp0gitk
as well..

Anyways, if people are critical to not supporting the command.com,=20
then you could do something like the following. (Note that for=20
command.com it would be the old behavior were you need to replace the=20
path if you install Git somewhere else, while for cmd.exe users it=20
will just work. I'm sure magic can be done to make it work with=20
command.com as well, but I'll leave that up to someone else to play with)=
:

---
@echo off
REM This GOTO relies on the hack that command.com only supports
REM 8 character labels, so it reads 'goto _Windows'
goto :_WindowsNT

REM Command.com jumps here
:_Windows
wish84.exe "C:\Git\usr\bin\gitk" %1 %2 %3 %4 %5 %6 %7 %8 %9
REM NOTE! If you install Git in some other path, and use
REM command.com, you need to replace the path above

goto :EOF

REM Cmd.exe jumps here
:_WindowsNT
start wish84.exe "%~dp0gitk" %*

:EOF

--=20
=2Emarius


--------------enig722EFC81590DED496CCEF973
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGXCUWKzzXl/njVP8RAqIwAJ9CJurgZxEKPjIEIT9E9IoeTnPWqACfcobr
WD2DOd1XgGepUCRYVMqwIak=
=MsJS
-----END PGP SIGNATURE-----

--------------enig722EFC81590DED496CCEF973--
