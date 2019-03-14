Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E8F820248
	for <e@80x24.org>; Thu, 14 Mar 2019 09:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfCNJTH (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 05:19:07 -0400
Received: from ozlabs.org ([203.11.71.1]:51181 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbfCNJTH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 05:19:07 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 44Kjnj2WJkz9s4V; Thu, 14 Mar 2019 20:19:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1552555145; bh=nxsM6zDjqo/1AdVfYndCYSvc0uecruGW4N+Kpn2ItdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IPcgWXAH8BBQoPQbfHYIAii9GYFEkWMTmE30ls2CpRu9BZukBtKuTlBmMUlsjC9pb
         PbHdJdr8jB4/L6GuV5HWXrlf4MMyctKSmdyfhYjMEwNaImeP9yxuBTIGldKqDdVRiR
         DVrs/SW9h79hzyk8GbX+LRZOoyUaASENEpHnOyULTAUPdGPtHVKOOx0pVu8HFYorDD
         EcIeipZJKoWHOT+xLP1AKOpVQJZ8FDbm8kdw8N3x1A2sxfg0A2S6fMGT4+5uV5YNPR
         opgGkwFGmJdzaIhWxwjhOqg0D+APOnGngzZCLghUy6LY9Qp8q48/gxRpRCabOWApSE
         P5tq+kQ6ZTkcw==
Date:   Thu, 14 Mar 2019 20:19:02 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Alexander Shopov <ash@kambanaria.org>
Cc:     git@vger.kernel.org
Subject: Re: Update of Bulgarian translation of gitk
Message-ID: <20190314091902.GB19416@blackberry>
References: <20190313120646.14248-1-ash@kambanaria.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313120646.14248-1-ash@kambanaria.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 01:06:32PM +0100, Alexander Shopov wrote:
> 
> 
> Hello all,
> I am resending the update of Bulgarina translation of Gitk that I last sent here:
> on 4 of March: https://marc.info/?l=git&m=155169580131311&w=2
> Any idea why it is not getting merged? Perhaps I missed something or Paul Mackerras,
> maintaining gitk, is busy?

I have been busy with work and life generally.  I applied your patch
and pushed it out.  Thanks for your patience.

Paul.
