From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] gitweb: use action dispatcher for non-project actions, too.
Date: Thu, 17 Aug 2006 21:49:14 +0200
Message-ID: <20060817194913.GD11477@admingilde.org>
References: <11557673213372-git-send-email-tali@admingilde.org> <11557673212235-git-send-email-tali@admingilde.org> <1155767325181-git-send-email-tali@admingilde.org> <11557673263081-git-send-email-tali@admingilde.org> <11557673262714-git-send-email-tali@admingilde.org> <11557673281583-git-send-email-tali@admingilde.org> <ec1dis$823$3@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 21:49:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDnri-0005vR-IX
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 21:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWHQTtP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 15:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWHQTtP
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 15:49:15 -0400
Received: from agent.admingilde.org ([213.95.21.5]:38363 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1030196AbWHQTtP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 15:49:15 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GDnre-0003oc-1o; Thu, 17 Aug 2006 21:49:14 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ec1dis$823$3@sea.gmane.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25610>


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, Aug 17, 2006 at 11:41:43AM +0200, Jakub Narebski wrote:
> > Project list and OPML generation are now hooked into the list as
> > "/summary" and "/opml".
>=20
> It would be better to use "/list" or "/projects", although empty or undef=
 or
> "/" action would work as well.
>=20
> Having both "/summary" (for projects list) and "summary" (for project
> summary) is bad, bad idea.

well, it was a little trick so that only one default action "summary"
is needed.  I have no strong feelings about it so any other name is
good for me, too.

--=20
Martin Waitz

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE5Mg5j/Eaxd/oD7IRAullAJ96sgIZ8mCesALWNtBhrvEjBQp0lwCeIVzD
+zcBO2eEyObjnwvWy5We1kE=
=LVZO
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--
