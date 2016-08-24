Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B9C81F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 23:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755954AbcHXX2U (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 19:28:20 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:24717 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753269AbcHXX2R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 19:28:17 -0400
Received: from PhilipOakley ([92.22.21.109])
        by smtp.talktalk.net with SMTP
        id chagbSBRNcpskchagbLU2u; Thu, 25 Aug 2016 00:28:15 +0100
X-Originating-IP: [92.22.21.109]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=qMCwDsOCRbQP4wxbSmd05g==:117
 a=qMCwDsOCRbQP4wxbSmd05g==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=FBACa5QmktsKF8_JjZ4A:9 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <99BC268995014F88A25852349769FD02@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Dakota Hawkins" <dakotahawkins@gmail.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        "Michael J Gruber" <git@drmicha.warpmail.net>,
        "Duy Nguyen" <pclouds@gmail.com>,
        "git-for-windows" <git-for-windows@googlegroups.com>,
        "Git Mailing List" <git@vger.kernel.org>
References: <alpine.DEB.2.20.1608131214070.4924@virtualbox> <xmqqshu8u0px.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608171507530.4924@virtualbox> <xmqqeg5nbehc.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608181022250.4924@virtualbox> <CACsJy8A3tkMY-iLPCDj9sqB4HpAK_cxsUu5Z7fsGcCQEORyxUg@mail.gmail.com> <alpine.DEB.2.20.1608231553030.4924@virtualbox> <2a6d2230-90ce-0f54-c7ae-a5aa595a2f73@drmicha.warpmail.net> <alpine.DEB.2.20.1608231736180.4924@virtualbox> <alpine.DEB.2.20.1608231758260.4924@virtualbox> <xmqqzio3uw31.fsf@gitster.mtv.corp.google.com> <xmqqa8g3uppx.fsf@gitster.mtv.corp.google.com> <CAG0BQXmmW_0n4OMQVsVQ5+OKbNVpgXmXeExFUOXqY8nH=sg3Jw@mail.gmail.com> <alpine.DEB.2.20.1608241740320.4924@virtualbox> <CAG0BQXmovWAjn8sE=CFGMXguRpEqU3xUbF03aSEN4OLxNc9oZg@mail.gmail.com>
Subject: Re: Git for Windows documentation, was Re: [git-for-windows] Re: [ANNOUNCE] Git for Windows 2.9.3
Date:   Thu, 25 Aug 2016 00:28:14 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfPVhD+GwKpLlwMOzGZRgIXyCymId9vzL9jBb3MYzLhBdbcOPEaTmHc7doerk47pK+59Wp0FdSAWwwzGea6LnRHUnDV8QCc2vY/G2izOPK51vstL/ZYIJ
 SWBQu7KWzT5BckODIm+TkXlyA7iZgLVICFTvtJK6psdC8jvHxWZAoO3TrxPSy06prOGfZ7wal7LuBmDjrWLCQ5pBuxHMQSUXYV+Z3LHHzVoD6rmP7ncprEYw
 Mp1arb/pIBncAKvAmdTSgFK4Ct56qU/THxA+bObX1+ZJoMFTAb1nYVkl+Zgp6jmtVx0efYT2Tm/ne0gjrzBRldpJMV700d+AAJp8rshgPwqCw0dVAGSM+WXe
 1TbbPTq0y1VeGoF/PmeN11/xMRAuxw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Dakota Hawkins" <dakotahawkins@gmail.com>
> On Wed, Aug 24, 2016 at 11:41 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi Dakota,
>>
>> On Tue, 23 Aug 2016, Dakota Hawkins wrote:
>>
>>> I use GFW almost exclusively, but I pretty much always consult the
>>> upstream documentation anyway (because I find it easier).
>>
>> Oh... I thought that typing "git help git-commit" opening a nice HTML 
>> page
>> in your favorite browser was good enough.
>>
>> Do you have any suggestion how to improve the user experience?
>
> Just a small one, and that's that I'd prefer the option to have help
> display in my terminal (that option might exist and I don't know how
> to turn it on). That would be very convenient for me.
>
> Opening a nice HTML page is probably nice for a lot of users. What
> frustrates me about it is that I don't know which browser window on
> which monitor (of 3) it's going to open in, so it's a context-switch
> to a different window somewhere that I don't have much control over.
>
> The thing I find easier about using the upstream documentation is just
> that I can pick the browser window I want it to come up in, and it's
> usually faster enough for me to just google "git-whatever" or
> re-purpose an open doc tab. I don't prefer the _content_ of the
> upstream documentation, it's just less frustrating for me to use, if
> that makes sense.
>
If you would like to use the man pages, then one option is to install the 
SDK, which then allows you to install the man package, (setting the manpath 
as required) to allow your choice of viewer. You may need to set the minnty 
config BoldAsFont=yes if you want the bold for the headings in the man 
pages.

With the SDK you can also create a personal release version of GfW that 
includes the man viewer if you like.
--
Philip

