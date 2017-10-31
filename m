Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20CDA20437
	for <e@80x24.org>; Tue, 31 Oct 2017 21:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbdJaVWx (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 17:22:53 -0400
Received: from ikke.info ([178.21.113.177]:38268 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751324AbdJaVWx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 17:22:53 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 8E2AF44038E; Tue, 31 Oct 2017 22:22:51 +0100 (CET)
Date:   Tue, 31 Oct 2017 22:22:51 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Eyjolfur Eyjolfsson <eyjolfureyjolfsson@tprg.com>
Cc:     git@vger.kernel.org
Subject: Re: Is it possible to convert a Json file to xml file with Git
Message-ID: <20171031212251.GB7777@alpha.vpn.ikke.info>
References: <CAO-WtQhAPjoWnWyMPi5SkCSUM_y8A=hsbLk-MUfnCSBvWnBRNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-WtQhAPjoWnWyMPi5SkCSUM_y8A=hsbLk-MUfnCSBvWnBRNQ@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 05:28:40PM +0000, Eyjolfur Eyjolfsson wrote:
> Hi
> 
> I have a question.
> Is it possible to convert a Json file to XML with Git
> 
> Best regards
> 
> Eyjolfur Eyjolfsson
> 
> (e) eyjolfureyjolfsson@tprg.com
> (w) tpretailgroup.com
> 

Hello Eyjolfur,

git is a version control system, which is mostly content agnostic. It
knows nothing about json or xml, let alone how to convert them.

You might want to use some kind of programming language to do the
conversion.

Could you perhaps explain more why you are asking this question?

Kevin.
