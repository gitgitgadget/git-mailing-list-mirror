Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF4111F453
	for <e@80x24.org>; Mon, 18 Feb 2019 20:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfBRUh0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 15:37:26 -0500
Received: from mout.gmx.net ([212.227.15.18]:46699 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbfBRUh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 15:37:26 -0500
Received: from [192.168.0.171] ([37.201.195.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M08ia-1hCXfH3UMO-00uIDL; Mon, 18
 Feb 2019 21:37:19 +0100
Date:   Mon, 18 Feb 2019 21:37:21 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] git-rebase.txt: update to reflect merge now implemented
 on sequencer
In-Reply-To: <20190214202541.21371-1-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1902182136560.45@tvgsbejvaqbjf.bet>
References: <20190214202541.21371-1-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DszdZyflOHG9KZ2Rz5f1OIEOksDyfGfKgz3nsxNogOu1YTw24rO
 CuthXhfDDn06DWw8+ps5HMyc9udf+CwoGFPia/loxA5NhJj/qIBvRaNs+IxaGqke+fZIVDG
 ibaI/tGuTpy4JmNAYGL7QmQoVIcdwZsa6o4RNNIcV/Lf5jk40HmsA7R4kzVrKOlIZbJja3A
 Qyirwr8taI5En+Y7hNyLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZEwJnkiop6k=:FGjANeqr95rcG5NfGK1R1Q
 SXsFioe8qYoW7hVBu4VCjNKQ3sWroVKHWPRG9U0nnl9xez8oLTuR79JfOS47bezl2sX/j+xSg
 JvGPtBRW8xoW5IoVLb79XHxNM8CLOnKVkObN4r0lLkssXG5A1dvyNkCyLXqE9ejyLbZPdHCw+
 Z3kSgUhx/aDpP+kTph+IBJSS5IQ6Rqd75UVuikCrTT8Sj09x/QBWpKtYNpGfrKDG5DWUHLrvZ
 Keub/ZozcJOUvyYWjK5GDk0s6HbonG9raz82YwZ3yXuh7UGwFprICKm+d8SgXoOxq9lihuLHs
 HsDpnErjr1A9cj6GXT7cyJW6qB9OrEbAkFwc/H7PlJw2/CU1CF4cm2GBQMIGEJooCNg3S0EFL
 OLoxJ5BjswizQWfOFGVvNhvyiTVJbcCgZVVieSbJsOFd01I3Dt3x/OaP805I8RHOymK61RMxo
 TiEI4HF0BN/dmng13CHHjagKwPyq9XW07yGqZGCXaQy60uEUbjOZxet6KzIxPR3LpVOrotcd5
 UvKjW/i+jRD9NY+cYINonH6kefRJ2OplJ4sRV7V6G+NVon1U9ws4gEaT01Dino2KyoRSCRkd+
 MQhLbSz9/rdt0hpUdWLPvov5WlFKVAqngpk4cjzU75PWep6NXHOdrExgKJAXjc+BTqW8/8k8R
 G7wy5i/eYqOdqt4Ondudoq9Zhyvp9Fs/KexY2YripHcALRvLFIvDUUV8y3VvWPz483D3aHrFC
 exTGNerNzF0x26m3o9CqtZg8+V6A1GdXGpYdshC+Wjc7Pj4fU880HYFhZ1JDbuzReVSxQiD8Q
 W5yxk4PKAsFF2940UhZ3A7vRAUxnr8FHXZfokcZyZmDs0e1qzFVlgilECneF/RLQ936ejp+bZ
 c/S2HG1UvHzhotpNvyy0+mxk7zJD4LY1jDA83T1QivWN/qxI+adHJftLhMOvBRmxDBbRZYQNp
 nqiQvxDnPQA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 14 Feb 2019, Elijah Newren wrote:

> Since commit 8fe9c3f21dff (Merge branch 'en/rebase-merge-on-sequencer',
> 2019-02-06), --merge now uses the interactive backend (and matches its
> behavior) so there is no separate merge backend anymore.  Fix an
> oversight in the docs that should have been updated with the previous
> change.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>

ACK,
Dscho

> ---
>  Documentation/git-rebase.txt | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index daa16403ec..619303adbc 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -554,8 +554,6 @@ commit started empty (had no changes relative to its parent to
>  start with) or ended empty (all changes were already applied
>  upstream in other commits).
>  
> -The merge backend does the same.
> -
>  The interactive backend drops commits by default that
>  started empty and halts if it hits a commit that ended up empty.
>  The `--keep-empty` option exists for the interactive backend to allow
> -- 
> 2.21.0.rc0.269.g1a574e7a28
> 
> 
