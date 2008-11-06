From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: What's cooking in git.git (Nov 2008, #02; Wed, 05)
Date: Thu, 6 Nov 2008 15:29:03 +0100
Message-ID: <20081106142903.GF24201@genesis.frugalware.org>
References: <7v1vxplku2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QoFl77rH4lq6But"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 15:31:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky5tC-0008N9-Cd
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 15:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbYKFO3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 09:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbYKFO3I
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 09:29:08 -0500
Received: from virgo.iok.hu ([193.202.89.103]:47751 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137AbYKFO3G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 09:29:06 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id B1A54580CD;
	Thu,  6 Nov 2008 15:29:03 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 9D8944465E;
	Thu,  6 Nov 2008 15:29:03 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5B759119019E; Thu,  6 Nov 2008 15:29:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v1vxplku2.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100236>


--+QoFl77rH4lq6But
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 05, 2008 at 05:11:33PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> * mv/remote-rename (Mon Nov 3 19:26:18 2008 +0100) 1 commit
>  . Implement git remote rename

I plan to send a second patch on top of this to support migration from
.git/branches and .git/remotes, but probably I can do so only next week
due to lack of time.

--+QoFl77rH4lq6But
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkS/y8ACgkQe81tAgORUJaJvQCeMm3fw8hwxuNq+HPd0k74HAy1
VrgAnjuRf97Lr2NTNb9OglK08ORU1HPL
=kkXp
-----END PGP SIGNATURE-----

--+QoFl77rH4lq6But--
