From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: '.git file' alternative, native (cross-platform)
 workdir support.
Date: Fri, 29 Feb 2008 15:51:52 +0100
Message-ID: <47C81C08.2060608@trolltech.com>
References: <47C7FA49.9010001@trolltech.com> <alpine.LSU.1.00.0802291248510.22527@racer.site> <47C80786.4070701@trolltech.com> <alpine.LSU.1.00.0802291333310.22527@racer.site>
Reply-To: marius@trolltech.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="------------enigA6FC5B0BC2B8339EF59960E4"
Cc: Git Mailing List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Feb 29 15:52:51 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.160])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV6bI-00035n-89
	for gcvm-msysgit@m.gmane.org; Fri, 29 Feb 2008 15:52:40 +0100
Received: by ug-out-1516.google.com with SMTP id 1so681554uga.9
        for <gcvm-msysgit@m.gmane.org>; Fri, 29 Feb 2008 06:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:face:content-type:x-virus-scanned:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=hAG8AhiZLy/MbVhChuQOs0Bb7VONsWWUamH4hU7gur4=;
        b=dY/5rGSKYv81P7+mSfOCxuCs4YkxyJfN/5r5b8XuyCr6QkrArRgFauu8hGXRg9cx930Nb4k56TyHqhi05F4CwYOL8UuK6wkmCxnMAaXul2XnCmASx1eJ0/rzmYka581EGLLESEoRXLNYtKLHOcsTmaTTuwja2Q8/lNBFBvHASXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:face:content-type:x-virus-scanned:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=RUfTdFtMD8MpZtC5kMzgqozbIZbft3qUCw7ywItKXO5M2cYbJCpPcG1bNq1qMucaIFg3Rv412usdNq/ey6ZVPB5eq/pZ6HRhGiVVxF7VWt7Ja2uP/5s9zGK0VxIP4j1fHtCD5wqvLvKvu7igqlLQCVsj+wpD2uA5R9CZRqLMS1w=
Received: by 10.142.254.8 with SMTP id b8mr434097wfi.29.1204296723211;
        Fri, 29 Feb 2008 06:52:03 -0800 (PST)
Received: by 10.106.177.2 with SMTP id z2gr1860pre.0;
	Fri, 29 Feb 2008 06:52:03 -0800 (PST)
X-Sender: marius@trolltech.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.131.9 with SMTP id e9mr7328892wad.5.1204296722811; Fri, 29 Feb 2008 06:52:02 -0800 (PST)
Received: from hoat.troll.no (hoat.troll.no [62.70.27.150]) by mx.google.com with ESMTP id k36si216085waf.0.2008.02.29.06.51.54; Fri, 29 Feb 2008 06:52:01 -0800 (PST)
Received-SPF: neutral (google.com: 62.70.27.150 is neither permitted nor denied by best guess record for domain of marius@trolltech.com) client-ip=62.70.27.150;
Authentication-Results: mx.google.com; spf=neutral (google.com: 62.70.27.150 is neither permitted nor denied by best guess record for domain of marius@trolltech.com) smtp.mail=marius@trolltech.com
Received: from localhost (localhost [127.0.0.1]) by hoat.troll.no (Postfix) with ESMTP id CA002581BE; Fri, 29 Feb 2008 15:51:09 +0100 (CET)
Received: from hoat.troll.no ([127.0.0.1]) by localhost (hoat.troll.no [127.0.0.1]) (amavisd-maia, port 10024) with LMTP id 30200-06; Fri, 29 Feb 2008 15:51:09 +0100 (CET)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215]) by hoat.troll.no (Postfix) with ESMTP id 7E53E5812B; Fri, 29 Feb 2008 15:51:09 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
In-Reply-To: <alpine.LSU.1.00.0802291333310.22527@racer.site>
X-Enigmail-Version: 0.95.6
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1 KOEmUlJISdYPgEgehw+cTZEf6xeF
 yoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
X-Virus-Scanned: Maia Mailguard 1.0.2a
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75541>


This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA6FC5B0BC2B8339EF59960E4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin said the following on 29.02.2008 15:25:
> On Fri, 29 Feb 2008, Marius Storm-Olsen wrote:
>> I'm actually not sure that it's impossible to make it safe. My=20
>> implementation works by redirecting files into the real repo.
>> However, we can also detect when redirection is in effect, and do
>> extra 'maintainance' things then, to avoid the bad effects.
>=20
> From the perspective of Windows, I guess it is easy to overlook the
> fact that permissions can break your idea.
>=20
> Even after creating a second working tree for an existing
> repository, the permissions of the original repository can change.

Sure, but that would break _any_ working tree implementation. Without=20
access to the original data, it whole thing is bust, no matter if you=20
redirect all or part of .git/.

Checking if we have access to the redirected .git is trivial in both=20
cases. (partial or whole redirection)

> The only way to be on the safe side is to use _the repository_
> twice.  IOW not having a second .git/ directory.
>=20
> Also, having a single .git is just a very simple, and thus
> preferable concept, to having part of this, and part of that
> repository.

I whole heartedly agree. I'm not proposing to keep it split in the=20
long run. I'm just proposing something that 'works' *now*, and can be=20
improved incrementally; as opposed to, doesn't work now, and needs to=20
be fully implemented before it works for the Windows crowd.

PS. The redirection method I propose already alleviates an issue of=20
the current git-new-workdir has, which Shawn has experienced many=20
atime: The deletion of .git/config and .git/packed-refs, making=20
'git-config' and 'git tag -d' unsafe in a workdir. (Though I'm unsure=20
if that has been fixed already. In any case, since the files are=20
really redirected, there no chance that deleting a file will remove a=20
synlink, only to be recreated as a normal file instead)

--=20
=2Emarius


--------------enigA6FC5B0BC2B8339EF59960E4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFHyBwIKzzXl/njVP8RAjs8AJ48+B3/yLUgIe4KaaiYR9wO84BEoACfchEX
/1NEIAqw8SlJ5/HZFGga2IM=
=cEgh
-----END PGP SIGNATURE-----

--------------enigA6FC5B0BC2B8339EF59960E4--
