From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Teach git diff about Objective-C syntax
Date: Wed, 17 Sep 2008 17:55:05 +0200
Message-ID: <20080917155505.GH4829@genesis.frugalware.org>
References: <57518fd10809170526i5c1e7dadgc38bb00e8073ba55@mail.gmail.com> <1221658141-75698-1-git-send-email-jon.delStrother@bestbefore.tv> <48D11C3C.5070707@op5.se> <57518fd10809170831x6d84aeb0m9b0b2c4095a1de70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l4+8epuGRJXZ7Zpo"
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 17:56:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfzO8-0005cU-9p
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 17:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbYIQPzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 11:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752926AbYIQPzL
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 11:55:11 -0400
Received: from virgo.iok.hu ([193.202.89.103]:51802 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbYIQPzK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 11:55:10 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 3F0B91B2507;
	Wed, 17 Sep 2008 17:55:08 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id CF5A14465E;
	Wed, 17 Sep 2008 17:55:05 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id B62BC11901A1; Wed, 17 Sep 2008 17:55:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <57518fd10809170831x6d84aeb0m9b0b2c4095a1de70@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96122>


--l4+8epuGRJXZ7Zpo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 17, 2008 at 04:31:17PM +0100, Jonathan del Strother <maillist@steelskies.com> wrote:
> I was changing it to match the style in the existing java pattern (and
> my objc pattern).  You think the java one should be changed to match
> the pascal one, then?

The point is that it's unrelated, so you should not change that part in
the same patch. Send a separate patch if you want to do something
unrelated to Objective-C.

--l4+8epuGRJXZ7Zpo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjRKFkACgkQe81tAgORUJZBdwCfeFhkkKBGUAGjCZa49lLfyrWv
7TAAn1hzmmuxIy8+sE1hCg0WcFnAV2NO
=PFIG
-----END PGP SIGNATURE-----

--l4+8epuGRJXZ7Zpo--
