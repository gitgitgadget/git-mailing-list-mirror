From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] doc/git-send-email: mention sendemail.cc config variable
Date: Fri, 2 Jan 2009 01:43:40 +0100
Message-ID: <200901020143.43275.trast@student.ethz.ch>
References: <200812290037.25890.markus.heidelberg@web.de> <200812291400.08924.trast@student.ethz.ch> <200901020040.41399.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1407187.oU5HN1FMZS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Fri Jan 02 01:45:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIY9q-0000HT-1P
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 01:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669AbZABAnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 19:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbZABAnb
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 19:43:31 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:45154 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbZABAna (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 19:43:30 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 2 Jan 2009 01:43:28 +0100
Received: from [192.168.0.3] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 2 Jan 2009 01:43:27 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <200901020040.41399.markus.heidelberg@web.de>
X-OriginalArrivalTime: 02 Jan 2009 00:43:27.0784 (UTC) FILETIME=[206D4280:01C96C73]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104350>

--nextPart1407187.oU5HN1FMZS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Markus Heidelberg wrote:
> I just tested it with --dry-run: the command line options for all three
> header lines (to cc bcc) override the corresponding config settings. So
> the formulation is correct: the settings are only default values.

Indeed, you're right.  Apologies for the false alarm.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart1407187.oU5HN1FMZS
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkldYz8ACgkQqUud07tmzP1Q/wCaA4LLD7ja1h0n/+IM8ceWE+Tu
mpMAn29j9NYzHX3utv8CIwMPiHIfz5gk
=oB0y
-----END PGP SIGNATURE-----

--nextPart1407187.oU5HN1FMZS--
