From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: A few usability question about git diff --cached
Date: Thu, 4 Oct 2007 14:56:41 +0200
Message-ID: <20071004125641.GE15339@genesis.frugalware.org>
References: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
Cc: Git Mailing List <git@vger.kernel.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 14:56:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdQG4-0002gq-OC
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 14:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbXJDM4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 08:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752966AbXJDM4p
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 08:56:45 -0400
Received: from virgo.iok.hu ([193.202.89.103]:45797 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752666AbXJDM4o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 08:56:44 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id EB56A1B251C;
	Thu,  4 Oct 2007 14:56:42 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 939186FD2D;
	Thu,  4 Oct 2007 14:56:42 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 09DBC13A4013; Thu,  4 Oct 2007 14:56:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59946>


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 04, 2007 at 02:27:41PM +0200, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> Why do we have the option "--cached" and not "--index"?

according to glossary.txt, 'cache' is an obsolete for 'index'. probably
this is the reason

probably cache.h will be never renamed to index.h, i don't know if diff
--cached will be ever renamed to diff --index

- VMiklos

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHBOMJe81tAgORUJYRAkoUAJ9ZtoReO5VK/muxsvUfj/Cow3E34wCfc9gH
uWfr/5g8N6KKRzV2EHT8Sjc=
=50ry
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--
