From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Add tests for git format-patch --to and format.to
 config option
Date: Sun, 7 Mar 2010 02:20:53 +0100
Message-ID: <20100307012052.GQ27414@genesis.frugalware.org>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
 <20100306003946.GD27414@genesis.frugalware.org>
 <7vr5nykx55.fsf@alter.siamese.dyndns.org>
 <4B92EDFA.1000602@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WjWU9mUuKzTKEtBb"
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Drake <sdrake@xnet.co.nz>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 02:21:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No5B2-0003hy-Oc
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 02:21:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954Ab0CGBU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 20:20:59 -0500
Received: from virgo.iok.hu ([212.40.97.103]:52136 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752506Ab0CGBU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 20:20:58 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 7A49758084;
	Sun,  7 Mar 2010 02:20:56 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 2C54842F09;
	Sun,  7 Mar 2010 02:20:55 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 0BD5820E0002; Sun,  7 Mar 2010 02:20:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B92EDFA.1000602@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141631>


--WjWU9mUuKzTKEtBb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 06, 2010 at 04:06:18PM -0800, Stephen Boyd <bebarino@gmail.com> wrote:
> The same applies to the fomat.headers and format.cc config options. How
> is this different?

I think having multiple Cc: and custom headers is a regular use case,
while having multiple To: headers is rare.

--WjWU9mUuKzTKEtBb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuS/3QACgkQe81tAgORUJZh3QCfXR4/hxEGKEQjsC++T5cBdVVY
PgQAnRpuWYapbADDE31/LWX0t7UUgJG+
=sS8P
-----END PGP SIGNATURE-----

--WjWU9mUuKzTKEtBb--
