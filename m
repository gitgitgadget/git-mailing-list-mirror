From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [RFC] Initializing and updating submodules during clone and
	recursion over submodules
Date: Tue, 8 Jan 2008 05:07:31 +0100
Message-ID: <20080108040731.GQ29972@genesis.frugalware.org>
References: <7bfdc29a0801061827k7bb18017k17f0e1ae5fff0873@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="roRPt/Cw7eYGd+Rv"
Cc: git@vger.kernel.org
To: Imran M Yousuf <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 05:08:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC5kx-0001me-Er
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 05:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbYAHEHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 23:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752857AbYAHEHg
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 23:07:36 -0500
Received: from virgo.iok.hu ([193.202.89.103]:51540 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752298AbYAHEHf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 23:07:35 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 434631B2554;
	Tue,  8 Jan 2008 05:07:34 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id CC3E94465C;
	Tue,  8 Jan 2008 05:05:53 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id D84181190499; Tue,  8 Jan 2008 05:07:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7bfdc29a0801061827k7bb18017k17f0e1ae5fff0873@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69837>


--roRPt/Cw7eYGd+Rv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 07, 2008 at 08:27:25AM +0600, Imran M Yousuf <imyousuf@gmail.com> wrote:
> I have added "recurse" command to the git-submodule to recurse any git
> command and also added fetching of submodules during cloning. Please
> have a look at the changes and let me know your comments on them.

you want to send a patch. please read Documentation/SubmittingPatches. i
doubt anybody will comment your work unless you do so.

thanks,
- VMiklos

--roRPt/Cw7eYGd+Rv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHgvcDe81tAgORUJYRAtgQAJ0XjetSYcy97C5xSIeo6rF0uUlhNgCgm/a6
LRqVJybXN5OHpLb1+gNi+QM=
=Dgue
-----END PGP SIGNATURE-----

--roRPt/Cw7eYGd+Rv--
