Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79D2A200B9
	for <e@80x24.org>; Sat,  5 May 2018 15:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeEEPlh (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 11:41:37 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:55216 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751235AbeEEPlg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 11:41:36 -0400
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
        by smtp3-g21.free.fr (Postfix) with ESMTP id A477D13F87F;
        Sat,  5 May 2018 17:41:35 +0200 (CEST)
Date:   Sat, 5 May 2018 17:41:35 +0200 (CEST)
From:   ydirson@free.fr
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        git <git@vger.kernel.org>
Message-ID: <2107075651.273821698.1525534895640.JavaMail.root@zimbra39-e7>
In-Reply-To: <CAP8UFD3jc6Aops56pgQCw7cYKW9ujkUmtDgLfwo=VyBy-QNKAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Fix support for merge options.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.238.54.222]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian wrote:
> Hi Yann,
> 
> On Sat, May 5, 2018 at 3:24 PM, Yann Dirson <ydirson@free.fr> wrote:
> > ---
> >  git-reintegrate | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/git-reintegrate b/git-reintegrate
> 
> It looks like git-reintegrate is not managed in Git but in this
> repository :
> 
> https://github.com/felipec/git-reintegrate
> 
> So could be a bit confusing to send those patches to the Git mailing
> list without telling that your patches are not to be integrated into
> Git itself.

Right, I stand corrected, thanks :)

> Nice to see you again on the list anyway!
> 
> Best,
> Christian.
> 
