From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] gitweb: continue consolidation of URL generation.
Date: Thu, 17 Aug 2006 21:32:51 +0200
Message-ID: <20060817193251.GB11477@admingilde.org>
References: <11557673213372-git-send-email-tali@admingilde.org> <7voduk15sc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 21:33:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDnbt-0003G0-Gn
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 21:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWHQTcy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 15:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWHQTcx
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 15:32:53 -0400
Received: from agent.admingilde.org ([213.95.21.5]:28123 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1751263AbWHQTcw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 15:32:52 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GDnbn-0003gn-3d; Thu, 17 Aug 2006 21:32:51 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7voduk15sc.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25607>


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Aug 16, 2006 at 06:59:15PM -0700, Junio C Hamano wrote:
> This is not about "further use href()".

Right.

I thought that it was needed in order to generate links to the
main project list page.  But as this is only done via $home_link
this hunk is not needed.  I just forgot to remove it again.

Should I send another patch or do you want to remove it yourself?

--=20
Martin Waitz

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE5MRjj/Eaxd/oD7IRAl1TAJ986kHkJaKEstkY+Zw3ZDwgMGN4YgCfanPI
6wE0NEdtxgYF+f20JH7MX5A=
=uEPm
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
