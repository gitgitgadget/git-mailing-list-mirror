Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,URIBL_DBL_SPAM shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605751F453
	for <e@80x24.org>; Tue,  5 Feb 2019 09:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfBEJRB (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 04:17:01 -0500
Received: from mout.gmx.net ([212.227.17.20]:53703 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfBEJRB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 04:17:01 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lx5hl-1hAZFP0NAn-016c1Z; Tue, 05
 Feb 2019 10:16:46 +0100
Date:   Tue, 5 Feb 2019 10:16:48 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     William Hubbs <williamh@gentoo.org>
cc:     git@vger.kernel.org, chutzpah@gentoo.org
Subject: Re: [PATCH v5 1/1] config: allow giving separate author and committer
 idents
In-Reply-To: <20190204184850.10040-2-williamh@gentoo.org>
Message-ID: <nycvar.QRO.7.76.6.1902051016190.41@tvgsbejvaqbjf.bet>
References: <20190204184850.10040-1-williamh@gentoo.org> <20190204184850.10040-2-williamh@gentoo.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:C6nRbkPYmw1tuzgQ+vzTPn6Th4+GXgiURNW44A7V+UfmuKdYuVj
 lN2G54wZRbLS3NbHxpHn5A8KGqR39Hye45OgIRv40P3mMbLVoDYvu6JvgHMn/WowIvxvhS/
 uvHlhRsNwoHFieT9pFs8vT6Pz1rbiQXllgY46uHa28BTXTIIoQklyhqZQe5W2C0RhpmVMns
 5MNGjnutwK4SgytCtqVuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T0qR0ckOJUo=:hOmwrrkQm7GZwxuEDBIVdc
 bwPCtioyuaxaUB3TZUg1uY7Y2wD0w2ItnPO4DEK9yYn/7swdnkyPoyA89YJ+GYjd7r9KWjYgG
 JysFrwsvkWMez1M2syTyGuAjylXI3JaEDF/wnR8jQUbCsSzOr/SKKaMnFKyl3TYiRS2EJXawD
 E6RVyw8UWxauvWCcMxZxvVDtiFGS9kVSzRZCtqI0ABq4oDWWV+LBgJ/mrHd0Bxob2HDTbg0/6
 kC9XyVH3TA171T8t18aK43A2A4H8Ml0PYC+gD1JY9cecDHaBYX/hVMGk8sfngsFIXV0jFaIZM
 taiVhtk6tZ+a426ByjpNdyF4ByOb1v7bPN0ydGNjoVZssXhSMh4jEpBjPHZRmk49K7QM5WTWJ
 yKh4lTdX8dvynFhI9qT410ar6iG9bbFoibj/4DZ7Io3L6LgReKSHW8/4KGTQoGAGWB5kK/Cyy
 ZSoG9cFwhI0nW4N0n7lPkeOwun8BSaw97s8+Znd8ciAePFYbwPoJhjoSKgaB37TnzYCQQg7o3
 gSRdJSaxkUjAf6KYFd1XsK/9LBOsANrnMMqcKi1IerTpeCe8ULYgtjoZgLiaOaVg5LObNmY9U
 SnSO9yxDdW8opHLIwinAuV+wrnon/StOjDSGLfYlF+mDe13g5Qkzi4cQTJWaeE6ADVK5fJwRF
 EVeXzUgRxcI3lAvCjiXWhS9G4MCnrIVzGWcy/Rfm3PRcp3TKY0AJAdZXWCEGaT6vB4xd2jQ05
 nwDE9jmHOC4XgYHB9fSUrKfOGWWIgdqZEKNNrA/7so9waYDhH+lnUrvqSfxZqarD99dDZV8P3
 etQ5NzvIW1TmXemsafZUwkS7vrY54/qWd6SOCJHWmhuIVE4lOYv1fdFdqqFDSCnDQtMl3yzgC
 WV40T4YIkktr1QHqnrAzXnUgvoAtgCSURZLmmdzkLKgclhg5KRVFp3xKqtui/OkS+enIlMYio
 xaSCXjfOFiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi William,

On Mon, 4 Feb 2019, William Hubbs wrote:

> diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
> index b5b2ba1199..0557cbbceb 100644
> --- a/Documentation/config/user.txt
> +++ b/Documentation/config/user.txt
> @@ -1,12 +1,19 @@
> -user.email::
> -	Your email address to be recorded in any newly created commits.
> -	Can be overridden by the `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_EMAIL`, and
> -	`EMAIL` environment variables.  See linkgit:git-commit-tree[1].
> -
>  user.name::
> -	Your full name to be recorded in any newly created commits.
> -	Can be overridden by the `GIT_AUTHOR_NAME` and `GIT_COMMITTER_NAME`
> -	environment variables.  See linkgit:git-commit-tree[1].
> +user.email::
> +author.name::
> +author.email::
> +committer.name::
> +committer.email::
> +	The `user.name` and `user.email` variables determine what ends
> +	up in the `author` and `committer` field of commit
> +	objects.
> +	If you need the `author` or `committer` to be different, the
> +	`author.name`, `author.email`, `committer.name` or
> +	`committer.email` variables can be set.
> +	Also, all of these can be overridden by the `GIT_AUTHOR_NAME`,
> +	`GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_NAME`,
> +	`GIT_COMMITTER_EMAIL` and `EMAIL` environment variables.
> +	See linkgit:git-commit-tree[1] for more information.

Thank you, this looks good to me.

Ciao,
Johannes
