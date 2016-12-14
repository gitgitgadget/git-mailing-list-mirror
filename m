Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EAC4203C1
	for <e@80x24.org>; Wed, 14 Dec 2016 06:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754678AbcLNGgu (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 01:36:50 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:45896 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752752AbcLNGgt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 01:36:49 -0500
Received: from tigra.domain007.com ([192.168.2.102])
        by mailhub.007spb.ru (8.14.4/8.14.4/Debian-4+deb7u1) with SMTP id uBE6agnP020086;
        Wed, 14 Dec 2016 09:36:43 +0300
Date:   Wed, 14 Dec 2016 09:36:42 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     essam Ganadily <doctoresam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Creating remote git repository?
Message-Id: <20161214093642.10af1d7ce2f5df6c6f6af957@domain007.com>
In-Reply-To: <CADo08-pBPVShFDSbOuk-12KUQL7t7ajG17-A6=UCrUVk+hcNtA@mail.gmail.com>
References: <CADo08-pBPVShFDSbOuk-12KUQL7t7ajG17-A6=UCrUVk+hcNtA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 14 Dec 2016 09:00:42 +0300
essam Ganadily <doctoresam@gmail.com> wrote:

> given that git is an old and mature product i wounder why there is no
> command line (git.exe in windows) way of creating a remote git
> repository?
> 
> "git remote create repo myreponame"
> 
> frankly speaking i know that our friends in the linux kernel project
> never felt the need to create remote repository because they probably
> rarely need that but i guess their merciful hearts could have some
> feeling for the rest of us?

Also asked and answered (by me) over there at git-users [1].

1. https://groups.google.com/d/msg/git-users/twgkOYV6kX4/FED559TPDQAJ

