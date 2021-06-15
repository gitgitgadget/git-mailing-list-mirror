Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0950C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2ED61625
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFOQtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:49:00 -0400
Received: from cpanel8.indieserve.net ([199.212.143.3]:35587 "EHLO
        cpanel8.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFOQtA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 12:49:00 -0400
Received: from cpeac202e043973-cmac202e043970.sdns.net.rogers.com ([174.114.107.13]:46126 helo=fedora)
        by cpanel8.indieserve.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1ltCDG-00Dttr-Dw; Tue, 15 Jun 2021 12:46:53 -0400
Date:   Tue, 15 Jun 2021 12:46:47 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
To:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 0/6] doc: replace "alice" and "bob" examples
In-Reply-To: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
Message-ID: <18b53cae-6da9-c970-b994-caee11c5baf9@crashcourse.ca>
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1075528249-1623775612=:23149"
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

--8323328-1075528249-1623775612=:23149
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 15 Jun 2021, Ævar Arnfjörð Bjarmason wrote:

> I suggested in [1] that the "alice" and "bob" examples in our
> documentation would be better written without a reference to such
> fictional characters, for reasons that have nothing to do with trying
> to bend over backwards to avoid any reference to people's gender. It
> just makes for better documentation.

  no, it doesn't ... and wikipedia explains it nicely:

https://en.wikipedia.org/wiki/Alice_and_Bob

"In cryptography, Alice and Bob are fictional characters commonly used
as placeholders in discussions about cryptographic protocols or
systems, and in other science and engineering literature where there
are several participants in a thought experiment. The Alice and Bob
characters were invented by Ron Rivest, Adi Shamir, and Leonard
Adleman in their 1978 paper "A Method for Obtaining Digital Signatures
and Public-key Cryptosystems".[1] Subsequently, they have become
common archetypes in many scientific and engineering fields, such as
quantum cryptography, game theory and physics.[2] As the use of Alice
and Bob became more widespread, additional characters were added,
sometimes each with a particular meaning. These characters do not have
to refer to humans; they refer to generic agents which might be
different computers or even different programs running on a single
computer."

  if you want to make the docs better, have at it, but please don't do
something as meaningless as replacing "bob" and "alice" because you're
feeling politically correct, or woke, or whatever the hell the kids
call it these days.

  jesus ...

rday
--8323328-1075528249-1623775612=:23149--
