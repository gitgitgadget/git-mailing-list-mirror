From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Weird growth in packfile during initial push
Date: Thu, 30 Apr 2009 23:17:57 -0700
Message-ID: <robbat2.20090501T061700.886743377Z@orbis-terrarum.net>
References: <20090415182754.GF23644@curie-int> <alpine.LFD.2.00.0904151443030.6741@xanadu.home> <7vy6tj109a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Cc: Nicolas Pitre <nico@cam.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 01 08:18:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzm56-00054P-7r
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 08:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbZEAGSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 02:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbZEAGSH
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 02:18:07 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:48631 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751675AbZEAGSG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 02:18:06 -0400
Received: (qmail 29273 invoked from network); 1 May 2009 06:18:00 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Fri, 01 May 2009 06:18:00 +0000
Received: (qmail 21863 invoked by uid 10000); 30 Apr 2009 23:17:57 -0700
Content-Disposition: inline
In-Reply-To: <7vy6tj109a.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118058>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2009 at 04:57:37PM -0700, Junio C Hamano wrote:
> > And the code matches this theory as well.  Can you try this patch if yo=
u=20
> > have a chance?
> Is there any progress on this?
Sorry, I was just away for 2 weeks, only got back late yesterday. I'll
try to get to it in the next few days unless Nicolas beats me to it.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAkn6lBUACgkQPpIsIjIzwiznnQCghSZTZHmuzAntzc7iHwinuvYv
Y2EAn0GhBxzAHM3oVQJtPqGfjzqeqt7h
=cNzw
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
