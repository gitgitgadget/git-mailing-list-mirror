From: Yawar Amin <yawar.amin@gmail.com>
Subject: Re: [PATCH] Documentation: clarify grammar
Date: Thu, 01 Apr 2010 21:23:39 -0400
Message-ID: <4BB5471B.60606@gmail.com>
References: <4BB2B34B.1080508@gmail.com> <p2kf3271551003302216qc6e378a8u2f85751c9c8a24d5@mail.gmail.com> 	<4BB33BDC.5000406@gmail.com> <q2jf3271551003310538z643e637g5bb7bc6691f46055@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig4CF36BC6D932FD021DE45606"
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 03:23:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxVc1-0006p4-LM
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 03:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757453Ab0DBBXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 21:23:51 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55944 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757447Ab0DBBXt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 21:23:49 -0400
Received: by vws13 with SMTP id 13so370984vws.19
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 18:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type;
        bh=BZOZUwb/Ix7cDPr1ZJlO9KndRplE9f5M6DpYcpBRUzA=;
        b=mELR8S2Y+xLTVnC65DtFuvsyMZwQYmjCzqIeDprD94v8TZxHX57pMv+iGplFaFi9DK
         6xe7BCk5VVPAJ69pL1xHUTFFFptwSbsLPBZKwxKWfWdkPYCTtESid4VeRpkEoYDPc+x6
         RSywLdu4EzYam0jxrfpbN5mcVaBTq5KKx0quI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        b=TZOcFRMnzxyDJx3BnA4fGE3Du0AxyYUS5FeOPw4nD5u9PVTMOLppa8OX30eLeSrOjh
         WExT3dVzBLmQId2RJmozk+YjJHW5nvCSRc0Gg0FP91NmOEcMsD4zVZojaUZA378XkgUl
         DfjPwO2TjqJZsfHROfm7vIQzg5+VejXWMegAE=
Received: by 10.220.126.201 with SMTP id d9mr850417vcs.106.1270171428242;
        Thu, 01 Apr 2010 18:23:48 -0700 (PDT)
Received: from Yawar-Quadir-Amins-MacBook.local (CPE00173f9e1ecd-CM0014e827917c.cpe.net.cable.rogers.com [99.230.35.242])
        by mx.google.com with ESMTPS id 31sm179427792vws.7.2010.04.01.18.23.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Apr 2010 18:23:46 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (Macintosh/20100228)
In-Reply-To: <q2jf3271551003310538z643e637g5bb7bc6691f46055@mail.gmail.com>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143770>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4CF36BC6D932FD021DE45606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 3/31/10 8:38 AM, Ramkumar Ramachandra said:
>> I see there are some extensive changes. Do you have a public repo I
>> could pull from and base my patch on? That should make things easier.
>>    =20
>
> Um, yes but considering that this is just a simple documentation
> patch, we can probably just wait for Junio to pick it up- a few days.
>  =20

I'll wait a few days and resubmit. :-)

Thanks,

Yawar



--------------enig4CF36BC6D932FD021DE45606
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEAREIAAYFAku1RyEACgkQqOXNpejCDdRJpQCePoCeDkPX6Xc+N3tMmgzAw7ea
BRYAn1N2AY8WxUkGNvTGO9W3p4kTfZTt
=PBDa
-----END PGP SIGNATURE-----

--------------enig4CF36BC6D932FD021DE45606--
