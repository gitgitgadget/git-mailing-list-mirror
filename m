From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git documentation
Date: Tue, 6 Jan 2009 02:46:22 +0100
Message-ID: <20090106014622.GA21154@genesis.frugalware.org>
References: <alpine.DEB.1.10.0901051745280.28514@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QtaS+3lVuRodb1W+"
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Tue Jan 06 02:47:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK12v-0008B2-AL
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 02:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbZAFBq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 20:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbZAFBqZ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 20:46:25 -0500
Received: from virgo.iok.hu ([212.40.97.103]:43686 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751003AbZAFBqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 20:46:25 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 7D62A580BA;
	Tue,  6 Jan 2009 02:46:24 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id E60B14465E;
	Tue,  6 Jan 2009 02:46:22 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 780FD11B8630; Tue,  6 Jan 2009 02:46:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0901051745280.28514@asgard.lang.hm>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104615>


--QtaS+3lVuRodb1W+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2009 at 05:46:56PM -0800, david@lang.hm wrote:
> why. Yet probably there is no line of documentation on the Git site or=20
> elsewhere that I can quote to justify adding a "Yes" to the comparison.

I think it's documented in Documentation/merge-strategies.txt, under the
'recursive' merge strategy:

"Additionally this can detect and handle merges involving renames."

--QtaS+3lVuRodb1W+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklit+4ACgkQe81tAgORUJYS0QCdGWw3ZpMIs1l2Bm126oqCIfXg
ojEAnis50U5uyAdkE3o+fnb5u9+KAP/K
=OW2t
-----END PGP SIGNATURE-----

--QtaS+3lVuRodb1W+--
