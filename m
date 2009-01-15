From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH v3] parse-opt: migrate builtin-ls-files.
Date: Thu, 15 Jan 2009 04:48:34 +0100
Message-ID: <20090115034834.GH30710@genesis.frugalware.org>
References: <20090107144640.GD831@artemis.corp> <1231376145-32331-1-git-send-email-vmiklos@frugalware.org> <20090115001410.GE30710@genesis.frugalware.org> <7vljtdw961.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5Dr6Wqe9hdyl7LAI"
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 04:50:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNJF2-0006Su-NV
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 04:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672AbZAODsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 22:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754343AbZAODsh
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 22:48:37 -0500
Received: from virgo.iok.hu ([212.40.97.103]:45517 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753927AbZAODsg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 22:48:36 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id C970B5817C;
	Thu, 15 Jan 2009 04:48:36 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 1C7754465E;
	Thu, 15 Jan 2009 04:48:35 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 4858311B8630; Thu, 15 Jan 2009 04:48:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vljtdw961.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105763>


--5Dr6Wqe9hdyl7LAI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2009 at 07:16:38PM -0800, Junio C Hamano <gitster@pobox.com=
> wrote:
> I am not fundamentally opposed to the parseopt conversion, but I was
> somewhat discouraged from taking another one, after we got burned by the
> one that converted git-apply without much visible gain but with a new bug.
>=20
> Because ls-files is a plumbing, it has somewhat lower priority for user
> friendliness than any other patches currently in-flight on the list; hence
> it has been backburnered.  It still is kept in my Inbox.

Makes sense, thanks for the answer.

--5Dr6Wqe9hdyl7LAI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklushIACgkQe81tAgORUJbOSgCfV+9PPMv7Q8uKvMeCpxw9zATu
+T4An2EQ2Dmbp6eFlqZJMf83TBT3C043
=rvgJ
-----END PGP SIGNATURE-----

--5Dr6Wqe9hdyl7LAI--
