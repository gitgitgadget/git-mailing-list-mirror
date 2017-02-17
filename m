Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	URIBL_DBL_ABUSE_BOTCC shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D37E6201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964793AbdBQWtQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:49:16 -0500
Received: from smtp26.services.sfr.fr ([93.17.128.163]:44897 "EHLO
        smtp26.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935084AbdBQWtP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:49:15 -0500
Received: from [192.168.1.57] (220.208.99.84.rev.sfr.net [84.99.208.220])
        by msfrf2603.sfr.fr (SMTP Server) with ESMTP id 852791C001433;
        Fri, 17 Feb 2017 23:49:09 +0100 (CET)
Received: from [192.168.1.57] (220.208.99.84.rev.sfr.net [84.99.208.220])       (using TLSv1
        with cipher ECDHE-RSA-AES128-SHA (128/128 bits))        (No client certificate requested)
        by msfrf2603.sfr.fr (SMTP Server) with ESMTPS;
        Fri, 17 Feb 2017 23:49:08 +0100 (CET)
Subject: Re: dotfiles in git template dir are not copied
To:     Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>
References: <ebd661c3-7d99-54d2-dda9-09c4a76cfe93@greg0ire.fr>
        <20170217204411.2yixhuazgczxmmxa@sigill.intra.peff.net>
        <2bae8d8a-f0bf-fa8b-8ce4-6880d3490b43@greg0ire.fr>
        <0C79F8D069F240A6A2C5BF7D7243122F@PhilipOakley>
Cc:     git@vger.kernel.org
From:   =?iso-8859-1?q?Gr=E9goire?= PARIS <postmaster@greg0ire.fr>
Message-ID: <38a843d6-4755-cc0b-011b-62e3378ddb59@greg0ire.fr>
Date:   Fri, 17 Feb 2017 23:49:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <0C79F8D069F240A6A2C5BF7D7243122F@PhilipOakley>
X-sfr-mailing: LEGIT
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 17/02/2017 à 23:39, Philip Oakley a écrit :
> From: "Grégoire PARIS" <postmaster@greg0ire.fr>
>> > You could, for example, have your template directory itself be a git
>> repository.
>>
>> I can and I do and indeed, that might be the reason behind this.
>> I made a PR to document this : https://github.com/git/git/pull/325
>>
> While the PR is a simple one line change to the documention, the patch 
> should be submitted to the list.
> See Documenation/SubmittingPatches
>
> Don't forget to Sign Off your patch (see the Developer's Certificate 
> of Origin section).
> -- 
> Philip
>
Ok sorry, I'll fix this rightaway!
--
greg0ire
