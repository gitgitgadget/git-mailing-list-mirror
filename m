Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	URIBL_DBL_ABUSE_BOTCC shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55F7E201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964807AbdBQWjG (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:39:06 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:9738 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935007AbdBQWjF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:39:05 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id erB8cji9uHGLwerB8culLJ; Fri, 17 Feb 2017 22:39:03 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8
 a=U3RR0ZRjI9g4YIMTfcQA:9 a=QEXdDO2ut3YA:10 a=VlZU0XKO32wA:10
 a=Bn2pgwyD2vrAyMmN8A2t:22
Message-ID: <0C79F8D069F240A6A2C5BF7D7243122F@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jeff King" <peff@peff.net>,
        =?utf-8?Q?Gr=C3=A9goire_PARIS?= <postmaster@greg0ire.fr>
Cc:     <git@vger.kernel.org>
References: <ebd661c3-7d99-54d2-dda9-09c4a76cfe93@greg0ire.fr>        <20170217204411.2yixhuazgczxmmxa@sigill.intra.peff.net> <2bae8d8a-f0bf-fa8b-8ce4-6880d3490b43@greg0ire.fr>
Subject: Re: Re: dotfiles in git template dir are not copied
Date:   Fri, 17 Feb 2017 22:39:03 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=response
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfKR5X0V58GRhB9iGOc2pw3F/c2uShb+ljlTtNltT0a3HHMGgac4UMt/vGo7NNUFrkYK5jdKN4I0K1qlFrBm6BO6AXnsXOzl80QvCSim9LEZdzeE7qwns
 9JJHv83+Yr8h1YRNIZhmijFu41PORSFExvlWLHKZmQ8N7v0KPG6eYwBId/xr4HspGE2NRyfbi6m/2BbP+gSnZ1mAxY+2pshsl138I2b4NPZEq0xujGIavdQm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Grégoire PARIS" <postmaster@greg0ire.fr>
> > You could, for example, have your template directory itself be a git
> repository.
>
> I can and I do and indeed, that might be the reason behind this.
> I made a PR to document this : https://github.com/git/git/pull/325
>
While the PR is a simple one line change to the documention, the patch 
should be submitted to the list.
See Documenation/SubmittingPatches

Don't forget to Sign Off your patch (see the Developer's Certificate of 
Origin section).
--
Philip 

