Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 120051FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 20:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762024AbcINU3N (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 16:29:13 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.26]:35643 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758268AbcINU3M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 16:29:12 -0400
Received: from [84.131.240.40] (helo=sandbox)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bkGns-00013N-Mz; Wed, 14 Sep 2016 22:29:08 +0200
Date:   Wed, 14 Sep 2016 22:29:07 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Thomas =?iso-8859-1?Q?B=E9tous?= <th.betous@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug Report: "git submodule deinit" fails right after a clone
Message-ID: <20160914202907.GD7613@sandbox>
References: <CAPOqYV+C-P9M2zcUBBkD2LALPm4K3sxSut+BjAkZ9T1AKLEr+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPOqYV+C-P9M2zcUBBkD2LALPm4K3sxSut+BjAkZ9T1AKLEr+A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 30, 2016 at 01:45:56PM +0200, Thomas Bétous wrote:
> Are you able to reproduce this problem?

No. I just did a clone and an immediate deinit afterwards and no error.
Maybe you can provide a script to reproduce? Which System was this on?

Cheers Heiko
