From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [RFC PATCH] During a shallow fetch, prevent sending over
 unneeded objects
Date: Mon, 21 Oct 2013 09:51:39 +0200
Message-ID: <20131021075139.GA15425@login.drsnuggles.stderr.nl>
References: <20130711220127.GK10217@login.drsnuggles.stderr.nl>
 <CACsJy8CP6pGRwEn6H=cbKxTMuOjzAF3=Qh8qsLbJaw6feK3NMw@mail.gmail.com>
 <7vfvukbrqh.fsf@alter.siamese.dyndns.org>
 <CACsJy8BahoGcDcLjSaHA-62_KQE2wD-p5oeJOOA4nk8ZRfXrEA@mail.gmail.com>
 <20130812080203.GK10217@login.drsnuggles.stderr.nl>
 <CACsJy8CDGgKftp0iBB8MYjMawKhxZ1JQ+xAYb0itpaCOjFHWxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kai Hendry - Webconverger <hendry@webconverger.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 21 09:51:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYAHK-0004F1-5g
	for gcvg-git-2@plane.gmane.org; Mon, 21 Oct 2013 09:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765Ab3JUHvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Oct 2013 03:51:50 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:45180 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574Ab3JUHvt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Oct 2013 03:51:49 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1VYAH6-0008Vw-G5; Mon, 21 Oct 2013 09:51:41 +0200
Received: (nullmailer pid 32728 invoked by uid 1000);
	Mon, 21 Oct 2013 07:51:40 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kai Hendry - Webconverger <hendry@webconverger.com>
Content-Disposition: inline
In-Reply-To: <CACsJy8CDGgKftp0iBB8MYjMawKhxZ1JQ+xAYb0itpaCOjFHWxg@mail.gmail.com>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236425>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Duy,

I saw your patch series got accepted in git master a while back, great!
Since I hope to be using the fixed behaviour soon, what was the plan for
including it? Am I correct in thinking that git master will become 1.8.5
in a while? Would this series perhaps be considered for backporting to
1.8.4.x?

Gr.

Matthijs

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAlJk3QsACgkQz0nQ5oovr7wVOwCgvQCmB4IJ6X86727/5Kslg83G
A4UAoI8fBIXGnE1PwtwqFk/Od697dgNM
=rjMT
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
