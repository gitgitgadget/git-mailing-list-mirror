Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEDBC1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 15:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750933AbeFYP3Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 11:29:25 -0400
Received: from mail.vm.ouaza.com ([212.83.178.2]:47544 "EHLO mail.vm.ouaza.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750792AbeFYP3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 11:29:25 -0400
Received: from x260-buxy.home.ouaza.com (133-218-190-109.isp.overthebox.ovh [109.190.218.133])
        by mail.vm.ouaza.com (Postfix) with ESMTPSA id B646020081;
        Mon, 25 Jun 2018 17:28:17 +0200 (CEST)
Received: by x260-buxy.home.ouaza.com (Postfix, from userid 1000)
        id 945518A2F88; Mon, 25 Jun 2018 17:29:22 +0200 (CEST)
Date:   Mon, 25 Jun 2018 17:29:22 +0200
From:   Raphael Hertzog <hertzog@debian.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, jn.avila@free.fr
Subject: Re: [PATCH 2/2] i18n: bisect: mark two supplementary strings for
 translation
Message-ID: <20180625152922.GB27849@home.ouaza.com>
References: <20180621142742.28575-1-hertzog@debian.org>
 <20180621142742.28575-3-hertzog@debian.org>
 <CACsJy8DcXo3HURwZXbvGYjrJpfku+RXESP=ErLzYj3NhNabRTQ@mail.gmail.com>
 <20180621152145.GA29912@home.ouaza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180621152145.GA29912@home.ouaza.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Virus-Scanned: clamav-milter 0.99.4 at mail
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 21 Jun 2018, Raphael Hertzog wrote:
> On Thu, 21 Jun 2018, Duy Nguyen wrote:
> > Nice. There's another string in bisect_common() that should also be
> > translated: "revision walk setup failed". Maybe you can mark it too?
> 
> Sure. A new version of the second patch is attached.

I haven't had any other feedback. Is there anything else that I should do
to get my changes merged?

Cheers,
-- 
Raphaël Hertzog ◈ Debian Developer

Support Debian LTS: https://www.freexian.com/services/debian-lts.html
Learn to master Debian: https://debian-handbook.info/get/
