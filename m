Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99C4C43460
	for <git@archiver.kernel.org>; Wed, 12 May 2021 12:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B3C061108
	for <git@archiver.kernel.org>; Wed, 12 May 2021 12:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhELMcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 08:32:17 -0400
Received: from cpanel8.indieserve.net ([199.212.143.3]:50971 "EHLO
        cpanel8.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbhELMcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 08:32:16 -0400
X-Greylist: delayed 2759 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 May 2021 08:32:16 EDT
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com ([174.114.107.13]:60934 helo=fedora)
        by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1lgnIb-0005Qe-Jg; Wed, 12 May 2021 07:45:08 -0400
Date:   Wed, 12 May 2021 07:45:05 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
To:     =?ISO-8859-15?Q?Michal_Such=E1nek?= <msuchanek@suse.de>
cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Varun Varada <varuncvarada@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: replace jargon word "impact" with
 "effect"/"affect"
In-Reply-To: <20210512112059.GD8544@kitsune.suse.cz>
Message-ID: <8e353a57-8abd-74d0-8b42-488b166e58a2@crashcourse.ca>
References: <609ae224aa509_6064920851@natae.notmuch> <20210511202502.GM12700@kitsune.suse.cz> <CAD2i4DALKgw2wG6QGs-oQhAHnS3AG1j1BSq2bxjPojVOtw+WjA@mail.gmail.com> <609b4eea1088a_678ff208ba@natae.notmuch> <20210512040926.GN12700@kitsune.suse.cz>
 <609b63e48fd49_6d7da2086@natae.notmuch> <20210512064733.GP12700@kitsune.suse.cz> <609b9ab0b1120_6e4e9208cc@natae.notmuch> <20210512100855.GA8544@kitsune.suse.cz> <609bb67c96463_70eac2089d@natae.notmuch> <20210512112059.GD8544@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-548397769-1620819908=:14390"
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel8.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel8.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel8.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-548397769-1620819908=:14390
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 12 May 2021, Michal Suchánek wrote:

> On Wed, May 12, 2021 at 06:05:32AM -0500, Felipe Contreras wrote:
> > Michal Suchánek wrote:
> > > On Wed, May 12, 2021 at 04:06:56AM -0500, Felipe Contreras wrote:
> > > > So... Can you answer my question?
> > > >
> > > > Do you have anything against the word "affect" in *any* instance?
> > >
> > > Yss, the Merriam-Webster dictionary also lists the meaning
> > > "to cause illness, symptoms, etc."
> >
> > I did not ask you if you could list one definition contrary to the
> > intended purpose of the word "affect".
> >
> > I asked you if you have something againt the word "affect".
> >
> > We can use your same logic to find one definition for the word "impact"
> > contrary to your intended purpose.
>
> That's exactly the point you have been making, though.

  y'all realize that linus torvalds wrote an entire version control
system in less time than it's taken you to argue about what two words
mean, right?

rday
--8323328-548397769-1620819908=:14390--
