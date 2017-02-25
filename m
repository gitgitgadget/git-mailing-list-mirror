Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CC6C201A9
	for <e@80x24.org>; Sat, 25 Feb 2017 00:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbdBYAGu (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 19:06:50 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:40838 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbdBYAGt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 19:06:49 -0500
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1chPsr-0002Wg-Dj; Sat, 25 Feb 2017 00:06:45 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22704.51861.339612.258582@chiark.greenend.org.uk>
Date:   Sat, 25 Feb 2017 00:06:45 +0000
To:     Junio C Hamano <gitster@pobox.com>, Joey Hess <id@joeyh.name>,
        git@vger.kernel.org
Subject: Re: SHA1 collisions found
In-Reply-To: <22704.50445.435156.883001@chiark.greenend.org.uk>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
        <22704.19873.860148.22472@chiark.greenend.org.uk>
        <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
        <22704.50445.435156.883001@chiark.greenend.org.uk>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ian Jackson writes ("Re: SHA1 collisions found"):
> The idea of using the length is a neat trick, but it cannot support
> the dcurrent object name abbreviation approach unworkable.

Sorry, it's late here and my grammar seems to have disintegrated !

Ian.
