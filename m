From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: commit 'git-send-email: add support for TLS via Net::SMTP::SSL' causes warnings
Date: Thu, 26 Jun 2008 22:48:00 +0200
Message-ID: <200806262248.02866.trast@student.ethz.ch>
References: <DF091369-1771-4405-8705-BDBC59C7E48A@sb.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart41898695.kdeBq8Vj8p";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <Kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 22:48:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KByOb-0002eO-Rk
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 22:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754252AbYFZUrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 16:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754221AbYFZUrt
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 16:47:49 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:8312 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823AbYFZUrs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 16:47:48 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 26 Jun 2008 22:47:46 +0200
Received: from [192.168.0.2] ([84.75.156.10]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 26 Jun 2008 22:47:45 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <DF091369-1771-4405-8705-BDBC59C7E48A@sb.org>
X-OriginalArrivalTime: 26 Jun 2008 20:47:46.0033 (UTC) FILETIME=[E3368E10:01C8D7CD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86485>

--nextPart41898695.kdeBq8Vj8p
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Kevin Ballard wrote:
> Your recent commit to next (f6bebd1) causes warnings when no form of =20
> encryption is specified. Specifically, lines 755 and 765 reference =20
> $smtp_encryption, but when no encryption is given at all this variable =20
> is undefined.

Sorry for the oversight on my part, and thanks for the fix! :-)

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch


--nextPart41898695.kdeBq8Vj8p
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhkAIIACgkQqUud07tmzP0c+gCfWWH2wedr7CKHGSXTsbKLNvsN
ZsoAn0KiRcA1jExicep6f/vnyked6STs
=nj2F
-----END PGP SIGNATURE-----

--nextPart41898695.kdeBq8Vj8p--
