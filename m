From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Tue, 18 Dec 2007 16:42:11 +0100
Message-ID: <20071218154211.GB12549@alea.gnuu.de>
References: <20071217110322.GH14889@albany.tokkee.org> <506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr> <7vk5nd53lp.fsf@gitster.siamese.dyndns.org> <57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr> <7vfxy04ze7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 23:06:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4kZS-0004xs-1n
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 23:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756823AbXLRWFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 17:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756433AbXLRWFV
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 17:05:21 -0500
Received: from banki.eumelnet.de ([83.246.114.63]:1294 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756162AbXLRWFP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 17:05:15 -0500
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 4540948807D; Tue, 18 Dec 2007 22:42:02 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1J4kAp-0000gI-Rg
	for git@vger.kernel.org; Tue, 18 Dec 2007 22:40:24 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.68)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1J4eaB-0004Hn-VR
	for git@vger.kernel.org; Tue, 18 Dec 2007 16:42:12 +0100
Content-Disposition: inline
In-Reply-To: <7vfxy04ze7.fsf@gitster.siamese.dyndns.org>
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68827>


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Junio C Hamano schrieb am Mon 17. Dec, 16:31 (-0800):
> Benoit Sigoure <tsuna@lrde.epita.fr> writes:
>=20
> >> Benoit Sigoure <tsuna@lrde.epita.fr> writes:
> >>
> >>> ...  The current behavior of git stash is very
> >>> dangerous ...
> > ...
> >> This is a plain FUD, isn't it?  The first Oops should not happen these
> >> days.
>=20
> But the original point by Sebastian hasn't been answered.  He wanted to
> make the command list the stash without arguments.
>=20
> This was discussed already in the early days of stash and there indeed
> was a suggestion to do so (I think I sided with that), but the users did
> not want it.  IIRC, the argument went like: "when I say 'stash', that is
> because I want a quick and immediate way to stash, and I do not want a
> list.  If I do not have to have a quick way, I would create a temporary
> commit on the current branch, or switch to a temporary branch and commit
> there."

When it should go quick why don't use an alias. git stash can print the
list and everyone who wants a quick stash can create an alias for this.

I vote for stash print the list, because I dropped in the pitfall.

Bye, J=C3=B6rg.
--=20
Die beste Tarnung ist die Wahrheit. Die glaubt einem keiner!
                      (Max Frisch: =E2=80=9ABiedermann und die Brandstifter=
=E2=80=98)

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHZ+pTwe0mZwH1VIARAuK1AKCmzCtxCiqwlO95uaSBos5hLRFxCQCgoPqO
1RcELkzeVsYdLvQAyAw6sB0=
=x7vn
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
