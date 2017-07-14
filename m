Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D052A20357
	for <e@80x24.org>; Fri, 14 Jul 2017 14:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754162AbdGNO2s (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 10:28:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:63698 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754007AbdGNO2r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 10:28:47 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M9bYB-1dMzRN1NzL-00Cy2Q; Fri, 14
 Jul 2017 16:28:42 +0200
Date:   Fri, 14 Jul 2017 16:28:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Kavita Desai <kvdesai2@illinois.edu>
cc:     git@vger.kernel.org
Subject: Re: Git Bash Bug
In-Reply-To: <CAAu0pLedy5xqUgF7drMf=tQgMJD4rXq+JvKaiE54EdRFZWuTkQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1707141625150.4193@virtualbox>
References: <CAAu0pLedy5xqUgF7drMf=tQgMJD4rXq+JvKaiE54EdRFZWuTkQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:L/tyO/CBpQWiAoN/bcEDpNYhKEr0I2cL+8/1ykO77UvQwlM6yBH
 07j/2LejusyAv8PfF40WKOqYq5DtaKtwqWbxR7RcNkNNLzGRCYFs17QbN0klR2Risvni55L
 5utjXV2gtcrdiS3zSE0rD8MuIKKtwHjaCUt7gkzrldt+YJW7VgOnyOy/ciNobC6jvOUewWn
 K0DLK0VRcgD10Kps2QPUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MCJL073/5Gc=:yeCc66vrXLL9+hXODjWzni
 aco9Cw7ZoVXWBrH0tK+w0Q6EaKRZYkXPfGdDp7qpjOLyx4JjuS8+LrYIbS5SL3ym+4qsP07gf
 D42bV5sdHrd4rvzGmiyOXRMy6uW1Zx18dyi0Kc3G3rksT9SmHgA7jqNi4trIsBFKIoQaGc7mX
 a0ZNll1rEIoJEGQWWK18ZJ+65BuSSmn3MbY5ORhhKCN1k/InL8+xAQ1d0+y1gtf5x5u1Y0uAG
 nqdSyS70o30ah0l3wdkNoQ2k1SPy/m+rKNmmn4vMNmh9txsF5DvxrXclJj5XqBphb0mTf6DpS
 +n9gb0N2I02qsvs6GB5fkbPwwvhCrr18bjxYqPodgDTgsv260KAOUytbOzdEE7Jv2kVwbpp00
 vtIt0qP+J3Fe6F+oA2gR0pLGcpp7AHRGwBRRSAGWmgfqZ+qkGgEJ3ul5RGyZ9fNua8KnxhzEO
 swoLD1qSBICVVvvPBFi24FnAju98M5/LblOrJ/mKf76tvK3dP1BJU9EhZUfV2VVdUbJ9ihR+P
 F0W/1sBgqY+msrqK9+5Ndtv+cdabz0l0Zpegg5RsyKyLg373m4PySlWl5Jw6mezu4xHDCT/nJ
 aBRNylzb+WXM5VR91ztCo6NDRoFgqlfV01C/dYx3vJBIS4M8K/pLkuc7Cu/Fe9L8Es5X7yUrB
 3RuBtoec+luGsjCJ2YMJRgg1YVIuAySx6wrqvdJLyCFYnQZvRatrvl6IFJkWkV9E2Iedho7B0
 Yu63HlYLiBdfp9vit+7rkAa8yZH7ghopxReI5goX0FR/T/LhZlarOX5dyNOANKKlyJ2tlmjkP
 eK+4EhTb/cpFd2Tb2rC2gd4P6BXgFIyTBevmH6w0cPdTzXNi6w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kavita,

On Fri, 14 Jul 2017, Kavita Desai wrote:

> Originally, when I first had Git Bash everything was working
> perfectly. Randomly one day, my bash commands were not working.

There are a gazillion ways how commands can "not work". You *need* to be
more specific here. In the least, a precise pasted output of a failed
command is necessary.

In addition, a couple of other points of interest would be good to know,
the issue reporting template at
https://github.com/git-for-windows/git/issues/new tries to help you
provide as much important information as you can. Maybe give it a try?

Ciao,
Johannes
