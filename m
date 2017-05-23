Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C2081FF30
	for <e@80x24.org>; Tue, 23 May 2017 07:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966454AbdEWHiz (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 03:38:55 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:55429 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933882AbdEWHiy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 03:38:54 -0400
Received: from tigra (unknown [192.168.2.102])
        by hermes.domain007.com (Postfix) with SMTP id 8B194D400C1;
        Tue, 23 May 2017 10:38:47 +0300 (MSK)
Date:   Tue, 23 May 2017 10:38:47 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Konstantin Khomoutov <kostix+git@007spb.ru>,
        Rabii Elguermouni <rabii.elguermouni@gmail.com>,
        git@vger.kernel.org
Subject: Re: Git 2.13 silent install
Message-ID: <20170523073846.vxah6adsnsvwbjvk@tigra>
References: <CBD45BD0-623B-4301-B02A-5051CDAC1569@gmail.com>
 <20170522135816.cufdxxadsjdhge6p@tigra>
 <alpine.DEB.2.21.1.1705221741170.3610@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1705221741170.3610@virtualbox>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 22, 2017 at 05:41:52PM +0200, Johannes Schindelin wrote:

> > > Just wondering if someone can send me the instructions for an
> > > unattended/silent install for Git 2.13. 
> > 
> > This guide [1] is outdated but should be applicable (see the new
> > installer file [2] and its "[Components]" section for an up-to-date list
> > of components to select).
> > 
> > 1. https://github.com/msysgit/msysgit/wiki/Silent-or-Unattended-Installation
> > 2. https://github.com/git-for-windows/build-extra/blob/master/installer/install.iss
> 
> Please note that [1] was copy-edited to Git for Windows 2.x' wiki:
> 
> https://github.com/git-for-windows/git/wiki/Silent-or-Unattended-Installation

Very good!

For some reason googling for git+for+windows+silent+install did not turn
up the new page but rather the old one, so I have falsely assumed it got
lost in transit.  Good to know it wasn't :-)

