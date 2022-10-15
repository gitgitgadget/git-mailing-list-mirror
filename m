Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE42C433FE
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 18:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJOSOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 14:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJOSOs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 14:14:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF4827CE2
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 11:14:46 -0700 (PDT)
Received: (qmail 19401 invoked by uid 109); 15 Oct 2022 18:14:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 15 Oct 2022 18:14:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12021 invoked by uid 111); 15 Oct 2022 18:14:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 15 Oct 2022 14:14:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 15 Oct 2022 14:14:45 -0400
From:   Jeff King <peff@peff.net>
To:     Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Cc:     Elsie Hupp <git@elsiehupp.com>, Junio C Hamano <gitster@pobox.com>,
        reto@labrat.space, philipoakley@iee.email, git@vger.kernel.org
Subject: Re: Multiple --global config workspaces?
Message-ID: <Y0r4lfRRNeVA5mU2@coredump.intra.peff.net>
References: <C4E3A512-2E2C-4EA5-9F2E-3662BCF0F165@elsiehupp.com>
 <xmqqwn96x61t.fsf@gitster.g>
 <Y0Vr/4IeA236nxzF@coredump.intra.peff.net>
 <03B277AB-DE33-443D-AC9C-FAB7A2F93AB3@elsiehupp.com>
 <Y0m64fHWIjZoXoTQ@coredump.intra.peff.net>
 <AM0PR04MB60197E29A9D11F3689C03225A5279@AM0PR04MB6019.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB60197E29A9D11F3689C03225A5279@AM0PR04MB6019.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 15, 2022 at 12:56:38PM +0200, Matthias Aßhauer wrote:

> die.net is often quite high in the google results for me and from experience
> seems to be a common source when looking up man pages online.
> Their git related man pages seem to be roughly from around Git 1.7.5. They
> do have a contact email at the bottom of their homepage. I'll try to poke
> them.

Thanks for doing so. 1.7.5 is really quite old (2011!).

-Peff
