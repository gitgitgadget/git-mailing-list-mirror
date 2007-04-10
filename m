From: "Robin H. Johnson" <robbat2@orbis-terrarum.net>
Subject: Re: Feature request - Subtree checkouts
Date: Tue, 10 Apr 2007 15:04:38 -0700
Message-ID: <20070410220438.GD18541@curie-int.orbis-terrarum.net>
References: <20070410074444.GA18541@curie-int.orbis-terrarum.net> <20070410132011.GH5436@spearce.org> <7vslb8ug7y.fsf@assigned-by-dhcp.cox.net> <20070410211040.GC18541@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 03:45:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbOTD-0002oJ-4J
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 00:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbXDJWEy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 18:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753954AbXDJWEx
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 18:04:53 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:44234 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753952AbXDJWEj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 18:04:39 -0400
Received: (qmail 9916 invoked from network); 10 Apr 2007 22:04:38 -0000
Received: from Unknown (HELO orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Tue, 10 Apr 2007 22:04:38 +0000
Received: (qmail 23369 invoked by uid 10000); 10 Apr 2007 15:04:38 -0700
Content-Disposition: inline
In-Reply-To: <20070410211040.GC18541@curie-int.orbis-terrarum.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44160>


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2007 at 02:10:41PM -0700, Robin H. Johnson wrote:
> The only weirdness I saw in that, is that the envelope sender did not
> appear to be set correct from git-send-email. Give me a moment to
> explore down that path.
Ok, see my patch series for envelope sender, that is the source of the
problem.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@orbis-terrarum.net
Home Page  : http://www.orbis-terrarum.net/?l=3Dpeople.robbat2
ICQ#       : 30269588 or 41961639
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGHAn2PpIsIjIzwiwRAssmAJ4sWOf9Amfa+3ChyPZWuIwG5SPd9gCffLRV
qxsoDrgfiVsPe8IiKJGsjI8=
=Qga4
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--
