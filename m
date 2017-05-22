Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D845B2023D
	for <e@80x24.org>; Mon, 22 May 2017 13:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933811AbdEVN6T (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 09:58:19 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:59724 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933806AbdEVN6T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 09:58:19 -0400
Received: from tigra (unknown [192.168.2.102])
        by hermes.domain007.com (Postfix) with SMTP id 5ACECD400BD;
        Mon, 22 May 2017 16:58:16 +0300 (MSK)
Date:   Mon, 22 May 2017 16:58:16 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     Rabii Elguermouni <rabii.elguermouni@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git 2.13 silent install
Message-ID: <20170522135816.cufdxxadsjdhge6p@tigra>
References: <CBD45BD0-623B-4301-B02A-5051CDAC1569@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CBD45BD0-623B-4301-B02A-5051CDAC1569@gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 09:55:04AM -0400, Rabii Elguermouni wrote:

> Just wondering if someone can send me the instructions for an
> unattended/silent install for Git 2.13. 

This guide [1] is outdated but should be applicable (see the new
installer file [2] and its "[Components]" section for an up-to-date list
of components to select).

1. https://github.com/msysgit/msysgit/wiki/Silent-or-Unattended-Installation
2. https://github.com/git-for-windows/build-extra/blob/master/installer/install.iss

