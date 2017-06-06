Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66EA920D09
	for <e@80x24.org>; Tue,  6 Jun 2017 07:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbdFFHMi (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 03:12:38 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:42909 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdFFHMi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 03:12:38 -0400
Received: from tigra (unknown [192.168.2.102])
        by hermes.domain007.com (Postfix) with SMTP id 98CFED400AD;
        Tue,  6 Jun 2017 10:12:36 +0300 (MSK)
Date:   Tue, 6 Jun 2017 10:12:36 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     Hector Santos <winserver.support@winserver.com>
Cc:     git@vger.kernel.org
Subject: Re: Git "Keeping Original Dates"
Message-ID: <20170606071236.x72rag2brfnxi7ii@tigra>
References: <5935C999.5060801@winserver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5935C999.5060801@winserver.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 05, 2017 at 05:14:01PM -0400, Hector Santos wrote:
> I'm implementing GIT.  If there an option or compile/version that "keep"
> file timestamps?

Just in case you've missed it, there's an explanation of why Git behaves
the way it does in this regard [1].

1.  https://git.wiki.kernel.org/index.php/Git_FAQ#Why_isn.27t_Git_preserving_modification_time_on_files.3F

