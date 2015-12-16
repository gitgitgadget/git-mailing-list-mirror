From: Patrick Steinhardt <ps@pks.im>
Subject: Re: (unknown)
Date: Wed, 16 Dec 2015 09:44:06 +0100
Message-ID: <20151216084406.GA3241@pks-pc>
References: <1450234966-28796-1-git-send-email-greened@obbligato.org>
 <xmqqsi33djfl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Cc: git@vger.kernel.org, john@keeping.me.uk,
	sandals@crustytoothpaste.net, peff@peff.net,
	Junio C Hamano <gitster@pobox.com>
To: David Greene <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Wed Dec 16 09:44:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a97h7-0007gr-Qi
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 09:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540AbbLPIoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 03:44:10 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33131 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753635AbbLPIoJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2015 03:44:09 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id CA5F320CC9
	for <git@vger.kernel.org>; Wed, 16 Dec 2015 03:44:08 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 16 Dec 2015 03:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=mqDVjMj2Qi5+aLsJsBwBeJWfXlE=; b=IfCho
	A/KwWHw0xN7TlB8pvac9RjeZB94XZ5tnmuF4pd/w6/u0lVpq2856w5l2FmNGlpi1
	XgIX8YezWCi2Z5LGpZ1q4r9JkxU38iUTwxuQSMjLEk7P0Hc5WxgLhiFzpbOVQbN2
	jlQcgy/P+nuGJCZ4+n6P+JK1E1cb1IJXh2xT1w=
X-Sasl-enc: bFf3p3rjY5mviQQbqeOH2N0hj1YuqDLRpUfjuRQg9Rn3 1450255448
Received: from localhost (x5ce0fb64.dyn.telefonica.de [92.224.251.100])
	by mail.messagingengine.com (Postfix) with ESMTPA id 3F874C016D5;
	Wed, 16 Dec 2015 03:44:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <xmqqsi33djfl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282546>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 15, 2015 at 09:57:50PM -0800, Junio C Hamano wrote:
> David Greene <greened@obbligato.org> writes:
>=20
> > - If new option --keep-redundant is specified, invoke cherry-pick with
> >   --keep-redundant-commits.
>=20
> This came up in the past several weeks, I think; you would need to
> disable patch-equivalence based commit filtering if you really want
> to do a --keep-redundant that is reproducible and/or reliable.

Here are the links to the previous proposal [1] and following
discussion [2] (see 'ps/rebase-keep-empty') if you are
interested.

Patrick

[1]: http://thread.gmane.org/gmane.comp.version-control.git/281515
[2]: http://thread.gmane.org/gmane.comp.version-control.git/281917

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWcSRWAAoJEBF8Z7aeq/EsO+EP/3pU3KsIRU2grXL61FW+XpAN
DMzc8/vpoYGP1gBi9kjYSnLUh45rdyYpb6X44A00LucvUnaiH0CYOqckLKRABZBR
NO2yeQr4Mi5fGh2m9B56gce/mUCLXW9DBC2WTiWrEQoiHcAl2ApMd34xngqRONzj
Gxqs7I8kHV1tVl+CN7U2SdLhNsBz6jzhkN4M3DWqVWUNa+sjoIAXtYK+ecsU7VBx
/gKoB2Lu6tpimu0D/5EFoyfB2FDoVdYIqRQVt3aecrPXo/vP0exYjDDgQhAPzu7s
u9GydLHEuJ3X/8LRad03Z2FLQWiPLD2Bh6Vio5iyLaZevlmo4k2bFZdgSyM9Rcj8
PnX7EtqboEe4KRLeUFFy36jgds47yngKBAwlCkpa4LWNrdblEmYjZVFPIv8IrZUa
JOVUp2+P4DskgmY1tpw1T9BhJ4+ulILCpaZ1mwGVCLKfzl3Ryj5YQrlyB11JkFJ/
YuOq62e1yGyzCTvfIsrlUHVLEo9Y/oJMPgilSN7sjyHyRQFUmY/+BYR3EO389lSs
jwkcLLvrHXhcqCUxgxhiKuatla79HD7Gc1yYLY07+Dtkzaf1FnMhPx6aRsnHbV7k
P1F6BZiAngOQMEB5dvvYm5HuOa1ef8V2Kys7ZAteSVWkFWBiW3nWCzOJYKfWltJj
lnvH0uirpbauIcMBPkB1
=Id8X
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
