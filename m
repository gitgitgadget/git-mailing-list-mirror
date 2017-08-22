Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC5C31F667
	for <e@80x24.org>; Tue, 22 Aug 2017 20:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbdHVUMU (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 16:12:20 -0400
Received: from [195.159.176.226] ([195.159.176.226]:60289 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1752451AbdHVUMT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 16:12:19 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1dkFWx-0004bm-Ii
        for git@vger.kernel.org; Tue, 22 Aug 2017 22:12:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Harry Putnam <reader@newsguy.com>
Subject: Advice needed for basic setup for home user
Date:   Tue, 22 Aug 2017 16:11:54 -0400
Organization: Still searching...
Message-ID: <87o9r7z7jp.fsf@local.lan>
Mime-Version: 1.0
Content-Type: text/plain
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.0.50 (gnu/linux)
Cancel-Lock: sha1:Pw92xzlPaNiAm6nECud9YNXxU/M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Setup: Running openindian/hipster updated as of Aug 20 '17
Hardware: HP xw8600 - 2x Xeon  CPU X5450 @ 3.00GHz - 32 GB ram

I used cvs for several yrs before moving to git about yr ago.

In both cases I've barely scratched the surface with my usage.

I run 5-10 vbox vms' on this host with various OS's involved.
With each host, I've kept a local repo of some key OS rc files.
and a couple of hundred home made scripts. 

They all follow the same pattern of setup, but over time each repo
becomes different from its cousins. 

I've never taken the step of centralizing the assorted local git repos
into a central repo that keeps a branch or directory or whatever it
would be called of each local repo.

So that all the local repos would become a checked out module from the
central git repo.

Or at any rate, something along that line... not even sure how I would
set that up with git, but would like some overall advice about how to
do that. A step thru or an outline would be very useful.

