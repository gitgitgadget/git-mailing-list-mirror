Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FBB51F855
	for <e@80x24.org>; Mon,  1 Aug 2016 21:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386AbcHAVOp (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 17:14:45 -0400
Received: from nm24.access.bullet.mail.gq1.yahoo.com ([216.39.62.55]:39923
	"EHLO nm24.access.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752522AbcHAVOm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2016 17:14:42 -0400
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=bellsouth.net; s=s2048; t=1470085128; bh=j6UeHqOfO/iyjLkZD/pAYjCsLmYkhzm6U8Y+h7Vioi0=; h=To:From:Subject:Date:From:Subject; b=R1O2qwKLlW3A6+ej/aXFKVLcTejIxze/CLQSNwfA+lKSkpBUDHlilqYjuISsp3rRXLDYekjvFhzOUIH5kWeUdeXVt6hhbjasyLVT/NUHwJOQCPMoIikwcxjq4c+5a0Lg2MXxhxeK1CZwNZzdHgfgn5eZZE/V/Qyc2FDFzqy8NkMvwesiPBJAVB8rAvN+8VeUwzxZvst8tK98pjKfB8B9H6s9MMbmaj/nxaQTfLZ/l4BWoPqESXo4Hof+c7VhUQqr6PSdhay/nTM2No8v1KPq9sg3TS3Ddo9A0fET+GA4GqjcqsvBtO2yCCBqKbka/woT3OGOrCOXqGGo3sYWabsrzw==
Received: from [216.39.60.166] by nm24.access.bullet.mail.gq1.yahoo.com with NNFMP; 01 Aug 2016 20:58:48 -0000
Received: from [98.138.104.99] by tm2.access.bullet.mail.gq1.yahoo.com with NNFMP; 01 Aug 2016 20:58:48 -0000
Received: from [127.0.0.1] by smtp119.sbc.mail.ne1.yahoo.com with NNFMP; 01 Aug 2016 20:58:48 -0000
X-Yahoo-Newman-Id: 597796.42610.bm@smtp119.sbc.mail.ne1.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: nIypyDkVM1ls5lz0sJwmaKQefW5Y5BZ_QAikl1Ug9tG7fPw
 AjwRqC_9_zw1e3hSz.DUUGzjtCPWI8h8iujKdICp8QZe6NF_hFtlMU6kEH4S
 V88HLdp_TG.MMce0teKFEfuUzb9xW_CaxcA0syW7x_KWxtVaUI3B5D7hsgze
 Rttj4MLvB9aFV2pl01tELkLzDNtBnfIvGFst5ewCRcwLaY8bYbjB94LKZN60
 jXgxLW2xmdmr6AHzUcf8LFohX8XpNuN6TBFXe.Af1rkvMNJF_LJtBhAzDuVS
 gPfWaBkaK5ygpDX0ZMBNS8Z21vUDnIsHmplA5QWzL8fD0dTreAPsI.rKOuWW
 q2Btdf742IBM_34wfyBxhcVD_HQsmCf9KXKoF05saUvpqoLrAlqqvXecPGS3
 EMTtX9IqN8IPB9fegcATnif36yygZW1oBfWaQlAXNdUslqI5P2nB6z1rTISC
 akKDrQ920VbWbpSLk1ylheA0Km48jQFya3janHjuB88YVd8Nx8HZrNi8MNQE
 0quOHDPVy8i50bM1sZUwDVPW0AFjjn4Jv1qd3JYMoUHi2gaOdAlucNFC7TnE
 Bgco-
X-Yahoo-SMTP: vUK3UKuswBCE01YQVYEZ1wHCa.HPSVCYhektzgdifA--
To:	"git@vger.kernel.org" <git@vger.kernel.org>
From:	Dennis Putnam <dap1@bellsouth.net>
Subject: Recovering Folder from Git Restored Repo
Message-ID: <84080bca-af5f-b957-460a-0a4a81f383e7@bellsouth.net>
Date:	Mon, 1 Aug 2016 16:58:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="auNqMBmp9N9lPu1wNGRH3WA5QpNL4GPdr"
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--auNqMBmp9N9lPu1wNGRH3WA5QpNL4GPdr
Content-Type: multipart/mixed; boundary="UXEj4389xvrAlSkx1p2njAwQtnJTsftpF"
From: Dennis Putnam <dap1@bellsouth.net>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <84080bca-af5f-b957-460a-0a4a81f383e7@bellsouth.net>
Subject: Recovering Folder from Git Restored Repo

--UXEj4389xvrAlSkx1p2njAwQtnJTsftpF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I am in a bit of a pickle. I deleted a remote repo that had a folder
that I belatedly realized I need. The deleted repo exists on a backup
which I restored. How do I extract the needed folder from that restored
repo. Not being a git expert I'm not sure what to do but I cannot find
any recognizable sources. This is an 'ls' of the restored repo:

branches  config  description  HEAD  hooks  info  objects  ref

TIA.



--UXEj4389xvrAlSkx1p2njAwQtnJTsftpF--

--auNqMBmp9N9lPu1wNGRH3WA5QpNL4GPdr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iEYEARECAAYFAlefuAgACgkQ/fiWYqZ2tVTF7wCgh3sCy+m/nq/DZjur3QIJQT+F
8kIAoKaxLGMPblsjoKQ1c5as0DyqQ4/o
=1lw+
-----END PGP SIGNATURE-----

--auNqMBmp9N9lPu1wNGRH3WA5QpNL4GPdr--
