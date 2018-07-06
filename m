Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2259E1F6AC
	for <e@80x24.org>; Fri,  6 Jul 2018 12:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932842AbeGFM1B (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 08:27:01 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:42852 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932657AbeGFM1A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 08:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1530880223; bh=FBE4oxACtYhIb9RUPrZNTT+2Dm+jW5Z+TsrvgV9nwCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=QEbFSVb6Bcd5SPNNduIol1k7sYc9lwTPb18PXDsHLZyNFSwoBG7IShzDXluAysy7I
         b+LGCdTjEXmXSGmBH61Q71IFGBeraAHmpDl9cQyYG2xM4H6J/LkCLoYB6Cd8QGyOZ+
         1Vboy1fOvxAbgAWqhxSzMAhjK1C+ao9oKcEoFW+4=
Date:   Fri, 6 Jul 2018 08:26:58 -0400
From:   Drew DeVault <sir@cmpwn.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Automatic transfer encoding for patches
Message-ID: <20180706122658.GB9255@homura.localdomain>
References: <20180706022357.739657-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706022357.739657-1-sandals@crustytoothpaste.net>
X-GNU:  Terry Pratchett
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Overall this series looks good. Thanks for putting the patches together!
