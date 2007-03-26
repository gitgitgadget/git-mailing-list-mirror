From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] Removed the printf("rm 'file'") from git-rm.
Date: Tue, 27 Mar 2007 00:13:48 +0200
Message-ID: <20070326221347.GI22773@admingilde.org>
References: <11747590062554-git-send-email-tilman@code-monkey.de> <7vodmhc06f.fsf@assigned-by-dhcp.cox.net> <20070325210418.GA29221@code-monkey.de> <Pine.LNX.4.63.0703252335280.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNpeiK4tTqhYOExY"
Cc: Tilman Sauerbeck <tilman@code-monkey.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 27 00:13:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVxRo-0008WK-Ne
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 00:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbXCZWNt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 18:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbXCZWNt
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 18:13:49 -0400
Received: from mail.admingilde.org ([213.95.32.147]:60992 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932700AbXCZWNt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 18:13:49 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HVxRk-0002dj-1p; Tue, 27 Mar 2007 00:13:48 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703252335280.4045@wbgn013.biozentrum.uni-wuerzburg.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43192>


--PNpeiK4tTqhYOExY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, Mar 25, 2007 at 11:36:35PM +0200, Johannes Schindelin wrote:
> Why not do the common thing, and add a "--quiet" option? You can even add=
=20
> a config variable to enable it by default (for git-rm). It's not like=20
> git-rm is performance critical...

But when we have to add --quiet to all sorts of commands that may be
the sign that they really are too chatty.

If I want a short output I don't want to type extra options.
So adding a --verbose for those that really depend on more output
makes more sense, IMHO.  (Even when I don't see any useful information
in the git-rm output, to be honest.)

--=20
Martin Waitz

--PNpeiK4tTqhYOExY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGCEWbj/Eaxd/oD7IRAo+OAJ4jEDtvmMyFGA26stdREpYnCIRq/wCfRv78
Vbadk1PVHzAkT9VrK4YG/mo=
=X85P
-----END PGP SIGNATURE-----

--PNpeiK4tTqhYOExY--
