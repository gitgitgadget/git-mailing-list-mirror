Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,
	RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 847E6201CF
	for <e@80x24.org>; Thu, 18 May 2017 21:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756062AbdERVVc (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 17:21:32 -0400
Received: from mout.gmx.net ([212.227.15.15]:49173 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756046AbdERVVb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 17:21:31 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MAPoQ-1dHYjy170M-00BbcH; Thu, 18
 May 2017 23:21:28 +0200
Date:   Thu, 18 May 2017 23:21:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] rebase -i: Add missing newline to end of message
In-Reply-To: <20170518134154.12771-1-phillip.wood@talktalk.net>
Message-ID: <alpine.DEB.2.21.1.1705182321030.3610@virtualbox>
References: <20170518134154.12771-1-phillip.wood@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ehcUS2884QWjDHnEEeTK+8FpR3GJFxrMzvVnDUX3IosE3LjuBLW
 jbaKTjwt00e4gGkBPwqI7ts2qZFRHZr9Bn5NbZZMq0Waxf6AU69upquyMDevzdPMPcyeIZU
 IPuNC4LTORp19FV7Kx5iIckZ1DeGu58+CZFkn64iTA/0vXQoutUkzzqDNUmhfVYZMdFy6TH
 3a4kXAiaP8CXw2BdcJh0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W0XuhCeE248=:0tAMUrP8D5KWdvOYTnEHmd
 LqzdmqvRd9PlacYmHvHNN7PD9GYWaXsQm6moeOtc0tA+6PzpuUYdlHtijYUjIc/ps3SOHRbjP
 56RHjGtvu+BIXgqLi2s7sKOueTZu0nAHgFbpkDZvROatPEJTZte4Que43E1wC1SATCa3iLQFE
 aO1lealrxcBA/wryFi8NVQ8b9wheqfNFsFpnW81T7tIIwuZkyFviMVw2YAwg/p3aoce7hJ2HR
 6C9nRryWhmn2ljdVT4ZMrBnk6DsIEb3blih7GDektaTVyFEyddXCCC1yZo9gMtqfSnDjEIbTN
 Pc401ABvi1Bj3jycZHlqTp1Cqof6nVMMj9/X8n3bR/KDbM13y5bHzcnVXXOH7mpuO4SZ2QKxd
 vcqcuW/+Qh4i6p/dXGC1nPylMHTEsoXziwK3xNk+DGiH8gi19fBYJpv+ML4TT+1WME70H1+GF
 thvcAdSUS1dunu2dxycs9Z+KOiwEYXD5T0gdnis7NTk8n+ol+OYXu7pGeHYytQvDJbTuwWBLr
 N+YxgdGA/sQot4fgIV5wgod1sXwPdOWz0OHH8RKELYbQjpS3DZGA7tf+J1VSlpKZMePvjbdM3
 lx24FYqpuuyjXONRijju5NGh4TrR3Bds4UEZCoIN7pilT2bfDHH103T1xz4hKd4XYi+ASC7rl
 4TDQQ1NEgUCzLonpRRDP8HI1k6xjX6a5/QJlp6RF0etTgtQeHTabczbK2AhOLuIlWwZf2cG3E
 hhoj6VwwUd9gkaEc1mbRvvTAU9oP6V/PsG00tLD7c6iK23Sh96fD4Mds8aEHeKe2Yw1icpX/C
 ZEZAZmC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 18 May 2017, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> The message that's printed when auto-stashed changes are successfully
> restored was missing '\n' at the end.
> ---

Please add your Signed-off-by:, and my Acked-by:

Thanks,
Johannes
