From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v6 4/7] pull: add --merge option
Date: Fri, 2 May 2014 20:44:24 +0000
Message-ID: <20140502204424.GG75770@vauxhall.crustytoothpaste.net>
References: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com>
 <1398988808-29678-5-git-send-email-felipe.contreras@gmail.com>
 <20140502013753.GE75770@vauxhall.crustytoothpaste.net>
 <536305def1e35_23b2147b2f0bb@nysa.notmuch>
 <20140502193250.GF75770@vauxhall.crustytoothpaste.net>
 <5363fcb47c77d_135215292ec3c@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sClP8c1IaQxyux9v"
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"W. Trevor King" <wking@tremily.us>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 22:44:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgKJt-0006lF-1x
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 22:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbaEBUo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 16:44:29 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47497 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752136AbaEBUo2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 16:44:28 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:406f:e13c:7c96:bfde])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AB23428087;
	Fri,  2 May 2014 20:44:27 +0000 (UTC)
Mail-Followup-To: Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"W. Trevor King" <wking@tremily.us>
Content-Disposition: inline
In-Reply-To: <5363fcb47c77d_135215292ec3c@nysa.notmuch>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-trunk-rt-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247970>


--sClP8c1IaQxyux9v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2014 at 03:14:44PM -0500, Felipe Contreras wrote:
> brian m. carlson wrote:
> > My point is that it's unclear to me what options I need to use to
> > retain the current behavior (fast-forward if possible, merge
> > otherwise) without a warning.
>=20
> The current behavior is to always merge (ff or otherwise), just what
> `git merge` would do, so `git pull --merge`. I don't see what's
> confusing about that.

When the documentation says "Forces a merge" without any clarifying
statement, that implies to me that it always creates a new commit.  I'm
certain that I'm not the only person who is going to think that.

Could you please clarify the documentation for --merge and pull.mode to
avoid confusing users?

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--sClP8c1IaQxyux9v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTZAOnAAoJEL9TXYEfUvaL2isP/0pVGlJ507JwfpwyfCvvULPj
VTuJ42e/Tr+HE8tCtnYJNBlh6c8RjHzCzirnR818chzJXk1g49MWMOIVReOZ9B4Y
DDT7D7VcHxhWalbDSLRvNCt/Qfebx3LewkY8B5zdXeG63Vb7NgC+MWhSewUpZvx1
ptByw1JapXczua5k8rWsmphJhf3/mEsP/Cfe8ebWJO4hBoxf3yoCpNQhhcIGxHWL
inQBFhjF0kfAbalXh9gd4AW28yQ4UE3j5l/F3RZVpALNDn6YvOYBuTDEG+eglT2s
98qaHLvvV1GYp/TdcT7vQa8ng0btQ3L1SWePERM2IaWxCLW4NZ9i8PRSk1Vm67EQ
N+Rjd9q6vFguZjnOaWpc2NZFVpZD+XjnP42tAAv4YtY9x3n139pQ5Buibvv+S+e6
JrSGFsAMHUZDQB1KK1EQGS0GGrR8iHhNB665lI3PMlumIwHdbEO2EJ38UISDW1Pb
Vh1xiVdQ621FiiBr+JLMQG4UEUlxsuIJw35huppwex3SbhM/WQaCjgaVaB3iwEqm
xz3Fi5KWoxJ219VPbno01VWkzsT1v75+YqGup2SBGVknDjNI9bWMLHAUc3ONCJ7K
NdsVz640nKEsdb6s7MZ7z7F7XtWAa/7TH12oNgHmcslv3a/WWbMf5YpSeWvuP/YH
c1fxyeQFFgdbvDZGOX/s
=MLsr
-----END PGP SIGNATURE-----

--sClP8c1IaQxyux9v--
