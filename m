From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Documentation/gitcli.txt: dashed forms not allowed
	anymore
Date: Thu, 1 Jan 2009 15:40:45 +0100
Message-ID: <20090101144045.GC21154@genesis.frugalware.org>
References: <87ljtvmygk.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iuNVq+MSMwU9tqfB"
Cc: git@vger.kernel.org, gitster@pobox.com
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Thu Jan 01 15:42:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIOki-0002Tu-Jr
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 15:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756224AbZAAOkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 09:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756222AbZAAOkw
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 09:40:52 -0500
Received: from virgo.iok.hu ([212.40.97.103]:58723 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756208AbZAAOkv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 09:40:51 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 23EDC580F8;
	Thu,  1 Jan 2009 15:40:47 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 9D9AB4465E;
	Thu,  1 Jan 2009 15:40:45 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 4175B11B8630; Thu,  1 Jan 2009 15:40:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87ljtvmygk.fsf@jidanni.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104296>


--iuNVq+MSMwU9tqfB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 01, 2009 at 12:39:39PM +0800, jidanni@jidanni.org wrote:
> - * it's preferred to use the non dashed form of git commands, which means that
> -   you should prefer `"git foo"` to `"git-foo"`.
> + * it's required to use the non dashed form of git commands, which means that
> +   you must use `"git foo"` and not `"git-foo"`. The latter no longer works.

I would append: "unless you add the output of `git --exec-path` to your
PATH."

--iuNVq+MSMwU9tqfB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklc1e0ACgkQe81tAgORUJbmuwCfZZtFM1wOe5o5yK0g3TSBZ7Vj
K60AoKo8+cg42lI3HFMLbfvOMsPa/3b1
=AG0E
-----END PGP SIGNATURE-----

--iuNVq+MSMwU9tqfB--
