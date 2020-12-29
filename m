Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0BAC433DB
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 08:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDBC9207CF
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 08:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgL2Iy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 03:54:56 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:60521 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgL2Iy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 03:54:56 -0500
X-Originating-IP: 157.36.128.118
Received: from localhost (unknown [157.36.128.118])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E5503C0009;
        Tue, 29 Dec 2020 08:54:13 +0000 (UTC)
Date:   Tue, 29 Dec 2020 14:24:10 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] CoC: update to 2.0
Message-ID: <20201229085324.vz7iwxoms5fe3w6a@yadavpratyush.com>
References: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/12/20 04:59AM, Junio C Hamano wrote:
> At 5cdf2301 (add a Code of Conduct document, 2019-09-24) we adopted
> a Code of Conduct from www.contributor-covenant.org; back then the
> version adopted, 1.4, was the latest one.
> 
> Version 2.0 tightens language in examples of unacceptable behaviour,
> generalizes the audience from "contributors and maintainers" to
> "community", and enhances the enforcement section.
> 
> The preamble we added to the beginning of the document has been
> kept, but the rest of the test has been replaced in full from the

s/test/text/

> "upstream" and then the same customization for our community
> (i.e. the way to contact community leadership teams) has been
> applied.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

-- 
Regards,
Pratyush Yadav
