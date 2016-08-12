Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 247701F859
	for <e@80x24.org>; Fri, 12 Aug 2016 17:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbcHLRrg (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 13:47:36 -0400
Received: from crazybrake.spb.ru ([188.134.13.200]:33038 "HELO ddg.spb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752363AbcHLRrf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 13:47:35 -0400
Received: (qmail 14958 invoked from network); 12 Aug 2016 17:47:31 -0000
Received: from mail.metrotek.spb.ru (HELO srv3.metrotek.spb.ru) (89.110.34.174)
  by ddg.spb.ru with SMTP; 12 Aug 2016 17:47:31 -0000
Received: (qmail 12988 invoked from network); 12 Aug 2016 17:47:30 -0000
Received: from workplace.ddg (192.168.222.74)
  by srv3.ddg with SMTP; 12 Aug 2016 17:47:30 -0000
Received: (qmail 28825 invoked by uid 65618); 12 Aug 2016 17:47:30 -0000
Date:	Fri, 12 Aug 2016 20:47:30 +0300
From:	Ivan Oleynikov <io@metrotek.spb.ru>
To:	git@vger.kernel.org
Cc:	apenwarr@gmail.com
Subject: Re: [PATCH] git-subtree: compare file names by absolute paths
Message-ID: <20160812174730.GA28761@metrotek.spb.ru>
References: <20160812154942.GA27294@metrotek.spb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160812154942.GA27294@metrotek.spb.ru>
Organization: STC Metrotek, St.Petersburg
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.0.3
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

quote on Fri, Aug 12, 2016 at 06:49:42PM +0300 (Ivan Oleynikov):

BTW, this patch should be applied to `maint` branch. The similar change also
works if applied to master (patch for master must be a bit different).

-- 
Ivan Oleynikov
STC Metrotek
St.Petersburg
