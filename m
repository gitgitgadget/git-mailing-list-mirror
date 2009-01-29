From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git clone --bare doesn't create refs/heads/*?
Date: Thu, 29 Jan 2009 15:26:57 +0100
Message-ID: <20090129142657.GG21473@genesis.frugalware.org>
References: <be6fef0d0901290606q25ad7c82ob250a5f89d4db0cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q0sTdIfP/s7CH38O"
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 15:28:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSXsj-0004QP-Ef
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 15:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318AbZA2O1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 09:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754112AbZA2O1E
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 09:27:04 -0500
Received: from virgo.iok.hu ([212.40.97.103]:49579 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135AbZA2O1C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 09:27:02 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 2015F5812D;
	Thu, 29 Jan 2009 15:27:01 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 886D24465E;
	Thu, 29 Jan 2009 15:26:57 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 97D6811B87A9; Thu, 29 Jan 2009 15:26:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <be6fef0d0901290606q25ad7c82ob250a5f89d4db0cf@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107684>


--Q0sTdIfP/s7CH38O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 29, 2009 at 10:06:39PM +0800, Tay Ray Chuan <rctay89@gmail.com> wrote:
> afaik, a bare repository is just a copy of the .git folder of the
> cloned repository. why isn't any of its branches copied too?

Maybe you're searching for git clone --mirror and not git clone --bare?

--Q0sTdIfP/s7CH38O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmBvLEACgkQe81tAgORUJY0/ACgo56A/Dh8OP7Rl3S7miGASm9M
cUIAoIH+ngor2FOqfDGFe/NUdKweWo+u
=RX4h
-----END PGP SIGNATURE-----

--Q0sTdIfP/s7CH38O--
