Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD4061FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 20:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbdJEUzn (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:55:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:57378 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751469AbdJEUzn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:55:43 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LgqQQ-1dTdrW02NS-00oFNG; Thu, 05
 Oct 2017 22:55:40 +0200
Date:   Thu, 5 Oct 2017 22:55:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     git-for-windows@googlegroups.com, git@vger.kernel.org
Subject: Re: [git-for-windows] [ANNOUNCE] Git for Windows 2.14.2(2)
In-Reply-To: <E2CD2BA7-130B-479B-84DF-A7AFA0EBF30F@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1710052255200.40514@virtualbox>
References: <20171005200227.8028-1-johannes.schindelin@gmx.de> <E2CD2BA7-130B-479B-84DF-A7AFA0EBF30F@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VOYbxTo1g5QHqecKu8+9MVqbpFM5CqWNEjcffZENXJTrIg+TFdC
 9i6A5vSt60hbkd4QkSzcZFolz4MUN/ZqsF/H9z4CyElWBc7PlOUTV8wRYGyFuQ9Z/M1bZnE
 2evHaRxZ1NSqePzJKaAI2L9zX1NB+bNo1fVtfoitbfEbBwD73eiy5KCMv6jUiurWSM2kvzI
 aXF8hk9psTcMdLaneH3Jw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uFK/TEGF1/o=:kLB6828IoWs0XTogDHtF/Y
 qu4mqKBjY7OyN8/J5zmEYouUbv08+UDnE7TWfW0gzTvVqUyH/D/uB6WP70i0bgiReBvaJLnib
 rmBP+JgXhMfhp3j6kNJCfkt1/EhZcsMkZ9KUysv6qX8wVPPVPMJbpTVu3ekukBdWy/UqwiTUL
 ODiOTYbtPU6UvkyxFx8apt9uS5rU0sMr1Z17RpLkXMSlU/usOYRujNZ8YduxbUSw/3YRZebbU
 MImw33hTjyu3eA/tpl+ayzJ8PEuv8lqRJDhTeq3W9r9CLD+Z1at2ir2syvwNUCR8fdFM/Ffb1
 aWX6XIWifMExWDfkg4aQ833VAZOsHanntlr9QABqYvz7nyAv4VlOsHLSxKvz1S5NBeh+3JlVL
 g+Y+qwLyRddHD+bdSMFCVh26lgcQWyvO1ZtVbrgzPhLVny28xdvwRstSiouQzif1xAohg1PXi
 PlYtQQPk4DN4jrlKP0gixNoSRjhLfzYYMawlrXw9j4MtB296d2VrxVDcROHJ+jumuLN5hj3Hu
 S/+JYygn11eIioq85tNC8q9I6TgOX/g7OsrcrpS5n3C96aIF0s2w5jljtL49m6xWLqmnlMpXg
 Jo1u+aGQZArvrd9V7voKmbcnSLiXX10QQ2IQnLYip9FVcaG3qAhF536+io41ZLKFw++/ShAaU
 od4fWkmVNkH/ks0fyZYD4326DOvXoW4BPj6mM1sxVfmpJ+/94CGblZFRmItNfuEhQcBeKMhOq
 PSypcYsYtCrAQlh1mdMQ9QiIoHIxXtkmtsVJagFNGivMEs2XzvH/u+G5J7+GqBQRNWvQ672mb
 hxH0cJl49WclPy9o9Fwk84nzwnXp7NnUpUU3IomQc2+vEYgkR4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

On Thu, 5 Oct 2017, Lars Schneider wrote:

> > On 05 Oct 2017, at 22:02, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> > 
> > It is my pleasure to announce that Git for Windows 2.14.2(2) is available from:
> > 
> > 	https://git-for-windows.github.io/
> > 
> > Changes since Git for Windows v2.14.2 (September 26th 2017)
> > 
> > New Features
> > 
> >  * Comes with BusyBox v1.28.0pre.16467.b4c390e17.
> >  * Comes with Git LFS v2.3.2.
> 
> Just a heads-up: 
> Git LFS 2.3.2 contains a bug in the `git lfs clone` and `git lfs pull` calls:
> https://github.com/git-lfs/git-lfs/issues/2649
> 
> I expect 2.3.3 to be out soonish.

Oh drats.

Ciao,
Dscho
