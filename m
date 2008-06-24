From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 24 Jun 2008 18:02:24 +0200
Message-ID: <20080624160224.GA29404@genesis.frugalware.org>
References: <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org> <7v3anb19n7.fsf@gitster.siamese.dyndns.org> <7vwskjazql.fsf@gitster.siamese.dyndns.org> <20080621121429.GI29404@genesis.frugalware.org> <7vwskfclfs.fsf@gitster.siamese.dyndns.org> <9B8F0B10-F48D-475B-BF59-CEE94222B6E8@ai.rug.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kTnqsHSSB/4vva3w"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Tue Jun 24 18:03:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBAzM-0007Tj-CD
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 18:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbYFXQC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 12:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752342AbYFXQC1
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 12:02:27 -0400
Received: from virgo.iok.hu ([193.202.89.103]:54773 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281AbYFXQC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 12:02:26 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A324C1B2548;
	Tue, 24 Jun 2008 18:02:24 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 430174465E;
	Tue, 24 Jun 2008 17:37:27 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 379541770051; Tue, 24 Jun 2008 18:02:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9B8F0B10-F48D-475B-BF59-CEE94222B6E8@ai.rug.nl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86076>


--kTnqsHSSB/4vva3w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2008 at 10:12:28AM +0200, Pieter de Bie <pdebie@ai.rug.nl> =
wrote:
> Vienna:bin pieter$ git --version
> git version 1.5.6.129.g274ea
> Vienna:bin pieter$ git clone localhost:project/bonnenteller
> Initialize bonnenteller/.git
> Initialized empty Git repository in /opt/git/bin/bonnenteller/.git/
> Password:
> bash: git-upload-pack: command not found
> fatal: The remote end hung up unexpectedly
>=20
> I think that is what Miklos meant.

Exactly. Thanks for the good description.

--kTnqsHSSB/4vva3w
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhhGpAACgkQe81tAgORUJbP5gCgnBnPCsdz8PuiRFrlbylFgXm5
NKcAn3kYNDXSU0R98c540+UNMM/KqVfz
=RiZU
-----END PGP SIGNATURE-----

--kTnqsHSSB/4vva3w--
