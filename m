From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFH] Asciidoc non-example blocks [was: Re: [RFC PATCH] Documentation: add manpage about workflows]
Date: Fri, 12 Sep 2008 09:26:15 +0200
Message-ID: <200809120926.21607.trast@student.ethz.ch>
References: <1221147525-5589-3-git-send-email-trast@student.ethz.ch> <1221147585-5695-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2822513.PVsaqtLVXo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 09:27:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke34C-0004CC-Mv
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 09:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbYILH00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 03:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbYILH0Z
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 03:26:25 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:29706 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512AbYILH0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 03:26:25 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 12 Sep 2008 09:26:23 +0200
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 12 Sep 2008 09:26:23 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1221147585-5695-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 12 Sep 2008 07:26:23.0868 (UTC) FILETIME=[DC3AEBC0:01C914A8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95689>

--nextPart2822513.PVsaqtLVXo
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thomas Rast wrote:
> +.Merge upwards
> +[caption=3D"Rule: "]
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Always commit your fixes to the oldest supported branch that require
> +them.  Then (periodically) merge the main branches upwards into each
> +other.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Turns out that asciidoc, at least the 8.2.5 on my system, does not
honour the custom caption when converting to manpages.  They become
numbered 'Example' blocks instead.  Is there another way to get a
similar result?

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch



--nextPart2822513.PVsaqtLVXo
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjKGZ0ACgkQqUud07tmzP3a/ACfRqYS5u3qMAyCA9hzeseDF8g9
7LoAn3yebic2CjdSmrz18gAO6/oTu28+
=a34p
-----END PGP SIGNATURE-----

--nextPart2822513.PVsaqtLVXo--
