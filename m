Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E0F41F404
	for <e@80x24.org>; Wed, 20 Dec 2017 12:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755231AbdLTMUL (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 07:20:11 -0500
Received: from quechua.inka.de ([193.197.184.2]:50117 "EHLO mail.inka.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755073AbdLTMUK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 07:20:10 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
        by mail.inka.de with uucp (rmailwrap 0.5) 
        id 1eRdM1-0002uw-0x; Wed, 20 Dec 2017 13:20:09 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
        id 32993120195; Wed, 20 Dec 2017 13:19:39 +0100 (CET)
Date:   Wed, 20 Dec 2017 13:19:39 +0100
From:   Josef Wolf <jw@raven.inka.de>
To:     git@vger.kernel.org
Subject: Re: Need help migrating workflow from svn to git.
Message-ID: <20171220121939.GG18542@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20171214130933.GA18542@raven.inka.de>
 <xmqqvah8q7cg.fsf@gitster.mtv.corp.google.com>
 <19d67f01-5e7d-3792-52f4-52da86bca5e5@gmail.com>
 <20171220114337.GE18542@raven.inka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171220114337.GE18542@raven.inka.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 20, 2017 at 12:43:37PM +0100, Josef Wolf wrote:
> Thanks to you both for your patience with me. Sorry for the late reply, my day
> job was needing me ;-)
> 
> On Fri, Dec 15, 2017 at 07:58:14PM +0100, Igor Djordjevic wrote:
> > On 15/12/2017 17:33, Junio C Hamano wrote:
> > > 
> > >     $ git fetch <remote> <branch>
> > >     $ git checkout -m -B <master> FETCH_HEAD
> 
> For some reason, this seems to double the local modifications. After executing
> the following commands:

Umm... Please ignore this "doubling" comment. My test script was faulty :-//

Sorry for the confusion!

-- 
Josef Wolf
jw@raven.inka.de
