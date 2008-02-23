From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: post-receive-email: about diff
Date: Sat, 23 Feb 2008 01:43:08 +0100
Message-ID: <20080223004308.GX31441@genesis.frugalware.org>
References: <20080222191402.5f546aed@wizard.volgograd.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lHuqAdgBYNjQz/wy"
Cc: git@vger.kernel.org
To: Denis Shaposhnikov <dsh@wizard.volgograd.ru>
X-From: git-owner@vger.kernel.org Sat Feb 23 01:44:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSiUy-0002lO-2K
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 01:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbYBWAnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 19:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936236AbYBWAnc
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 19:43:32 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:56186 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937184AbYBWAn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 19:43:29 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1JSiTz-0007SO-0A
	from <vmiklos@frugalware.org>; Sat, 23 Feb 2008 01:43:27 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 59D2311901A7; Sat, 23 Feb 2008 01:43:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080222191402.5f546aed@wizard.volgograd.ru>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.1 required=5.9 tests=BAYES_05 autolearn=no SpamAssassin version=3.2.3
	-1.1 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0168]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74771>


--lHuqAdgBYNjQz/wy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 22, 2008 at 07:14:02PM +0300, Denis Shaposhnikov <dsh@wizard.volgograd.ru> wrote:
> Does somebody has modifications for contrib/hooks/post-receive-email to
> send a diff together with a log message in a email?

maybe this is something for you:

http://git.frugalware.org/gitweb/gitweb.cgi?p=git-hooks.git;a=tree;f=sendmail;hb=HEAD

it sends one email / commit, including the full diff.

- VMiklos

--lHuqAdgBYNjQz/wy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD4DBQFHv2wce81tAgORUJYRAvWmAJ9Vca/285Hiy1eF9Tcb1pNJ4FteDgCY5cKc
VruYCRV22OwTN86KHCr/nA==
=hcsW
-----END PGP SIGNATURE-----

--lHuqAdgBYNjQz/wy--
