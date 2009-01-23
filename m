From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] gittutorial: remove misleading note
Date: Fri, 23 Jan 2009 22:17:34 +0100
Message-ID: <20090123211734.GJ21473@genesis.frugalware.org>
References: <1232733749-6120-1-git-send-email-vmiklos@frugalware.org> <7vk58lvoe5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ed2sj0fx90rgoibw"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 22:19:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQTQe-0005jO-3B
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 22:19:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755724AbZAWVRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 16:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755646AbZAWVRh
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 16:17:37 -0500
Received: from virgo.iok.hu ([212.40.97.103]:48012 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755518AbZAWVRg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 16:17:36 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 5CB5A5809A;
	Fri, 23 Jan 2009 22:17:36 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C80594465E;
	Fri, 23 Jan 2009 22:17:34 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id B266E11B87A9; Fri, 23 Jan 2009 22:17:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vk58lvoe5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106917>


--ed2sj0fx90rgoibw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 23, 2009 at 11:00:18AM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> So we have a usability regression here.  Perhaps we need to fix that
> instead?

I thought that's on purpose.

By doing a 'git fetch <url>' I don't say "what" to fetch, just "from
where".

Would it be better to fetch HEAD in that case?

--ed2sj0fx90rgoibw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkl6M+4ACgkQe81tAgORUJa0zgCgmEz1MKBDp5TxcoA+JXuSoHHK
u88AoKf3bOzO0zNZPN+yGCXNZiSxwsUv
=tgi1
-----END PGP SIGNATURE-----

--ed2sj0fx90rgoibw--
