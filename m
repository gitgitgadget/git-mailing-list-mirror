Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6AEE20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 15:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751202AbdFAP00 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 11:26:26 -0400
Received: from ikke.info ([178.21.113.177]:37364 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751058AbdFAP00 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 11:26:26 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 2660C4400B2; Thu,  1 Jun 2017 17:26:24 +0200 (CEST)
Date:   Thu, 1 Jun 2017 17:26:24 +0200
From:   Kevin Daudt <me@ikke.info>
To:     SJR <haltekx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: wrong language translation part7
Message-ID: <20170601152624.GA29442@alpha.vpn.ikke.info>
References: <CAMOGhMJyO=+EZz6qCejxeTe5FdE=RheJX9A5g3U6eKhUKj8_BQ@mail.gmail.com>
 <CAMOGhMLMo82RgH0HareB78KVWz2gMGzhB1i5s3SobW9wHk0zbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMOGhMLMo82RgH0HareB78KVWz2gMGzhB1i5s3SobW9wHk0zbg@mail.gmail.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 01, 2017 at 01:16:11PM +0200, SJR wrote:
> W dniu 1 czerwca 2017 09:43 użytkownik SJR <haltekx@gmail.com> napisał:
> >
> > Hi,
> >
> > https://git-scm.com/book/pl/v1/Dostosowywanie-Gita-Konfiguracja-Gita
> >
> > part in polish part in english.
> >
> > Can You repair translation?
> >
> > Regards,
> > JanR

The progit book is not maintained by the git community itself. You can
find the project at [0].

If you look at this specific chapter in the Polish translation[1], then
you'll see that that chapter is just not completely translated. Someone
would need to step in and finish the translation.

But note that this is version 1 of the book, while the latest release is
version 2. But that one does not have a polish translation at all.

[0]: https://github.com/progit/progit/
[1]: https://github.com/progit/progit/blob/master/pl/07-customizing-git/01-chapter7.markdown
