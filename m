From: Nick Douma <n.douma@nekoconeko.nl>
Subject: Re: How can I append authentication with "git push" ?
Date: Thu, 12 Jul 2012 17:30:59 +0200
Message-ID: <4FFEEDB3.5060003@nekoconeko.nl>
References: <20120712134844.2d1c4378@shiva.selfip.org> <CACnwZYfbbZJV--aaOVH+af+Hxibg7XWvb909kZYWgKXVHexfDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD3D81238781CC49C0E0BE75D"
Cc: "J. Bakshi" <joydeep.bakshi@infoservices.in>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 17:39:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpLUe-0004mz-LF
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 17:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934046Ab2GLPjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 11:39:47 -0400
Received: from genome.nekoconeko.nl ([93.94.224.72]:37856 "EHLO
	genome.nekoconeko.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932627Ab2GLPjq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 11:39:46 -0400
X-Greylist: delayed 518 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jul 2012 11:39:46 EDT
Received: from localhost (localhost [127.0.0.1])
	by genome.nekoconeko.nl (Postfix) with ESMTP id 8A8911FCAF;
	Thu, 12 Jul 2012 17:33:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at genome.nekoconeko.nl
Received: from genome.nekoconeko.nl ([127.0.0.1])
	by localhost (genome.nekoconeko.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a31iBpObOVJv; Thu, 12 Jul 2012 17:33:33 +0200 (CEST)
Received: from [IPv6:2001:838:300:41e::2] (cl-1055.ams-01.nl.sixxs.net [IPv6:2001:838:300:41e::2])
	by genome.nekoconeko.nl (Postfix) with ESMTPSA id 487681FC7A;
	Thu, 12 Jul 2012 17:33:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nekoconeko.nl;
	s=genome; t=1342107213;
	bh=GuFkNz4gEyACi1c3efo/NqY0Ljd47kzva8mPFwC8Nxg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=iVe78glQVB+64pyp0sP4Z6hqX7ZoXjKce8//K7+N9rkoYFhOQm1gtIpjf4ERHNUuh
	 LM9Zvi0UMwNld8fJcW9H0Durijql29RpSjGJHxI0Kg+VMPzxbMltSGuRcPOt2dj5uD
	 2b/lcbX+uZG3fTVymmHc0zg+as901AaDnqnFkzD8=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <CACnwZYfbbZJV--aaOVH+af+Hxibg7XWvb909kZYWgKXVHexfDw@mail.gmail.com>
X-Enigmail-Version: 1.4.2
OpenPGP: id=AB001628;
	url=http://nekoconeko.nl/pub_0xAB001628.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201362>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD3D81238781CC49C0E0BE75D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 12-07-12 17:04, Thiago Farina wrote:
> On Thu, Jul 12, 2012 at 5:18 AM, J. Bakshi
> <joydeep.bakshi@infoservices.in> wrote:
>> Or any repo wise configuration file where I can save the info, so that=

>> it doesn't ask the credential before every push ?
>>
> I'd like to know how to do that too.
>=20
> It's a pain to have to type username and password every time I need to
> push to github. (Linux here btw).

If you're specifically looking at GitHub and HTTP auth, take a look at
the hub tool:

https://github.com/defunkt/hub

Kind regards,

Nick Douma


--------------enigD3D81238781CC49C0E0BE75D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/+7bYACgkQkPq5zKsAFiiYkgCfWHsC2XPPsTjRka+HpbyUIynV
xEMAn2HFQgt82oBk9KZo2eGdrKBa+/Tw
=EYSD
-----END PGP SIGNATURE-----

--------------enigD3D81238781CC49C0E0BE75D--
