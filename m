Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 28412 invoked by uid 107); 4 Sep 2014 07:41:24 -0000
Received: from Unknown (HELO cloud.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Sep 2014 03:41:24 -0400
Received: (qmail 29444 invoked by uid 102); 4 Sep 2014 07:41:06 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by cloud.peff.net (qpsmtpd/0.84) with ESMTP; Thu, 04 Sep 2014 02:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756795AbaIDHkV (ORCPT <rfc822;peff@peff.net>);
	Thu, 4 Sep 2014 03:40:21 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:47725 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756196AbaIDHkS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Sep 2014 03:40:18 -0400
Received: by mail-wg0-f48.google.com with SMTP id n12so9681649wgh.7
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 00:40:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:mime-version:subject:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BBhGYAnH2ucj2XDASsDie8fnPnUt/K8Jcs2iHdImCl8=;
        b=X3IsUVL8jWYD4ORtLmd6gGRWioggBZWP/6+lUoNleGZ4vjsUHg69qrtcOZ3LsgBH5D
         qCFgY9n9T/GY3ptd3X2RWbx1n4a/iWtmhbs5CtkI0bZvQy174Hkg3VLFwYltblqJCegh
         B+hIr1TbtmMN+8j00tcFYGIzgd0LcVkN79K/rm7GYieNV3hz5OlDQ3NZSKnT3W/nVD/k
         pS9PWshMk/jKJ0/+db8kqpNe9PYUfAF1PsTlo6DP38td0aXI4gi8iH5tptphs6suKU3M
         SLzI7vEZYWhZB4vdJGOsdFVfF29Yu7u+0l0yC4GjtzoB8/lSjUYceDM5G/UfDSN7mDD1
         uygA==
X-Received: by 10.194.108.41 with SMTP id hh9mr3646615wjb.68.1409816416621;
        Thu, 04 Sep 2014 00:40:16 -0700 (PDT)
Received: from [10.69.52.109] ([90.216.134.196])
        by mx.google.com with ESMTPSA id o3sm431722wiy.18.2014.09.04.00.40.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 04 Sep 2014 00:40:15 -0700 (PDT)
From:	Luca Milanesio <luca.milanesio@gmail.com>
X-Google-Original-From:	Luca Milanesio <Luca.Milanesio@gmail.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: Next Git conference or meeting
In-Reply-To: <20140903205957.GA28644@peff.net>
Date:	Thu, 4 Sep 2014 08:40:13 +0100
Cc:	Shawn Pearce <spearce@spearce.org>,
	Christian Couder <christian.couder@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>, git <git@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <3D92DC6D-DB97-4215-99FB-F99B913838D1@gmail.com>
References: <CAP8UFD1Jzy2jzRaFh35=y1yCJcMHKSkXbSXp1SuBL2R2bQAJqQ@mail.gmail.com> <1A6AAC8B-0C82-4296-B1C8-BF0739A28A80@gmail.com> <20140902112117.GB5049@thunk.org> <20140902135147.GC6232@thunk.org> <CAP8UFD3x1Pm-+0GF+2CEFkZ34XDzZ95Wu0boPgGocE_8T7uk9g@mail.gmail.com> <CAJo=hJs-wvT4fPA0Ad0tuOjBth0aRzbEFX6pu7N8Uq4TdToZgw@mail.gmail.com> <20140903205957.GA28644@peff.net>
To:	Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It would be nice however for the 10th anniversary having a new "Git-Together" again as the old times at Google's in Mountain View CA.
Paris however is an attractive option for me personally (2h train from my doorstep), better than Seattle for sure ;-)

Luca.

On 3 Sep 2014, at 21:59, Jeff King <peff@peff.net> wrote:

> On Wed, Sep 03, 2014 at 10:15:15AM -0700, Shawn Pearce wrote:
> 
>> I hadn't realized Git is turning 10 next year. Just been too busy
>> using Git to pay attention to its upcoming anniversary. Let me talk to
>> some folks at Google and see if we can organize something here in
>> Mountain View, or help the LinuxFoundation sponsor something.
> 
> Christian mentioned that he talked to some GitHub folks at LinuxCon.
> Those folks have also started thinking about things. :)
> 
> Things are still very tentative at this point, but I think they are
> considering something like the Git Merge conference we did earlier, and
> doing it in June in Europe (maybe Paris). I know they were going to
> reach out to Linux Foundation folks to try to jointly plan something,
> but I don't know if that has happened yet.
> 
> So it seems there are a lot of different people who are all potentially
> interested in planning or taking part, and they should all be talking to
> each other. :)
> 
> -Peff

