Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84874C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 12:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636952245C
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 12:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfLEMf2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 07:35:28 -0500
Received: from feynman.df7cb.de ([195.49.152.168]:35872 "EHLO feynman.df7cb.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729240AbfLEMf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 07:35:28 -0500
Received: from msg.df7cb.de (unknown [IPv6:2003:5b:203b:100:7627:eaff:fe52:8e03])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by feynman.df7cb.de (Postfix) with ESMTPSA id 47TFYS4bR6z3Dwp;
        Thu,  5 Dec 2019 13:35:24 +0100 (CET)
Date:   Thu, 5 Dec 2019 13:35:24 +0100
From:   Christoph Berg <myon@debian.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git clone git clone some://url
Message-ID: <20191205123524.GA30724@msg.df7cb.de>
References: <20191119141537.GD18924@msg.df7cb.de>
 <20191204214017.GA195537@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204214017.GA195537@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re: Jonathan Nieder 2019-12-04 <20191204214017.GA195537@google.com>
> > $ git clone git clone some://url
> > fatal: Too many arguments.
> 
> I feel your pain.  Is there an issue tracker post or support ticket
> open for some of these hosting sites to make it do the intuitive thing
> (just copy the URL) instead?

I created one for sf.net now: https://sourceforge.net/p/forge/feature-requests/721/

Christoph
