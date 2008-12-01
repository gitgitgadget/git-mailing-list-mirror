From: Todd Zullinger <tmz@pobox.com>
Subject: Re: SPEC files for Git
Date: Mon, 1 Dec 2008 11:42:46 -0500
Message-ID: <20081201164246.GY20204@inocybe.teonanacatl.org>
References: <4933FFC6.8080306@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="pBxr27OvcVUkmud5"
Cc: git@vger.kernel.org
To: Nicolas Morey-Chaisemartin <devel@morey-chaisemartin.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 17:45:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7BtL-0007gB-9f
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 17:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325AbYLAQnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 11:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753925AbYLAQnh
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 11:43:37 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54435 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313AbYLAQng (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 11:43:36 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C75C183F8C;
	Mon,  1 Dec 2008 11:43:33 -0500 (EST)
Received: from inocybe.teonanacatl.org (unknown [69.248.23.23]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4100983F7B; Mon,
  1 Dec 2008 11:42:48 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4933FFC6.8080306@morey-chaisemartin.com>
X-Listening-To: Lynyrd Skynyrd - The Last Rebel
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Pobox-Relay-ID: 315506B2-BFC7-11DD-88D3-465CC92D7133-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102061>


--pBxr27OvcVUkmud5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Nicolas Morey-Chaisemartin wrote:
> I'm trying to recompile gitweb1.6.0.4-1 for RHEL5, but I'm missing
> the spec file.  I've checked the git SRP. It generates a lot of
> things but no RPM for gitweb.
>=20
> Is there any place with an official spec file? Or has anyone made
> one which he could share?

Far from official, but here's what I've been using, based on the
Fedora and EPEL packages: http://tmz.fedorapeople.org/tmp/git/el5/

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Many people are secretly interested in life.


--pBxr27OvcVUkmud5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBAgAtBQJJNBQGJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjgIgIALeBKoq4y6z1IjB9owk+4n+yMGpkGHajUYEt
c8Bl6CPoiSLSRPNJhXRZp4rJLwsHEKrolqsu1Cq9KsbWJoHhqn9tyHPCIyDi7mQE
57tO8oHyH7mAgRpQvUo7Ld051C0+1tznJ/kagyBE5LpBvSU+c07IV7cXmQ0/sfHa
+V0+ZrLCDhHx0ay2uA2I/doVQ0oFyRNl1KaqEIHCWOklhjFMdRMl8lzMk2xRMsWD
PlLVnSJEhElBQDXGtpFGp556acFbFQsPqdEyZMlEmLL5GuqJ+L5Zsu5H+ZhbNNhn
lgXvHYy/5KS6CJkpldQWVdf7WT+bnIINsIWi/SIJtOrvTGBQGdg=
=Imbb
-----END PGP SIGNATURE-----

--pBxr27OvcVUkmud5--
