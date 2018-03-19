Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07E7D1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 14:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932891AbeCSOtc (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 10:49:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:37013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755632AbeCSOta (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 10:49:30 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZU7V-1fBsS00Cjt-00LJ25; Mon, 19
 Mar 2018 15:49:25 +0100
Date:   Mon, 19 Mar 2018 15:49:06 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     David Pursehouse <david.pursehouse@gmail.com>
cc:     git@vger.kernel.org, David Pursehouse <dpursehouse@collab.net>
Subject: Re: [PATCH 1/1] Fix typo in merge-strategies documentation
In-Reply-To: <20180317033142.20119-2-david.pursehouse@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803191548080.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180317033142.20119-1-david.pursehouse@gmail.com> <20180317033142.20119-2-david.pursehouse@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3rUmpbOCbkEH7LWlQ6nWZ6pHU6O3YECXxF6xL81a24FKLNaGUs/
 wvVo4LtaOWggfKHbtHXdb0s4pl31vz+dsW38HB9uB2SfVK5rtsL1+uPANT+EODh+XMrEj04
 Ik4T7LVcXeCoO8xad5tkqyXZmNsah97z/pMIktPGqHiRK/3NZMemQUn+PnV3yvUEbzYoMMy
 W2RA8fiuygF6TZ6tuiNKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dJf/Gy/xid4=:4eubqXhvR6FY/jji2Em2dx
 fk3I6tftIciiVp+WVjMCBei450q+8y8zekuKGUIagFFF994M5xK7qYaNl9ZqNhx2sl54SArPr
 IE6/LBE9/eP4nETTmjR/A7Ui09njC5E+YGErZj2pSSODCGiHIELOSG8W5Rqb3dSXzS3XOIQyO
 xRG/KWwWpmNXBoxoO8WvkP1vuBb1hKmLt7AvJvE7LZQ4iO84Z23y7a1cpNctE6gkzUbpXr1GK
 VAouIZql1JLsQm7v8WfxoZQFX7Myou70imJjhvHcL9VnvS7lp7EsDwTtltPXr0Wx+rdCjdFSA
 le3MiQME1pFNd6ZoBSQnBkNi7sGTlcqyUNAsCK+AajW7mEQvp0Xd0AprGly8NFLftDJX/Z7ju
 Qe9eR9eBYW2QZTd2RsrBnX1yhmceKy88TzWR7T11oQAsGJ8EsFMthD2GNdt/V5LqJgAagDkGx
 zgzppiptY2+cNj1XwsoteonJ7ob4d+nMCu4Ya5+RQI2WNR3ASoySFCXnAOClKKevAU9iykHZK
 DVQBvJDwalBeYk+ByKjxNkPdnnqUZsI23bjI7U+khXeOtuLyQAvbHOJ6l+l9TBHfPgEDmT+t8
 +ftWHLi+OyeJPkQ4i3xnnns1NupSiRyQjKGQ11pwoM5T68WE1ZAc/KCEiCeVdVr3Hs0NVoc/C
 JusmXZhKXItofqhFY36j5oNez+2l8fpsRhiIHPvP0V0uyvKCuztiXwscoJJdOZvzV0lFzjohj
 ozZxzM0zlHsPRfCkyAwt7m8BlsNlx+JZTYB8nNvpskulJFJYFhSthKcfd11m51ucGGbSxtMVq
 36tbNE54kf0LnVyr/5ympEpuGGqnzfwZlrIuGxZplHR58kPGHw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi David,

On Sat, 17 Mar 2018, David Pursehouse wrote:

> diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
> index fd5d748d1..4a58aad4b 100644
> --- a/Documentation/merge-strategies.txt
> +++ b/Documentation/merge-strategies.txt
> @@ -40,7 +40,7 @@ the other tree did, declaring 'our' history contains all that happened in it.
>  
>  theirs;;
>  	This is the opposite of 'ours'; note that, unlike 'ours', there is
> -	no 'theirs' merge stragegy to confuse this merge option with.
> +	no 'theirs' merge strategy to confuse this merge option with.

Well spotted: it is `strategy`, not `stragegy` (nor `stragedy`, I might
want to add :-))

I just verified that there is no other hit in `git grep stragegy`'s
output.

Thanks,
Johannes
