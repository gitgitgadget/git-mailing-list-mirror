Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A30501F403
	for <e@80x24.org>; Thu, 14 Jun 2018 20:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755470AbeFNUei (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 16:34:38 -0400
Received: from smtprelay06.ispgateway.de ([80.67.18.29]:33455 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755438AbeFNUeh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 16:34:37 -0400
Received: from [88.130.56.254] (helo=book.hvoigt.net)
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1fTYlu-0005HF-Gv; Thu, 14 Jun 2018 22:23:06 +0200
Date:   Thu, 14 Jun 2018 22:23:05 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, kaartic.sivaraam@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH] t5526: test recursive submodules when fetching moved
 submodules
Message-ID: <20180614202305.GB2686@book.hvoigt.net>
References: <20180614173107.201885-1-sbeller@google.com>
 <20180614173730.205646-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614173730.205646-1-sbeller@google.com>
User-Agent: Mutt/1.9.0 (2017-09-02)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 14, 2018 at 10:37:30AM -0700, Stefan Beller wrote:
> The topic merged in 0c7ecb7c311 (Merge branch 'sb/submodule-move-nested',
> 2018-05-08) provided support for moving nested submodules.
> 
> Remove the NEEDSWORK comment and implement the nested submodules test as
> the comment hinted at.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Looks good to me.

Cheers Heiko
