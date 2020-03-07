Return-Path: <SRS0=zTfj=4Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A542BC10F25
	for <git@archiver.kernel.org>; Sat,  7 Mar 2020 22:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4AF2070A
	for <git@archiver.kernel.org>; Sat,  7 Mar 2020 22:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgCGWRI convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 7 Mar 2020 17:17:08 -0500
Received: from elephants.elehost.com ([216.66.27.132]:27334 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgCGWRI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Mar 2020 17:17:08 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 027MH324014347
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 7 Mar 2020 17:17:04 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqq5zfi4g0p.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zfi4g0p.fsf@gitster-ct.c.googlers.com>
Subject: RE: [ANNOUNCE] Git v2.26.0-rc0
Date:   Sat, 7 Mar 2020 17:16:54 -0500
Message-ID: <008c01d5f4ce$1f9e5c50$5edb14f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGrhQ2tczC7TxgQcdclT00qKesvnKiSkM2g
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 5, 2020 5:02 PM, Junio C Hamano Wrote:
> An early preview release Git v2.26.0-rc0 is now available for testing at the
> usual places.  It is comprised of 426 non-merge commits since v2.25.0,
> contributed by 43 people, 7 of which are new faces.

On the NonStop platform, t0301.22 and t1091.23 continue to fail. I reported these with symptoms previously and would request assistance in diagnosing the situation.

Regards,
Randall

