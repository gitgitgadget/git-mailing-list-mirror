From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Documentation/merge-strategies.txt, diff-options: grammar
Date: Tue, 6 Jan 2009 09:44:06 +0100
Message-ID: <200901060944.09435.trast@student.ethz.ch>
References: <1231213956-14929-1-git-send-email-jidanni@jidanni.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1302469.YEDkpq3Jxv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Tue Jan 06 09:45:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK7Yu-0006G0-7e
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 09:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbZAFIn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 03:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbZAFIn4
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 03:43:56 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:16523 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976AbZAFInz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 03:43:55 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 6 Jan 2009 09:43:53 +0100
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 6 Jan 2009 09:43:53 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <1231213956-14929-1-git-send-email-jidanni@jidanni.org>
X-OriginalArrivalTime: 06 Jan 2009 08:43:53.0470 (UTC) FILETIME=[E786E1E0:01C96FDA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104663>

--nextPart1302469.YEDkpq3Jxv
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

jidanni@jidanni.org wrote:
> @@ -11,7 +11,7 @@ resolve::
>  recursive::
>  	This can only resolve two heads using 3-way merge
>  	algorithm.  When there are more than one common
> -	ancestors that can be used for 3-way merge, it creates a
> +	ancestor that can be used for 3-way merge, it creates a
>  	merged tree of the common ancestors and uses that as
>  	the reference tree for the 3-way merge.  This has been
>  	reported to result in fewer merge conflicts without

I'm not a native speaker, but shouldn't this be worded

  When there _is_ more than one common _ancestor_ that ...

instead?

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart1302469.YEDkpq3Jxv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEUEABECAAYFAkljGdkACgkQqUud07tmzP0OXACfdtsXTf6WuJjNsRprPmkpawBb
5WIAljFUSApVtbGp+G+4hv9UGQ9CEZs=
=5q+F
-----END PGP SIGNATURE-----

--nextPart1302469.YEDkpq3Jxv--
