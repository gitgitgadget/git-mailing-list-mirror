Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC1FC49361
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 09:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A11BB61241
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 09:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhFPJc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 05:32:29 -0400
Received: from cpanel8.indieserve.net ([199.212.143.3]:46346 "EHLO
        cpanel8.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhFPJc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 05:32:28 -0400
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com ([174.114.107.13]:40504 helo=fedora)
        by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1ltRsL-000AKl-Tu; Wed, 16 Jun 2021 05:30:20 -0400
Date:   Wed, 16 Jun 2021 05:30:14 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 0/6] doc: replace "alice" and "bob" examples
In-Reply-To: <xmqqfsxitw2n.fsf@gitster.g>
Message-ID: <9217211e-aa26-c1c9-2528-a29b93ff174e@crashcourse.ca>
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com> <xmqqfsxitw2n.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-229061633-1623835820=:4611"
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

--8323328-229061633-1623835820=:4611
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 16 Jun 2021, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
> > I suggested in [1] that the "alice" and "bob" examples in our
> > documentation would be better written without a reference to such
> > fictional characters, for reasons that have nothing to do with trying
> > to bend over backwards to avoid any reference to people's gender. It
> > just makes for better documentation.
>
> I actually do not mind cast of characters with concrete names,
> especially when there are more than three parties involved and
> having names for them help clarify the description.  But I agree
> with you that Alice and Bob should be reserved for situations where
> appearance of Eve would reasonably be anticipated, or the use of
> these two names become distracting to those who happen to be aware
> how these characters are often used in CS literature.
>
> Perhaps s/Alice/Tabby/ and s/Bob/Fido/ or something like that ;-)?

  i look forward to the renaming of "git" to something more innocuous
and palatable because, somewhere, someone could conceivably,
hypothetically, theoretically take exception to it.

  seriously, can we start a second mailing list where people want to
talk about, you know, version control?

rday
--8323328-229061633-1623835820=:4611--
