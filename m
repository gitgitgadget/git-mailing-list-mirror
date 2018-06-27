Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E6FB1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 12:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753631AbeF0MBy (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 08:01:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:41507 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753124AbeF0MBx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 08:01:53 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LikyX-1gAUhT0d81-00d16O; Wed, 27
 Jun 2018 14:01:38 +0200
Date:   Wed, 27 Jun 2018 14:01:38 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Vladimir Parfinenko <vparfinenko@excelsior-usa.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] rebase: fix documentation formatting
In-Reply-To: <DE671AEE06C994438C1F64DBF4C85FA753C1D3@mail.excelsior>
Message-ID: <nycvar.QRO.7.76.6.1806271400470.21419@tvgsbejvaqbjf.bet>
References: <DE671AEE06C994438C1F64DBF4C85FA753C1D3@mail.excelsior>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:A1uXrSyhLuGLapO9Iy7dZmBTVcP2x0CkLtnT051saeTkuCWogkY
 380nij8J7FuLAinRvVz1D+VrvpCqxTmEWAO8Tixx1XHRUFYbxEqk3i/w308CW1paoGHuSFt
 G4LVXUO8pdIZoZbC7IgWn3wB5Ad6nMdsosIwNZeg0HSKLuxdMDi5y1NJpD8S1hSbeTnQoKG
 /yDt2ICdfPYmgbdRLtlUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DL6fgY34Azw=:krdGGlSQGZ8OBp/CnEECND
 7W2H/cXZ5ppp4TVx+xiYY7kMqY7ZaFQRjxEq+E225M/R38QKPM/8wB4e4JLuxqjOY0WVb2NtE
 I0go0MpZA9hoIra7OcvYelp5C8mbLQ5xDHShSNdGOyDblAvTao0/dn89IUNW/qaZg6v5VHQjV
 y9H4v3AKQUXtrdnu2jqP+HI7+HBugfoDb9ipPtev586rICdgCw+5y/TUUzk4iC5LCMAc+0eYa
 czUqfY7AK9ygRi1a5BtAbblpoYvNjtMAP6NikHn4ETXaMyVGc34yPrerHilGCPLOFHo2tT6U3
 gqDT7o+a6CVJkQh83DWhjB56Y/eNTnDKWJ0RHhzUEybyo6zCrtBQZb8WIT0Up4czO6E1i0ONG
 oD4Oj/OFzT7J1AsVovY4NzxvsuJ8Ci/uyCpELOft3YFUNbdFTXO/EHQXT/+vAH1KckI6LnN7M
 bde9aS+hrtJmDLVWiwR6A4SZ2VVIbcu1hl+mI+cOf+dTaaVub2NkZMHs+dvH+XXnVfkSQTiYO
 aa1twnnvuA1zLAHDxfShIopVVJJvuouCn8md2t7Ald5XgXQmmMcQ4VOlQ99Rm7oU3L+2XqXRe
 67h8Xzk+PraU2bWUHQ2Jc+N6wum2Viaik1ncTCepBOiGLkZC/PWislTQv7S1GQyh0sqh4AhdX
 MrBgB9j6V5pWKpenrJ0wk62dwTiC0R1eF4dnEU7QMvOaoZ4Sag5jsQ2IWD77HvCqxciI2KE73
 av6jKznXQmS0G0Muj9OFU4meczeV1jiObEFC6E9oaMgejUgdAJMWNK2dVaOdxNL5tzATC0A+p
 gOTbmJh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Vlad,

On Wed, 27 Jun 2018, Vladimir Parfinenko wrote:

> Last sections are squashed into non-formatted block after adding
> "REBASING MERGES".
> To reproduce the error see bottom of page:
> https://git-scm.com/docs/git-rebase
> 
> Signed-off-by: Vladimir Parfinenko <vparfinenko@excelsior-usa.com>

ACK!

Thank you so much for fixing this (as you may suspect, I forgot to adjust
the length of the "underline" after changing the header from "RECREATING
MERGES" to "REBASING MERGES"),
Johannes
