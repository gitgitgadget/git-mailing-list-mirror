From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 22:15:21 +0100
Message-ID: <60891A14-1D6E-4114-ACEF-4C981D326CFA@lrde.epita.fr>
References: <1195477504.8093.15.camel@localhost> <8c5c35580711190845s71a4880ek4ab28170d277e0e6@mail.gmail.com> <E983072E-E9FD-499E-A418-B630A275C4F3@lrde.epita.fr> <8c5c35580711190904v5975e81k3d515dc44fee9c21@mail.gmail.com> <25CF3422-A236-46CE-B243-3F01117B7743@lrde.epita.fr> <vpqtznirtlk.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-15-303873049"
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>,
	"Jonas Juselius" <jonas.juselius@chem.uit.no>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Nov 19 22:16:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuDyK-0007dS-V8
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 22:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbXKSVPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 16:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbXKSVPl
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 16:15:41 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:50365 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbXKSVPl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 16:15:41 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IuDxx-0003pB-Nj; Mon, 19 Nov 2007 22:15:37 +0100
In-Reply-To: <vpqtznirtlk.fsf@bauges.imag.fr>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65502>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-15-303873049
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 19, 2007, at 7:13 PM, Matthieu Moy wrote:

> Benoit Sigoure <tsuna@lrde.epita.fr> writes:
>
>> Did you only read the man?  It doesn't explain how to use the reflog
>> or I must have a very hard time understanding it.  I don't know where
>> the HEAD@{N} syntax is documented, but surely not in man git-reflog.
>
> http://www.kernel.org/pub/software/scm/git/docs/git-rev-parse.html
>
> I'll post a patch adding a link to that in the reflog man page.

No please stop adding links from on man page to another.  If you read  
man git-reflog, you surely want to learn the HEAD@{N} syntax and see  
practical uses cases.  One of the complaints against Git (which also  
came up in the Git Users' Survey) is that man pages are harder to use  
because they often refer to each other and they tend to list their  
numerous arguments out of order.  Many arguments are clearly plumbing  
and should be mentioned in a different section (I guess it would be  
better to list the most useful arguments in alphabetical order first  
and then list the remaining arguments in another section, still in  
alphabetical order).

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-15-303873049
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHQfzpwwE67wC8PUkRAtoGAKCpDh2kbgxdkcTGNvQtZ79ohePHnQCgjw/b
19c2ETOuteqErwx5mRu4Jtk=
=pxVT
-----END PGP SIGNATURE-----

--Apple-Mail-15-303873049--
