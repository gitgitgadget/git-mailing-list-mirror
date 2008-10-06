From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: how to restrict commit for a repo
Date: Mon, 6 Oct 2008 15:00:42 +0200
Message-ID: <20081006130042.GQ23137@genesis.frugalware.org>
References: <c94f8e120810060509w5eaa9138m92f1df36c9c36db6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3rJHFI6MEixShaG1"
Cc: Git Mailing List <git@vger.kernel.org>
To: Dilip M <dilipm79@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 15:02:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmpim-0000Tj-Df
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 15:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099AbYJFNAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 09:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753135AbYJFNAo
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 09:00:44 -0400
Received: from virgo.iok.hu ([193.202.89.103]:42375 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753067AbYJFNAo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 09:00:44 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id C4B72580C5;
	Mon,  6 Oct 2008 15:00:42 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A54A44465E;
	Mon,  6 Oct 2008 15:00:42 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 81F2511901A1; Mon,  6 Oct 2008 15:00:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <c94f8e120810060509w5eaa9138m92f1df36c9c36db6@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97579>


--3rJHFI6MEixShaG1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 06, 2008 at 05:39:39PM +0530, Dilip M <dilipm79@gmail.com> wrote:
> If I have a repository, how to prevent push from other repo's into
> mine master's? I want to prevent the commits from all developers and
> allow only few ppl to commit to masters..

Have you seen contrib/hooks/update-paranoid?

--3rJHFI6MEixShaG1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjqC/oACgkQe81tAgORUJZ4mACfU6mvMAddcVjy5g/dqi5OCVjb
CdcAniTXhJfyV+klgOnSYi83HrhrJe01
=TztQ
-----END PGP SIGNATURE-----

--3rJHFI6MEixShaG1--
