From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Add a commit.signoff configuration variable to always use --signoff
Date: Sat, 27 Dec 2008 12:04:11 +0100
Message-ID: <200812271204.15268.trast@student.ethz.ch>
References: <7v63l6f1mc.fsf@gitster.siamese.dyndns.org> <1230368596-6865-1-git-send-email-dato@net.com.org.es>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart26181911.o4OrD8YNoV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Adeodato =?utf-8?q?Sim=C3=B3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Sat Dec 27 12:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGWzT-0004fd-30
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 12:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194AbYL0LEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 06:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754094AbYL0LEF
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 06:04:05 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:24806 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbYL0LEE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 06:04:04 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 27 Dec 2008 12:04:02 +0100
Received: from [192.168.0.3] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 27 Dec 2008 12:04:01 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <1230368596-6865-1-git-send-email-dato@net.com.org.es>
X-OriginalArrivalTime: 27 Dec 2008 11:04:01.0904 (UTC) FILETIME=[D3369700:01C96812]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103994>

--nextPart26181911.o4OrD8YNoV
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Adeodato Sim=C3=B3 wrote:
> +commit.signoff::
> +	If set, 'git commit' will behave as if '-s' option was given.
> +	Please use this option with care: by enabling it, you're stating
> +	that all your commits will invariably meet the S-o-b
> +	requirements for any project you send patches to. It's probably
> +	best to only use it from your private repositories' .git/config
> +	file, and only for projects who require a S-o-b as proof of
                           ^^^^^^^^^^^^

"projects which ..." or "projects that ...".  "Who" can only stand for
people, not objects.

> +	provenance of the patch, and not of its correctness or quality.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch






--nextPart26181911.o4OrD8YNoV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklWC68ACgkQqUud07tmzP0TAACffc9vK/6g3G3vt/MUV8aEd7JR
gpUAoJEDcPYNryhq9Qt970Ve0EHDc58w
=cZs7
-----END PGP SIGNATURE-----

--nextPart26181911.o4OrD8YNoV--
