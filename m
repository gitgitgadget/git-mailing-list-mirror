From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: unclear description of git-rm on kernel.org
Date: Sun, 4 Jan 2009 23:35:22 +0100
Message-ID: <20090104223522.GH21154@genesis.frugalware.org>
References: <62a60dd90901041410j283866e5ja39c3bda447fed36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oQzL12nKbmSHS3MD"
Cc: git@vger.kernel.org
To: alec resnick <alec@sproutward.org>
X-From: git-owner@vger.kernel.org Sun Jan 04 23:36:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJbaR-0005vf-Cj
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 23:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbZADWf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 17:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbZADWf0
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 17:35:26 -0500
Received: from virgo.iok.hu ([212.40.97.103]:47884 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbZADWfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 17:35:25 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 82BCE580CE;
	Sun,  4 Jan 2009 23:35:24 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 04C4C4465E;
	Sun,  4 Jan 2009 23:35:22 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id CA86E11B8630; Sun,  4 Jan 2009 23:35:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <62a60dd90901041410j283866e5ja39c3bda447fed36@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104547>


--oQzL12nKbmSHS3MD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 04, 2009 at 05:10:11PM -0500, alec resnick <alec@sproutward.org> wrote:
> I was trying to remove a number of files from a git repo I had.  I
> read http://kernel.org/pub/software/scm/git/docs/v1.4.4.4/git-rm.html

Ugh, why are you reading that ancient version?

I would try:

http://www.kernel.org/pub/software/scm/git/docs/git-rm.html

> I'd be happy to make the changes to the webpage; I don't know how to
> do that or if it's appropriate.

They are generated from asciidoc files from the Documentation/ dir, but
documentation fixes are welcome against 1.6.1.x or master only, I'm
afraid.

--oQzL12nKbmSHS3MD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklhOaoACgkQe81tAgORUJZCsQCdHO5KwVT7uNg7WdhTshsHQVZR
6tsAnRdogDAXmffQbCpMH6Z76id2bmNf
=RNyv
-----END PGP SIGNATURE-----

--oQzL12nKbmSHS3MD--
