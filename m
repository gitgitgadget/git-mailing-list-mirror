From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [OT] Your branch is ahead of the tracked remote branch
	'origin/master' by 50 commits.
Date: Tue, 1 Jul 2008 13:16:01 +0200
Message-ID: <20080701111601.GT4729@genesis.frugalware.org>
References: <20080701091347.GA11817@elte.hu> <7vlk0mne5d.fsf@gitster.siamese.dyndns.org> <20080701100725.GE31309@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tuFXEhzhBeitrIAu"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Tue Jul 01 13:17:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDdr9-0001K7-Q6
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 13:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbYGALQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 07:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbYGALQJ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 07:16:09 -0400
Received: from virgo.iok.hu ([193.202.89.103]:46795 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbYGALQH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 07:16:07 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 44FC91B2516;
	Tue,  1 Jul 2008 13:16:04 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5D80E44668;
	Tue,  1 Jul 2008 12:47:14 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C31AE11901F0; Tue,  1 Jul 2008 13:16:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080701100725.GE31309@elte.hu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87023>


--tuFXEhzhBeitrIAu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 01, 2008 at 12:07:25PM +0200, Ingo Molnar <mingo@elte.hu> wrote:
> !! You have installed git-* commands to new gitexecdir.
> !! Old version git-* commands still remain in bindir.
> !! Mixing two versions of Git will lead to problems.
> !! Please remove old version commands in bindir now.
>=20
> that's an easily overlooked detail.

There is a 10-lines-length note about this in RelNotes, but I think
removing the old version is a task of the package manager. At least till
the git Makefile does not have an 'uninstall' target.

--tuFXEhzhBeitrIAu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhqEfEACgkQe81tAgORUJZ8LwCdEjn0TMSdYuDVAtbsi+dv2krP
CcoAninaTq6xl7SIs51YFXlg/ZfC75WE
=7Ajo
-----END PGP SIGNATURE-----

--tuFXEhzhBeitrIAu--
