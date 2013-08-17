From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: so, for the really out of date...
Date: Sat, 17 Aug 2013 17:50:46 +0200
Message-ID: <520F9BD6.2060204@googlemail.com>
References: <13AF7B3E-B6F7-4E37-89B9-4542BC4BED8D@mail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC3817BDDAF6101ECF2C626AD"
Cc: git@vger.kernel.org
To: Jules <jules_gilbert@mail.com>
X-From: git-owner@vger.kernel.org Sat Aug 17 17:51:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAimI-0005N5-UK
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 17:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726Ab3HQPuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Aug 2013 11:50:55 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:46762 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630Ab3HQPuy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Aug 2013 11:50:54 -0400
Received: by mail-ee0-f43.google.com with SMTP id e52so1410909eek.30
        for <git@vger.kernel.org>; Sat, 17 Aug 2013 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=pN0gKOZH0eGIcEnqh6etRbxeCHTdgYo1gWaErgJnh0I=;
        b=wqR0BZ98OhkhoIuylq+yo9U+Ti8TiWdd6kWbns7bbmSeKzJJ6uzqB/RYM1lrzymHzS
         m9Ruz+8ssuG8IvreQ16EkYsXlDjyeXrIJy75wAP52EPPtNTDqVegsiYpWn41GXb58R0H
         5YEhK81fPS7Rb2R81fuHVPOtXGPpPzCWsDz/D5luO3geSQjoivLHqkp8hVhavZ4LlwBk
         PN0NJDEoZG9J8O3GRCpULYmBkxtFEb5wqgebQy6NDRdC2/ymhPaOo83t0B9TZgm83o/S
         6Kid3cwh6uKXSbGIOqH7IVqJ1KmABI4APf//84sHYcaAj23DsFbLaV1KEhShtZjbPIWZ
         ATeA==
X-Received: by 10.15.83.2 with SMTP id b2mr6600311eez.28.1376754652879;
        Sat, 17 Aug 2013 08:50:52 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id h52sm4318977eez.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 17 Aug 2013 08:50:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <13AF7B3E-B6F7-4E37-89B9-4542BC4BED8D@mail.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232460>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC3817BDDAF6101ECF2C626AD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/17/2013 05:10 PM, Jules wrote:
> I am running a Mac, v 10.6.8
>=20
> It's some animal, I really don't follow this, like a lion (I think.)
>=20
> Now, this mac is the only machine I let touch the internet.  So obvious=
ly I have to make git work here.  I have gnu gcc installed.  Is their sou=
rce code I can compile (see, I'm not only paranoid but old. not a great c=
ombination, I am learning...)
>=20

Jules,

you'll find downloads for git
at http://git-scm.com/downloads
There you can download prebuild packages.

However if you want to go by the source, and
have not git already... (git is maintained using git,
so if you don't have git, getting git, well before it gets
complicated):
At https://github.com/gitster/git you'll find a button
at the right lower side "Download as zip file", which
contains the sources.

These should be compilable using gcc. Make sure
to read the INSTALL file, it contains hints on which
other software apart from gcc is needed to setup git using
the sourcecode.

Stefan



--------------enigC3817BDDAF6101ECF2C626AD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSD5vbAAoJEJQCPTzLflhqCZIQAOBse1b0e9VC2gTedhMt24uR
ceEcNFWNL3+d0rOVWpY9go34Erg9+1/76eBFAF9nitn2hda1GUMXZXG5MoADZcYw
YCzLbZCbhMFyoIovRewoXyUoOM15PNnHkUEcGQuK3HNADp/QeMCDGBH91oN2izLc
EMM49Kq1+V6FjrCx9BjSz6kTo+lCUSxe0XV/ivsj1kgCDzBZIT4Le5hi6i3BkNXl
0VwqhLFO9PbrTFjuPWCI4AahPHJnEsmFWDpg35eoBy2prJaO4c9Yol5Q8O+Ldcax
YWllmHY72UjVHkb/l5pb/pmKwOuguXqnHm8zRDKYeb6zZIUKoZtoHg7QeQuIlxAx
LjaD2IXv+F7mcwemUCWEaDpRoiNnJw/qzwsoxT7M0U17cywVm9jhLJr/vlIFxh5w
XWAc3eurxRdPmrS8ESEsjjL3mPRiN0iEqIwd6NOv9zpWrlqsegdvqkt1dQVvN/3a
8495jv74vlCzbeukVYHuK90i0FFknZ2f94uoalOd51LT38KS2KgpFIXsHS50c3FP
r6wdxlRm2B8/zyGAXNA2isEVnvzVJ9585gMTkLLdhEtWxH2cXLOnkpp7OXanwqOs
CcOnVvilxKKRbE6K6LswI0NzpFPuezbxCCV5v1x6ls9M4ZUg71NYcGU8NF0auVjT
/DWYhGE07irtIKugGAWO
=vzIr
-----END PGP SIGNATURE-----

--------------enigC3817BDDAF6101ECF2C626AD--
