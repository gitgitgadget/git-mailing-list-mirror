From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: clone branching?
Date: Mon, 11 Aug 2008 21:17:27 +0200
Message-ID: <20080811191727.GS18960@genesis.frugalware.org>
References: <4b6f054f0808111124g58309f64v496ceb250a068985@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WeDu0lr7bteb/II5"
Cc: git@vger.kernel.org
To: Trans <transfire@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 21:18:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KScuG-0008Re-P5
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 21:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbYHKTRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 15:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752970AbYHKTRP
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 15:17:15 -0400
Received: from virgo.iok.hu ([193.202.89.103]:60646 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977AbYHKTRO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 15:17:14 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 8529C1B2530;
	Mon, 11 Aug 2008 21:17:13 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id BD36B4465E;
	Mon, 11 Aug 2008 20:25:19 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8B51E1190002; Mon, 11 Aug 2008 21:17:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4b6f054f0808111124g58309f64v496ceb250a068985@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91982>


--WeDu0lr7bteb/II5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 11, 2008 at 02:24:23PM -0400, Trans <transfire@gmail.com> wrote:
> Can Git be effectively used if clone is used for branching, rather
> then using the internal branch naming?

See git clone -l.

You can also use git clone -s (but it may be dangerous, more info in the
manpage) and git-new-workdir (but that's only in contrib, you may have
issues with it).

--WeDu0lr7bteb/II5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkigkEcACgkQe81tAgORUJZ/ewCeL+jIB0KFJmRu/Gi+pzW1nIGL
AmMAn2gT2Km16YOG8VVkG7eqcmJX4sHg
=qvWh
-----END PGP SIGNATURE-----

--WeDu0lr7bteb/II5--
