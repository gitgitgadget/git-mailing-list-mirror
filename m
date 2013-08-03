From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCHv3 0/9] Removing deprecated parsing macros
Date: Sat, 03 Aug 2013 13:55:40 +0200
Message-ID: <51FCEFBC.5070601@googlemail.com>
References: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig41446AF781D1821A8755C3C6"
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 13:55:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5aQa-0006N6-Cy
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 13:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689Ab3HCLzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 07:55:13 -0400
Received: from mail-ea0-f178.google.com ([209.85.215.178]:55913 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab3HCLzM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 07:55:12 -0400
Received: by mail-ea0-f178.google.com with SMTP id a15so750234eae.23
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 04:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=y9CnLQXgy4UYWjfEYBuZzxZmX11OeST0XI4XxDXc9o4=;
        b=ly0BeltVpN2SZgXnA6BS9VkFnmrx7NV6b4NhBrVyXaCR8MrX91SzI+/H4BWrAgd/C+
         HhNu292HUDZW+aRKuIcQsQHxMJRpDZ7wkw9mrz4LUu3Y1uGdURtI0AHYho9NME7C7TXm
         pyHJoUnQHtj+DdX+IV5PPiB+cvd1Zeby/Qh/TBkMYCtLOCDS6tyYz5ubohAvlAz2iWZe
         Yn7P8LDeZn3SfMGnTY9qFR0/ogaVlzGclrA0Bmu8ai/2vk6RZmWf5eLTC5eV22eIwdQw
         tiBJ0RBAzPY5W4pRSOOzaheN/m1Gty0KdYYD1yBqWayp0JGJUpwMO9aGacnciEg9aUEy
         g3SQ==
X-Received: by 10.15.64.1 with SMTP id n1mr9405679eex.15.1375530911367;
        Sat, 03 Aug 2013 04:55:11 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id v41sm18898014eep.10.2013.08.03.04.55.10
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 03 Aug 2013 04:55:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231593>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig41446AF781D1821A8755C3C6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/03/2013 01:51 PM, Stefan Beller wrote:
> Suggested changes by Eric Sunshine included.
>=20

The patches still apply on top of origin/jc/parseopt-command-modes



--------------enig41446AF781D1821A8755C3C6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR/O+8AAoJEJQCPTzLflhqpi8QAI5eaQuol/nbpccIiYoRAyBa
kayGMmfEtmWazYN9zaFc9XjUwRGnADJVssmijQVJSe7JkwLdSntGqaBYMEgN6aE5
gIA5hy0/Anv9hWL94ebNOyujjZoFbNCm6fKu78AMFTYXdQrMnI/IGLVOK1Af+XD8
lyNXbPKzX/pO5S0RXzn62UasEAQCfbO+AgP5fX0Tai2qLuG21XcLLyDgDVP0GB48
QZidpuFhTUqOLFqyHHI0nW2MWJ96ea/5D1Ru1mOjH7NE+9nxUi2sLypvT86ZbfTy
RNm9NUADxazQWPNNq+0ZJCzIi2uxg0v/HMCkUtkaATh3kko5YfQiSS5EwNfnhReP
B7RrJB2jSLY/0r2AixpgW9akPxmxfuFnAlO5BCKi6ixwFqfKih8Wji0aCeu4aRCp
22mVNoUjm5KstUSwVBarpjdIAJ5q8ARHrD9/7wwcL6MBA9+D8BfGFet2hws88baZ
aBOM061X59yv910V77giXYQgXKOcZQe/z9vZpVaV53sxbK7E5ri94fo0qlXv7Bju
YkxM4mV+hYFRpw2FBM3BheeqHTxY1wUvp7kOkFW/YRRUXtM2D2yb/1pDRnX01nxs
1wjgueTczJ34w+0b0Le/NNFla4d4gHxEYGfzQwq2LXv4R139iuDFA0ac0mH8Brwk
EiJubDjsVeCdR3WLCjRO
=XUb2
-----END PGP SIGNATURE-----

--------------enig41446AF781D1821A8755C3C6--
