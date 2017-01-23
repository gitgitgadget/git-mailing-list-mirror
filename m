Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3943820A17
	for <e@80x24.org>; Mon, 23 Jan 2017 15:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751061AbdAWPCG (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 10:02:06 -0500
Received: from zm23-mta-out-2.grenet.fr ([130.190.191.53]:56116 "EHLO
        zm23-mta-out-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdAWPCE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 10:02:04 -0500
Received: from zm23-mta-out.grenet.fr (zm23-mta-out.grenet.fr [130.190.191.35])
        by zm23-mta-out-2.grenet.fr (Postfix) with ESMTP id 88480C4A0;
        Mon, 23 Jan 2017 16:02:01 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps1.u-ga.fr [152.77.1.30])
        by zm23-mta-out.grenet.fr (Postfix) with ESMTP id 81E7E100303;
        Mon, 23 Jan 2017 16:02:01 +0100 (CET)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 666E6125EA0;
        Mon, 23 Jan 2017 16:02:01 +0100 (CET)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     git <git@vger.kernel.org>, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@dwim.me>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Thomas Gummerer" <t.gummerer@gmail.com>
Subject: GSoC 2017: application open, deadline = February 9, 2017
Date:   Mon, 23 Jan 2017 16:02:02 +0100
Message-ID: <vpq1svtstud.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via submission-587 ACL (112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

The Google Summer of Code 2017 program is launched
(https://summerofcode.withgoogle.com/).

Last year, Pranit Bauva worked on porting "git bisect" from shell to C,
mentored by Christian and Lars (I didn't follow closely, but essentially
many preparatory steps, cleanups and tests were merged in master, and
patches starting the real port are still queued in pu). The org admins
were Peff and I.

The application deadline is February 9, 2017, i.e. a bit more than 2
weeks from now. So, we should decide quickly whether or not to
participate, and if so work on the application.

On my side, I've been struggling to find some time budget to allocate to
Git since last year and I couldn't even keep up with discussions on this
list :-(. Last summer, I thought that being an org co-admin would help,
but it didn't. So, as much as possible, I'd like to avoid being an org
admin this year. It's not a lot of work (much, much less than being a
mentor!), but if I manage to get some time to work for Git, I'd rather
do that on coding and reviewing this year.

So, a bunch of unanswered questions:

* Does the git.git community want to participate in GSoC this year?
  Actually, I have mixed feelings about this: I do like GSoC, but it
  seems we lack reviewer time more than coder time, and GSoC does not
  make it better. OTOH, a GSoC participant is a potential reviewer in
  the long run ...

* Does the libgit2 community want to participate in GSoC? If so, we
  should clarify the application process. Last year, I wrote (too late):

  > It's essentially too late to change this for this year, but next
  > time we should discuss earlier about how we want to organize this
  > git.git/libgit2 thing. For example, I think it would make little sense
  > to have a git.git microproject and then apply for a libgit2 project
  > since we have very different ways of interacting. And honestly, right
  > now the application is really git.git-centric so I don't think it
  > attracts students towards libgit2. So, if you want to attract more
  > students, we should work on that.

If the answer to one of the above question is yes, then:

* Who's willing to mentor? and to admin?

* We need to write the application, i.e. essentially polish and update
  the text here: https://git.github.io/SoC-2016-Org-Application/ and
  update the list of project ideas and microprojects :
  https://git.github.io/SoC-2017-Ideas/
  https://git.github.io/SoC-2016-Microprojects/

Cheers,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
