From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH v3] parse-opt: migrate builtin-ls-files.
Date: Sat, 14 Feb 2009 13:16:31 +0100
Message-ID: <20090214121631.GG4371@genesis.frugalware.org>
References: <20090107144640.GD831@artemis.corp> <1231376145-32331-1-git-send-email-vmiklos@frugalware.org> <20090115001410.GE30710@genesis.frugalware.org> <7vljtdw961.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 13:21:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYJWY-0003pd-CO
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 13:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbZBNMQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 07:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbZBNMQf
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 07:16:35 -0500
Received: from virgo.iok.hu ([212.40.97.103]:32881 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389AbZBNMQe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 07:16:34 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 5185D580DF;
	Sat, 14 Feb 2009 13:16:33 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id CBD86446A6;
	Sat, 14 Feb 2009 13:16:31 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id AB0D511B877C; Sat, 14 Feb 2009 13:16:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vljtdw961.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109867>


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2009 at 07:16:38PM -0800, Junio C Hamano <gitster@pobox.com=
> wrote:
> Miklos Vajna <vmiklos@frugalware.org> writes:
>=20
> > Was this dropped on the floor by accident?
>=20
> I am not fundamentally opposed to the parseopt conversion, but I was
> somewhat discouraged from taking another one, after we got burned by the
> one that converted git-apply without much visible gain but with a new bug.
>=20
> Because ls-files is a plumbing, it has somewhat lower priority for user
> friendliness than any other patches currently in-flight on the list; hence
> it has been backburnered.  It still is kept in my Inbox.

I'm just asking again as I see the parseopt patch for builtin-config now
on the list.

Should I just resend this patch after v1.6.2?

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmWth8ACgkQe81tAgORUJYj8ACeLtjauJHmGrCEg/9KM1kFywVb
t4YAn2ED56fmC97+KltSsgQEMtSGWObX
=z+YG
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--
