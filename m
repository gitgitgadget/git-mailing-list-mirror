Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B83801F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 21:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754717AbcJTV3y (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 17:29:54 -0400
Received: from ikke.info ([178.21.113.177]:35616 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753336AbcJTV3x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 17:29:53 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 9E709440508; Thu, 20 Oct 2016 23:29:51 +0200 (CEST)
Date:   Thu, 20 Oct 2016 23:29:51 +0200
From:   Kevin Daudt <me@ikke.info>
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [ANNOUNCE] git-log-compact v1.0
Message-ID: <20161020212951.GA4059@ikke.info>
References: <git-log-compact-announce-v1@mackyle-at-gmail-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <git-log-compact-announce-v1@mackyle-at-gmail-com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2016 at 05:13:34PM -0700, Kyle J. McKay wrote:
> 
> The project page with detailed help and many screen shots is located at:
> 
>   https://mackyle.github.io/git-log-compact/
> 
> Alternatively the repository can be cloned from:
> 
>   https://github.com/mackyle/git-log-compact.git
> 
> Or the script file itself (which is really all you need) can be
> viewed/fetched from:
> 
>   https://github.com/mackyle/git-log-compact/blob/HEAD/git-log-compact
> 
> The git-log-compact script should work with any version of Git released
> in the last several years.
> 
> --Kyle
> 
> [1] https://git.github.io/rev_news/2016/10/19/edition-20/

I've packaged up an arch AUR package[1] for it if anyone is interested.

[1]:https://aur.archlinux.org/packages/git-log-compact
