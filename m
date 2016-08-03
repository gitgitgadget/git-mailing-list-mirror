Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A90B120A47
	for <e@80x24.org>; Wed,  3 Aug 2016 15:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344AbcHCPbY (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 11:31:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:51271 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753408AbcHCPbW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 11:31:22 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LdYSM-1amatG0mBu-00ihkX; Wed, 03 Aug 2016 17:22:24
 +0200
Date:	Wed, 3 Aug 2016 17:22:21 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Santiago Torres <santiago@nyu.edu>
cc:	Git <git@vger.kernel.org>
Subject: Re: [OT] USENIX paper on Git
In-Reply-To: <20160803145830.uwssj4uhqfemhr4o@LykOS.localdomain>
Message-ID: <alpine.DEB.2.20.1608031721430.107993@virtualbox>
References: <20160801224043.4qmf56pmv27riq4i@LykOS.localdomain> <20160803145830.uwssj4uhqfemhr4o@LykOS.localdomain>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mqksLuYm2G6Q15jKBeQqp03ZlO0sYNg983yChyCUw1LEcVgyt9j
 SQG/5x5N+eN4JwlYrfepchOC/UeK1YmZZGminRcsXyQxmuL86Xx+Le6R1Gpc9i02yg2lAm/
 kFbvkNFSoeWAG4PBlqINdl48tg7esTXYlOWHjLarwBMS7qQ2CwFCZViqWfY+RS4EmI9eJKP
 CyyKW+jSc/lTzWFyZzcag==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:KN9Zc68RxYQ=:trhGbPqAoiLXsvJV+jWund
 0uC2ztg4EhRGCDSiwGBCQFIh6sZ/9nClv2SXC+qrSls6+vWq75/gCVs81cia3QgUlYsuPnsJ6
 izx3kPYLgRKw2rlLjc6CqDorv4CeXdkpzY7ILu57PNQhMkxfjTtO9SE+YUpCwsRlnW42ykruI
 er5UhIwzXtNfQrT7Qd4NVLCKyUluVh9iQqVaGI8QPl/u9ojuIQkwCDp4PI3qVcchUyG+YhQ0k
 5b5PudP7TvjrnxSgWqVYZY53J+6/jQOUWMu70VyIOY4Pab3dKfvL5KTzxHbDO3ecgRJWgGuRS
 tCVePoFy0ndciLL3EffemdQ2yETyyqEJIUn9DnVUySkuOs85lpr9ooLaM/XTCarD0AMRcEsCA
 U6j9LiYIVnd/WwrwzEwwfz6XVZvliG6d3l0rWPtW3+WZIjBmkPT6cExh262bsh42xkAYsWUVP
 xxRGkkupe9geYSPastCw3b/Wx+JZMfzrzYZZr571uN2rJlMKMgUlKgiGGXWx7MbuTAt498YhR
 1TyMKCWPEAS4GjHCx9LcCZSnqM2al45mIeBT40dAdIs8CL/SGEe83I2YnR2fU69tyCsQxPiaM
 /utoCQtABk2N/4zVtlKX2nE6kh9qyCjRZaZcyQzkYOAVTOt7HLrlSo09Q0gLHvPZLnW01ivTU
 Ej3wBCaDXSWT/ZQ9VV5lYkB95oUcsiWkBlkJR3737/opxmhdD+aJdF0SR+kCwWL6OaklTN7kj
 LVPz/kZ7XDaBtwD8q7CoqojxxlxN7dXL7ZhMNJTzr9Kv7vWg1rdEyC+kQnVNTpfqyrq4SeuMS
 ABThs0o
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Santiago,

On Wed, 3 Aug 2016, Santiago Torres wrote:

> I'm open for feedback and corrections. If anything seems odd imprecise
> to the community, I can make an errata in the presentation (at least).
> I'll also try to work towards making corrections anywhere if possible;
> this is my first publication, so I wasn't sure if it was possible to
> share things before they are published. Thankfully, this is OK in
> USENIX's book. Here's the link:
> http://i2.cdn.turner.com/cnnnext/dam/assets/160730192650-14new-week-in-politics-super-169.jpg

While I had a good laugh, I am wondering whether this is the correct link?

Ciao,
Johannes
