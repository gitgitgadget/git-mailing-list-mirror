Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77351C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 10:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EA98206F7
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 10:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgFJKu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:50:26 -0400
Received: from cpanel7.indieserve.net ([199.212.143.8]:43337 "EHLO
        cpanel7.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgFJKu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 06:50:26 -0400
X-Greylist: delayed 3536 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jun 2020 06:50:25 EDT
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com ([174.114.100.179]:33112 helo=localhost.localdomain)
        by cpanel7.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1jixOJ-002Xos-0z; Wed, 10 Jun 2020 05:51:27 -0400
Date:   Wed, 10 Jun 2020 05:51:24 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Simon Pieters <simon@bocoup.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, don@goodman-wilson.com
Subject: Re: Rename offensive terminology (master)
In-Reply-To: <CAOAHyQzxG7Lc6+PLBtM6oe9vSoEEAmuXAaKF2VzO_phtkfGRVA@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.2006100549070.3771@localhost.localdomain>
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com> <20200505231641.GH6530@camp.crustytoothpaste.net> <CAOAHyQx=+fM1FpAv+g3M+j7j4MgLJA03=MGFmXLvZcfJKAEpGg@mail.gmail.com> <xmqqeeqoi5wc.fsf@gitster.c.googlers.com>
 <CAOAHyQzxG7Lc6+PLBtM6oe9vSoEEAmuXAaKF2VzO_phtkfGRVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel7.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel7.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel7.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 9 Jun 2020, Simon Pieters wrote:

> Hi Junio,
>
> On Tue, Jun 9, 2020 at 6:02 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Simon Pieters <simon@bocoup.com> writes:
> >
> > > If someone is interested in helping with this, please follow up with
> > > Don. But I would like to ask again for git mainline to seriously
> > > consider adopting this change, given the information presented above
> > > and the ongoing movement against systemic racism.
> >
> > I am OK in principle if a future version of Git, when used by a new
> > user of Git who does not have any custom configuration, wrote a
> > string other than 'master' in .git/HEAD when "git init" is run.
> >
> > Picking a good replacement word to mean the primary branch is
> > tricky, though.  Just having a notion that one is special among
> > many (i.e. the primary-ness of the thing being named with a word
> > that will replace 'master') may already be offending to some folks.
>
> I find this response not satisfactory:

  ... snip ...

"I can't breathe ... I can't breathe ..."

"Well, tell you what, what if we rename the initial default branch in
a distributed version control system for you?"

  *Now* do you understand how asinine all this sounds?

rday
