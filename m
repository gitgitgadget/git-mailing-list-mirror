Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1400211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 20:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbeLCU4h (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 15:56:37 -0500
Received: from mout.gmx.net ([212.227.17.20]:44075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeLCU4h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 15:56:37 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MaE4a-1gnmXL1EL2-00Jqzi; Mon, 03
 Dec 2018 21:56:35 +0100
Date:   Mon, 3 Dec 2018 21:56:19 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] rebase docs: fix incorrect format of the section Behavioral
 Differences
In-Reply-To: <f26b53e3-e7d1-f0fe-cdd3-dd734beb1628@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1812032156000.41@tvgsbejvaqbjf.bet>
References: <f26b53e3-e7d1-f0fe-cdd3-dd734beb1628@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:r6RBG6AXlSQtfsGXVxfrOwrmAsa9wE/wPgDgceYc/megX1mRDA3
 WWABaz6JpuCp2pzyTTPaow+FbpjPxOFsKtQH72k4kIDTMafnG4J6rc+5nC0FTL878yRJJ6M
 YwYItqcrL3nfePQYEueGCvHEMNEcyA3Ntbqj4bAxDdw4gDF1mxW7i046FonDEGhINtixUaL
 E2L4n8MT1HK0mOYisLnPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XSFxGr4ssQQ=:oMLGnY3k4gA7Egmjvez5/N
 q+Dd6okn09B8ar00wsiOox/XkMbcKzYBP3LTGMNQLriSM3Ah59c4LXSdWtpNadYANxBF1pgBX
 ft7gL4JjSqaCjn51dxD5ieZlYT3q3AuKx1SLNHGnJcECUdekEXjKdpwjucCgsQ5RqbeTl04KY
 Hoo+YxDwVR3FbJZhnuDtGq/Elv5VDWZWbxf5j9p1EFC/p9EJQvcml9SvcjbhuvLCi3ahCQXuD
 rXj+fIqd02Ng7xS0Pv2Qhqb10YkpHcErFF/Tds3xFFePkrJehwB2xuw0bzNRrwiHqI5DWxNNI
 MlirWNoN08Vh9wFhaUeZjAbrP90I3anCb/dWZWldMwN3OyWvpjlJ7iMIEImhs76m22Tw7watM
 cDdms6q0CSnvW5qfYdVGBFp+Z9f/mL+Md0JkfhChdVwlKGL58lXznRhAR0jpuX822Wq8lIlvD
 /BtZmFZmCtRom/vQlXHmvybaRJ+tJGDTsL97mIgeToKEi0n0/CYbYedAUF+4hOdfoF4x5Ypma
 lkkGbi1D2bTgvgv4ZkO5lkBvp3hB6qZ0VMqz8zF3njgX2ZMuLyN0uN6F/JhTY+9ipBwGUPhUj
 8sbu/dip6cA5Wrgt5yirYp1KfMDtByCyGvA18fYrAiSvGBVkd1DZWjxlxvY6bA4RK1/E2VMeA
 5363wzwpX0BimQFiiK5y+nNJdCyb4Q7aKopPbEEOclz2Re5Qq+fCjoOx1aKLqwjFrRRMZZuys
 8f1TLV4OEtcoyzF83sDqWqbJvpVDtjmIMzKHWAOmq3hdbvm7FVnmZ8npKbz8kdC84FBPVlQbv
 5ovzkwjDmG8bFoD4hqW/yTIJEqn+V9BILdRaw4win4TudazaHQJyz4WUllqpPXmgOAzjmgGCb
 OfIP4bfnxm+RX5bhhYFZBDrteDfYJp9QyVIAmCSWIwHCl9Uar7WAqKXBd1xh9ywGokPDVK32F
 kcDJ1xR4gVw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Mon, 3 Dec 2018, Johannes Sixt wrote:

> The text body of section Behavioral Differences is typeset as code,
> but should be regular text. Remove the indentation to achieve that.
> 
> While here, prettify the language:
> 
> - use "the x backend" instead of "x-based rebase";
> - use present tense instead of future tense;
> 
> and use subsections instead of a list.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---

The changes look sensible to me.

Thanks,
Dscho

> Cf. https://git-scm.com/docs/git-rebase#_behavioral_differences
> 
> I actually did not test the result, because I don't have the
> infrastructure.
> 
> The sentence "The am backend sometimes does not" is not very useful,
> but is not my fault ;) It would be great if it could be made more
> specific, but I do not know the details.
> 
>  Documentation/git-rebase.txt | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 80793bad8d..dff17b3178 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -550,24 +550,28 @@ Other incompatible flag pairs:
>  BEHAVIORAL DIFFERENCES
>  -----------------------
>  
> - * empty commits:
> +There are some subtle differences how the backends behave.
>  
> -    am-based rebase will drop any "empty" commits, whether the
> -    commit started empty (had no changes relative to its parent to
> -    start with) or ended empty (all changes were already applied
> -    upstream in other commits).
> +Empty commits
> +~~~~~~~~~~~~~
> +
> +The am backend drops any "empty" commits, regardless of whether the
> +commit started empty (had no changes relative to its parent to
> +start with) or ended empty (all changes were already applied
> +upstream in other commits).
>  
> -    merge-based rebase does the same.
> +The merge backend does the same.
>  
> -    interactive-based rebase will by default drop commits that
> -    started empty and halt if it hits a commit that ended up empty.
> -    The `--keep-empty` option exists for interactive rebases to allow
> -    it to keep commits that started empty.
> +The interactive backend drops commits by default that
> +started empty and halts if it hits a commit that ended up empty.
> +The `--keep-empty` option exists for the interactive backend to allow
> +it to keep commits that started empty.
>  
> -  * directory rename detection:
> +Directory rename detection
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -    merge-based and interactive-based rebases work fine with
> -    directory rename detection.  am-based rebases sometimes do not.
> +The merge and interactive backends work fine with
> +directory rename detection.  The am backend sometimes does not.
>  
>  include::merge-strategies.txt[]
>  
> -- 
> 2.19.1.1133.g2dd3d172d2
> 
