From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [ANNOUNCE] Git homepage change
Date: Tue, 6 Jan 2009 03:43:08 +0100
Message-ID: <20090106024308.GB21154@genesis.frugalware.org>
References: <d411cc4a0812151007n1be9ce95h92c8c11592ea5f9d@mail.gmail.com> <20081216114138.GM12856@machine.or.cz> <d411cc4a0901011040h4ab97aag20de54a6e138a4ec@mail.gmail.com> <20090105164001.GA12275@machine.or.cz> <20090105194011.GB25104@glandium.org> <20090105212716.GJ6595@eratosthenes.cryptobackpack.org> <d411cc4a0901051749p2ef880bub45bba1c0d41bfc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sEhs5GQW+P4Mb8ab"
Cc: David Bryson <david@statichacks.org>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 03:44:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK1vp-0003IO-Ci
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 03:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbZAFCnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 21:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752895AbZAFCnM
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 21:43:12 -0500
Received: from virgo.iok.hu ([212.40.97.103]:37732 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752637AbZAFCnL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 21:43:11 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id C5B3A580BA;
	Tue,  6 Jan 2009 03:43:10 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 290EA4465E;
	Tue,  6 Jan 2009 03:43:09 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id D7E8511B8630; Tue,  6 Jan 2009 03:43:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <d411cc4a0901051749p2ef880bub45bba1c0d41bfc7@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104621>


--sEhs5GQW+P4Mb8ab
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 05, 2009 at 05:49:01PM -0800, Scott Chacon <schacon@gmail.com> wrote:
> Also, Miklos : your patch changes the format of the output and doesn't
> speed things up or anything, so I'm just sticking with the current
> script for now (unless I'm missing something).

I think the patch just makes things simpler (why not using -s if you
then later use grep to drop what -s would hide?), and Adeodato's patch
updates the ruby part as well. But of course it's up to you. ;-)

--sEhs5GQW+P4Mb8ab
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklixTwACgkQe81tAgORUJYVagCfRL3AT3FgUe+aW7zbTKLN9MEl
W2gAnAstG1OZy7iJEn+Tlkh9uqHZQob1
=syuD
-----END PGP SIGNATURE-----

--sEhs5GQW+P4Mb8ab--
