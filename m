From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH next] git-cherry usage: correct nesting of commit-ish
	options
Date: Sun, 4 Jan 2009 18:35:59 +0100
Message-ID: <20090104173559.GG21154@genesis.frugalware.org>
References: <200901041711.23026.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9teSV9pdwBI9hpI9"
Cc: gitster@pobox.com, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 04 18:37:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJWup-0000MD-79
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 18:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850AbZADRgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 12:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755619AbZADRgI
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 12:36:08 -0500
Received: from virgo.iok.hu ([212.40.97.103]:48478 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755391AbZADRgH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 12:36:07 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 25DC6580CE;
	Sun,  4 Jan 2009 18:36:05 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id AC92D4465E;
	Sun,  4 Jan 2009 18:35:59 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id D416011B8630; Sun,  4 Jan 2009 18:35:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200901041711.23026.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104528>


--9teSV9pdwBI9hpI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 04, 2009 at 05:11:22PM +0100, Markus Heidelberg <markus.heidelberg@web.de> wrote:
> Another question: should this patch be split up into two, one for
> maint/master and another for next?

AFAIK sending patches against next is not preferred at all. You should
send your patches against master, or - if you have a strong reason - on
top of a given topic branch.

In the later case I just use to write "This applies on top of
'xx/foo-bar'." between the three dashes and the diffstat.

--9teSV9pdwBI9hpI9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklg838ACgkQe81tAgORUJZ4qACglVdrdWDm2MzT22xcX0ng1iUd
F7YAniqan+vmm5sZgHjj1fwi436eNg/Y
=IQlL
-----END PGP SIGNATURE-----

--9teSV9pdwBI9hpI9--
