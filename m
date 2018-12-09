Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 370BE20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 19:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbeLITlT (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 14:41:19 -0500
Received: from mout.gmx.net ([212.227.15.18]:34167 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbeLITlT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 14:41:19 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M243n-1hL0Ta48Jn-00u513; Sun, 09
 Dec 2018 20:41:14 +0100
Date:   Sun, 9 Dec 2018 20:41:15 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Kyle Meyer <kyle@kyleam.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] rebase docs: drop stray word in merge command
 description
In-Reply-To: <20181208231541.1341999-1-kyle@kyleam.com>
Message-ID: <nycvar.QRO.7.76.6.1812092040320.43@tvgsbejvaqbjf.bet>
References: <20181208231541.1341999-1-kyle@kyleam.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sAueRmLvkfUYatl6NQbGuT/jROE4cVwRKiZPz0VrGaxazgEp6Cy
 f+73dz7K3GaGWB/6dBH5VU347mPsA1clUZEAStfqEh1TX+M8nWNlBgSxE4uP014K+o3VpfH
 75y9Pa/xJ2eIhqLSxwDoSINfFuZD4IO2urrjZnHWOXoOKZ1Glgg9+OLGRoVwxbywp1agmBD
 meJNIShi/rhL9HmP5YoYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mdOjES9OUOo=:0hYmH7U2VGA+saP4GFV/3I
 1zH0y5F2SuE//HYFXe0SgPJQt5cdvTW4RxtPcNw4n3YxkE6apJu2HKBvo4iAelHN/cq0CdhEs
 6blbBjOxB73hPZV57DF2Bv8oYpSXTfvigq7KOIdvoxiSS+buHP80WvdPBkFbRE8E12UPEvGV0
 kqljdGnWcmby8qhWjh9zYgmk547Ii8Ltfdy1ZuHq3VCKNt5tZepN9vHXX5iVFidMR7luDB3Aw
 VHX8YVtroCdr0SQ1CXLnKw1X8hZG6zPde34CiDhXG8VXcLTkk5cyK7NA2dLrNYz3DUK8r/Jvd
 qxe4uS/1RFrzyPnHDRQDQx0proZ0A0rVom3JZ5pb0OELbJtJLiTizIUI7sZtpti3JH1/84GNQ
 5DxTEcQ19yNs8kzdn2Y7+RS7SPgaZ3mEliWdr63QJjUU+J29WOu6hV8rXpmkBiLzcmMnNCHZI
 jFHPz8qGvLP5ii8yHeKGA7fd06wBuQx392cdHo78RBL1kO54f5AgrOlJjTtXmhuaXIZ/1ulTk
 B0pBmZX+LXeC/4cRfmyxv5Bb+We+viM9iPFZPmO5k3Qo7mW4Cs9dvoZ0Wse1MfSGbwY5BxB0Q
 NKGw7F0AWytSnOXijaCShEKhbUn0stckfkFQuAquCtWVtUB5vdsXoL1/TdPq8AaYnCD+liqCB
 jA+vWKbrHAXxServSLDKUUo0xTFUqSiO9/1yEfi9P1FFO4r16I7hJaaUshtYSQ1OjTH2TzOIM
 nAJxRjMXil7kpBwMCdkw5YnG98OQZGhpLfH/2u7VncJrBSo+5wLljmJIiOKYJdoyE9xU/yrCG
 /1XIfqP1dG6h2WuQ6RvFZ5MPS4PDiJGhbfjJoAqr+L7oiwSj/IiwNbW10psric0uIyfxUmPNt
 fTfsvBafDOXXzFC2rAQM7UnEyB0hIzV7GyUeeh1+VPsRFYMHIJV8gBsKayKgqRq1YgBokFByI
 go6ILiyQ3OA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kyle,

On Sat, 8 Dec 2018, Kyle Meyer wrote:

> Delete a misplaced word introduced by caafecfcf1 (rebase
> --rebase-merges: adjust man page for octopus support, 2018-03-09).
> 
> Signed-off-by: Kyle Meyer <kyle@kyleam.com>

ACK.

Too bad this did not make it into v2.20.0, but at least it can make it
into a future version.

Thanks,
Johannes

> ---
>  Documentation/git-rebase.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index dff17b3178..2ee535fb23 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -979,7 +979,7 @@ when the merge operation did not even start), it is rescheduled immediately.
>  
>  At this time, the `merge` command will *always* use the `recursive`
>  merge strategy for regular merges, and `octopus` for octopus merges,
> -strategy, with no way to choose a different one. To work around
> +with no way to choose a different one. To work around
>  this, an `exec` command can be used to call `git merge` explicitly,
>  using the fact that the labels are worktree-local refs (the ref
>  `refs/rewritten/onto` would correspond to the label `onto`, for example).
> -- 
> 2.19.2
> 
> 
