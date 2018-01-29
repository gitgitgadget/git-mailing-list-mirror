Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4376F1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 15:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeA2PJ5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 10:09:57 -0500
Received: from mout.gmx.net ([212.227.17.22]:50583 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751599AbeA2PJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 10:09:56 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LcVOE-1f52Iu2c8k-00juVf; Mon, 29 Jan 2018 16:09:54 +0100
Date:   Mon, 29 Jan 2018 16:09:53 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] Add "git rebase --show-patch"
In-Reply-To: <20180126095520.919-1-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801291609060.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180126095520.919-1-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-470767250-1517238594=:35"
X-Provags-ID: V03:K0:tVgSi5Vx1maj6Q6w+bxyCwOl3m5GVlBJB9VxadMGJ0hX2u/x7+d
 qQNIFeXlxMN+3cxAhk2Pe7+obU3a+Z7Wu8iHbA0jJyBiT92ifSkCWRz22zATkNthRe2Fzgi
 TWDAg+/Dq02mknw4w8q75db9z5JVlRcQZPVJydnu6tp0EEScQgwUrIbX1aVIDfs+68PFqBW
 wX4tV4xXaPsj3Kg1gQBbg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VYo3kEKM/pI=:GDEEiomJi+OKFHASdml/2I
 rAEsF6IO0jBnZIJSIEk7U8YpZasbr42tOw13lrhU1eTcTXiZivYgkz1MhogassGOmT5yKwfuP
 gEdGEhtNToV9aA+HkMlqtM7zkFw6mO5PsZIob4/lXRa3sey+uCuoIWa5BXFfuD6Xej9/3MNqq
 Srxi9OCD5vN5MJOMJ6nV6QwKEWmUe8aaL/oc4wY/dCO/7DAwm6erMMqXCTABQhq3fa8uDJONO
 RmTnLMcz8JC5A+8uX6ahMVGUrO+aDXSCbTmmiqDZODdZ62fwrMDOjI6BWKX4uXq0GBRzUZ4dp
 1ihR4JkTrcWvuLXBBrH61pduVcf6NJ6CdEpsxKJ0SEQW9rV/hBU8VzTQl/HNUAkF+SaY/I8lb
 RsXbpyrwpjXx8PG1NZx2ZxHCXrqa+KehxxDNznKCHf4HoHv1MvnkP5up532uD7BlqubN3dTwv
 RNYxGl5RbBjsJeAgzpn4LU1d2DBeIRCHWkvFGgLL4PqaZ43dB5Kwkac9DVFak1wF0GkvuIJWk
 yyAZe/wiBiARfExJmwqWJDORjuZ9XBUNybKf0rpfxVpnFPoxFo4HQFyOfKQkxMhuXjE4Wh10V
 qrAvQ0KvcoEAjt7qBvcqjEl1mWOS8haw7S3aA8Hnz5Uw8wVsWf4ci8ySykJkafyG9kjXL6x7v
 oPPy23dQ+9db9Iu8TQZRunUvBX6+dSNKOrWRz7VsK3Al4braPMuYh7lvnhkxPNREKl0J/qU4y
 9wPhHKxEzobLo3ttl/DFRxxt/UgDg9vQdCY1s3iQrhsX/br0bRzq/5N+c/YRQ1IXttmysV32A
 O/KgW/NvqxBQFGNygiAcmZ9738SXOL35A/SBeuRAgHMImeyOLzyi5h6KUY/f6w7174ogpiM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-470767250-1517238594=:35
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Fri, 26 Jan 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> When a conflict happens during a rebase, you often need to look at the
> original patch to see what the changes are. This requires opening your
> favourite pager with some random path inside $GIT_DIR.
>=20
> This series makes that experience a bit better, by providing a command
> to read the patch. This is along the line of --edit-todo and --quit
> where you can just tell git what to do and not bother with details.
>=20
> My main focus is "git rebase", but because rebase uses "git am" behind
> the scene, "git am" gains --show-patch option too.

Makes sense. I am not a 100% certain that 2/2 catches all rebase -i corner
cases, but I think the patches are good enough even for `next` already.

Ciao,
Dscho
--8323329-470767250-1517238594=:35--
