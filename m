Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B10A220286
	for <e@80x24.org>; Sat, 16 Sep 2017 12:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbdIPMFd (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 08:05:33 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:42939 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbdIPMFd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 08:05:33 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Sat, 16 Sep 2017 14:05:32 +0200
  id 0000000000000074.0000000059BD138C.00003415
Date:   Sat, 16 Sep 2017 14:05:31 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Are the 'How to' documents present as man pages?
Message-ID: <20170916120531.qbtffov6gwjbom3m@ruderich.org>
References: <1505538043.21890.4.camel@gmail.com>
 <20170916085402.pc2vnimymien355n@ruderich.org>
 <1505562455.23153.3.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <1505562455.23153.3.camel@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 16, 2017 at 05:17:35PM +0530, Kaartic Sivaraam wrote:
>> References to other man pages generally use round brackets, for
>> example git-merge(1).
>
> I didn't know they had different meanings for different brackets in man
> pages. [snip]

Man pages in general use only round brackets to refer to another
man page with the given section (like stat(1) or stat(2)).

Square brackets have no special meaning, but are useful for
references like URLs.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
