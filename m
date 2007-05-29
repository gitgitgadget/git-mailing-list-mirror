From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: GIT on MinGW problem
Date: Tue, 29 May 2007 16:36:56 +0200
Message-ID: <465C3A88.3090606@trolltech.com>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org> <465C064F.B9CE9379@eudaptics.com> <465C1252.9020801@trolltech.com> <Pine.LNX.4.64.0705291305540.4648@racer.site> <465C2516.7040607@trolltech.com> <465C2999.677860A6@eudaptics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2BD320597F0F07182B8C4F43"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue May 29 16:39:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht2qp-00087M-Gv
	for gcvg-git@gmane.org; Tue, 29 May 2007 16:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbXE2Oi7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 10:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbXE2Oi7
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 10:38:59 -0400
Received: from esparsett.troll.no ([62.70.27.18]:48443 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbXE2Oi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 10:38:58 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 6071B60116; Tue, 29 May 2007 16:38:57 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id EF5FD600F8; Tue, 29 May 2007 16:38:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.3) Gecko/20070326 Thunderbird/2.0.0.0 Mnenhy/0.7.5.666
In-Reply-To: <465C2999.677860A6@eudaptics.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48694>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2BD320597F0F07182B8C4F43
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Sixt said the following on 29.05.2007 15:24:
>> Looking at the docs for cmd's call (run 'help call'), I see now that
>> it can be written
>>      %~dp0gitk
>> as well..
>=20
> But... the docs also say that this stuff is only available if command
> extensions are turned on. Are they on by default?
>=20
> (I cannot tell because I remember faintly that I fiddled with the
> corresponding registry setting in the past, but don't know whether it
> was on or off at the beginning.)

Ok, MSDN says it on by default on XP, while other docs say its on by
default without specifying any platforms. Also, it might be that the
%~dp0 construct is only supported on later versions of the cmd
extension too (I don't have NT 4, so I can't test this), so to be on
the safe side you can do this:

----
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
if "%1" neq "ensureExt" (
    REM Call the script again with cmd /X to explicitly turn on Command E=
xtensions
    %COMSPEC% /X /C "%0 ensureExt %*"
    goto :EOF
)

REM If our CMD Extension version is less than 2, we might not support the=
 %~dp0
REM construct so, just do the normal _Windows call instead. (This should =
only
REM happen on old Windows NT 4, where the extension is not so sophisticat=
ed
if not cmdextversion 2 (
    call :_Windows %2 %3 %4 %5 %6 %7 %8 %9
    goto :EOF
)
start wish84.exe "%~dp0gitk" %2 %3 %4 %5 %6 %7 %8 %9

:EOF

--=20
=2Emarius


--------------enig2BD320597F0F07182B8C4F43
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGXDqIKzzXl/njVP8RAr2BAJ4yK+D4E0vc3hFFgfC693Cocb3j4wCgtYH5
pXfBZd605ZC4CnMVzpOxoaM=
=078u
-----END PGP SIGNATURE-----

--------------enig2BD320597F0F07182B8C4F43--
