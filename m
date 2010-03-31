From: Yawar Amin <yawar.amin@gmail.com>
Subject: Re: [PATCH] Documentation: clarify grammar
Date: Wed, 31 Mar 2010 08:11:08 -0400
Message-ID: <4BB33BDC.5000406@gmail.com>
References: <4BB2B34B.1080508@gmail.com> <p2kf3271551003302216qc6e378a8u2f85751c9c8a24d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig15B840AFBAED3EC62E1CEEE6"
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 14:11:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwwlx-0003vs-N1
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 14:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757375Ab0CaML1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 08:11:27 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54235 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757243Ab0CaMLW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 08:11:22 -0400
Received: by vws20 with SMTP id 20so6821vws.19
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 05:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type;
        bh=R+6QRczTfol9gf1fSS65/3FBj4dl4H51iBt7YvweiLY=;
        b=WPNaOjrvlhjar7gvYNyg7mAA+0mfo5k8AxeioXuDDpGfcOpJ6/hPwzd6+gxg+A66MK
         tWWi5uWoRnqNUhto+CoojnUAnHMxgIk00oj8JD/bXf00eOzQSdoK4L6ps4vuD+YUPQ/O
         oqTIqsvVM7A+30bKfksX76ODCTzBMQBYGATvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        b=UMuQsA97lfMcYe3N30C5iZMe04hm3iXw3VHQWKcXDcl9rh3nroWxp+fCoWiBdOdZYk
         /bYesqmS5TQkOAYSKT2mS8ftIYZ2kNMm8VCCc5+Ywskq6zYOeuOOwSrKvT0C8L2AMb5S
         6xqbORAD+22pccRim2Wnk+sUlxGHg9vdDGNfU=
Received: by 10.220.108.227 with SMTP id g35mr4385695vcp.184.1270037480774;
        Wed, 31 Mar 2010 05:11:20 -0700 (PDT)
Received: from Yawar-Quadir-Amins-MacBook.local (CPE00173f9e1ecd-CM0014e827917c.cpe.net.cable.rogers.com [99.230.35.242])
        by mx.google.com with ESMTPS id 25sm142636747vws.4.2010.03.31.05.11.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 31 Mar 2010 05:11:19 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (Macintosh/20100228)
In-Reply-To: <p2kf3271551003302216qc6e378a8u2f85751c9c8a24d5@mail.gmail.com>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143667>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig15B840AFBAED3EC62E1CEEE6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 3/31/10 1:16 AM, Ramkumar Ramachandra said:
> Hi,
>
> On Wed, Mar 31, 2010 at 7:58 AM, Yawar Amin <yawar.amin@gmail.com> wrot=
e:
>  =20
>> Parenthesize the mention of the git protocol to make it clear that
>> `former' and `latter' refer to the standard SSH syntax and the
>> alternate SCP-like syntax, rather than the SSH protocol and git
>> protocol.
>>    =20
>
> I've already submitted a patch to rewrite large portions of the
> urls.txt page [1]. Kindly submit patches against that.
>  =20

I see there are some extensive changes. Do you have a public repo I
could pull from and base my patch on? That should make things easier.

Thanks,

Yawar



--------------enig15B840AFBAED3EC62E1CEEE6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEAREIAAYFAkuzO+IACgkQqOXNpejCDdSBHgCaA0LAKXvxHTnC3f7KP2BzmJQl
EKoAoKfu3I7mk1xttUHuSGqjX+6J/gc2
=A8aa
-----END PGP SIGNATURE-----

--------------enig15B840AFBAED3EC62E1CEEE6--
