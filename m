Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E79B1F461
	for <e@80x24.org>; Tue, 14 May 2019 09:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfENJlP convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 14 May 2019 05:41:15 -0400
Received: from mx2.uni-regensburg.de ([194.94.157.147]:48466 "EHLO
        mx2.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfENJlP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 05:41:15 -0400
Received: from mx2.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 58E756000056
        for <git@vger.kernel.org>; Tue, 14 May 2019 11:41:12 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx2.uni-regensburg.de (Postfix) with ESMTP id 45AA4600004D
        for <git@vger.kernel.org>; Tue, 14 May 2019 11:41:12 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Tue, 14 May 2019 11:41:12 +0200
Message-Id: <5CDA8D37020000A100031319@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date:   Tue, 14 May 2019 11:41:11 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: Missing branches after clone
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

While wondering why some branches are not being displayed by "git branch" in a cloned repository, I was reading the obvious man pages (man git-branch, man git-remote), but still couldn't find the reason or the solution. Then I found https://stackoverflow.com/questions/10312521/how-to-fetch-all-git-branches which handles the subject...
But still the most common solution there still looks like an ugly hack.
Thus I suggest to improve the man-pages (unless done already)
My git is as old as 2.12.3, however...

Regards,
Ulrich

