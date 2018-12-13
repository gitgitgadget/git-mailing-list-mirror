Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B71CF20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 12:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbeLMMTg (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 07:19:36 -0500
Received: from avasout06.plus.net ([212.159.14.18]:45321 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbeLMMTg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 07:19:36 -0500
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Dec 2018 07:19:36 EST
Received: from hashpling.plus.com ([212.159.69.125])
        by smtp with ESMTP
        id XPqWgIPWxuugZXPqXgxzU9; Thu, 13 Dec 2018 12:12:05 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=bLE43s2Z c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17
 a=kj9zAlcOel0A:10 a=2ur7OfE09M0A:10 a=5rxgeBVgAAAA:8 a=PKzvZo6CAAAA:8
 a=KN8tFWflUzBCWuQMoFwA:9 a=CjuIK1q_8ugA:10 a=u09W0hvIdLUA:10
 a=PwKx63F5tFurRwaNxrlG:22 a=q92HNjYiIAC_jH7JDaYf:22
Received: from seabee by hashpling.plus.com with local (Exim 4.89)
        (envelope-from <seabee@hashpling.org>)
        id 1gXPqV-0006uQ-TF
        for git@vger.kernel.org; Thu, 13 Dec 2018 12:12:03 +0000
Date:   Thu, 13 Dec 2018 12:12:03 +0000
From:   CB Bailey <cb@hashpling.org>
To:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] Use mailmap by default in log, show and whatchanged
Message-ID: <20181213121203.zzzwaadf73cbfrkn@hashpling.org>
References: <20181213120940.26477-1-cb@hashpling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213120940.26477-1-cb@hashpling.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CMAE-Envelope: MS4wfPscvdyBAN4rTDUzZSN+lvK/YX4YYXDZVHm1Vg8o7lStemal7QkZRyGr94Mry3MCXiCfuiiIeiqmvTFyJW0EsMYPMjTHexZm+EPSLJ1rkLwHcPUrlEy3
 jkpLOhHiLR7C84HxTSaUIrO1YnDd2S2RDd1tTAhp9oTwj4mxC60+h1fLCSd/C+Dhl80mjkOZCM6tFQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 12:09:40PM +0000, CB Bailey wrote:
> I had a dig around in the mailing list archives and couldn't find any
> specific reason not to use a mailmap in log where one is in use. I did
> find this message which suggests that it makes sense to make it the
> default for human-consumed formats. This patch doesn't affect
> "--pretty=raw" formatting.

This week I'm having an issue with sending messages a few seconds before
I've completed them.

This message:
https://public-inbox.org/git/20121112231815.GE10531@sigill.intra.peff.net/

CB
