From: "R. Tyler Ballance" <tyler@monkeypox.org>
Subject: Re: [PATCH v2] Correct references to /usr/bin/python which does
 not exist on FreeBSD
Date: Sun, 21 Mar 2010 16:00:06 -0700
Message-ID: <20100321230006.GC32016@kiwi.sharlinx.com>
References: <20100321190145.GA32578@kiwi.sharlinx.com>
 <7veijdl6kp.fsf@alter.siamese.dyndns.org>
 <20100321212335.GB32016@kiwi.sharlinx.com>
 <7veijdfhmm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 00:00:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtU88-0006rn-Sq
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 00:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476Ab0CUXAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 19:00:20 -0400
Received: from mail.geekisp.com ([216.168.135.169]:17881 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751989Ab0CUXAT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 19:00:19 -0400
Received: (qmail 20649 invoked by uid 1003); 21 Mar 2010 23:00:14 -0000
Received: from localhost (HELO kiwi.sharlinx.com) (tyler@monkeypox.org@127.0.0.1)
  by mail.geekisp.com with SMTP; 21 Mar 2010 23:00:13 -0000
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7veijdfhmm.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142870>


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Sun, 21 Mar 2010, Junio C Hamano wrote:

> "R. Tyler Ballance" <tyler@monkeypox.org> writes:
>=20
> >> I would have expected that the patch would look more like this:
> >> ...
> >> What am I missing?
> >
> > No, that looks right, I didn't notice the specialized section towards t=
he
> > bottom for FreeBSD or the others for that matter.
>=20
> Thanks.  I usually use a "make" wrapper to handle platform particulars
> like setting PYTHON_PATH automatically outside of the build system we
> ship, and never noticed this.
>=20
> I'll just commit my version with a forged sign-off from you ;-)

I find these terms acceptable :)


Cheers,
-R. Tyler Ballance
--------------------------------------
 Jabber: rtyler@jabber.org
 GitHub: http://github.com/rtyler
Twitter: http://twitter.com/agentdero
   Blog: http://unethicalblogger.com


--bAmEntskrkuBymla
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkumpPYACgkQFCbH3D9R4W9OVACgmyZuNjtTcz7urGDMrsTWHvwR
FkMAniZ+ExKJGNgThcA+q+Wbel4He+qU
=Zoh4
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
