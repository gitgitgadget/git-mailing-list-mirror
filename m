From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [biseced bug] make info fails with master
Date: Fri, 13 Jun 2008 20:58:51 +0200
Message-ID: <20080613185851.GY29404@genesis.frugalware.org>
References: <20080605234016.GO29404@genesis.frugalware.org> <7v4p7yyyzg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ihtn6Mqxjc4ElBJa"
Cc: git@vger.kernel.org, David Kastrup <dak@gnu.org>,
	"John J. Franey" <jjfraney@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 21:00:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7EVE-0005na-Md
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 21:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbYFMS64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 14:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752608AbYFMS64
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 14:58:56 -0400
Received: from virgo.iok.hu ([193.202.89.103]:44642 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289AbYFMS6z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 14:58:55 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id BAA2A1B2530;
	Fri, 13 Jun 2008 20:58:53 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 4C97044668;
	Fri, 13 Jun 2008 20:40:01 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3DB591770022; Fri, 13 Jun 2008 20:58:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v4p7yyyzg.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84932>


--ihtn6Mqxjc4ElBJa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2008 at 05:12:19PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> I've made a few changes to work these around but haven't pushed the
> results out.  Here is a preview of two relevant commits.
>=20
> The *NOTE:* thing could be new but @pxref{[REMOTES]} thing has been with
> us from very beginning and we already had a similar workaround for it.

Thanks, it solves the problem for me!

Tested-by: Miklos Vajna <vmiklos@frugalware.org>

--ihtn6Mqxjc4ElBJa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhSw2sACgkQe81tAgORUJavswCgqIZ498bG5ByNHkm0T8IFvOX/
4yMAniFe+4mufWS5KfXlGzBOob+dBYDJ
=NNb4
-----END PGP SIGNATURE-----

--ihtn6Mqxjc4ElBJa--
