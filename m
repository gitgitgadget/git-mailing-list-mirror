Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2992E1F954
	for <e@80x24.org>; Fri, 17 Aug 2018 23:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbeHRC0D (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 22:26:03 -0400
Received: from ol.sdf.org ([205.166.94.20]:57279 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbeHRC0C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 22:26:02 -0400
Received: from sdf.org (IDENT:aedifex@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id w7HNKOgI003232
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Fri, 17 Aug 2018 23:20:24 GMT
Received: (from aedifex@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id w7HNKOWh012174;
        Fri, 17 Aug 2018 23:20:24 GMT
Date:   Fri, 17 Aug 2018 23:20:24 +0000
From:   Tacitus Aedifex <aedifex@SDF.ORG>
To:     git@vger.kernel.org
Cc:     batolettre@gmail.com
Subject: Re: git-bug: Distributed bug tracker embedded in git
Message-ID: <20180817232024.GA25871@SDF.ORG>
References: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I really like this idea. I've often wanted an integrated bug database like 
this. My solution has always been to have a subrepo storing bug reports and 
coments in .txt files and then using bash porcelain scripts to make a git-like 
interface. I think I like this better. My only nit is Go. That makes me sad.  
Someone should re-implement this in C or Rust.

//tæ
