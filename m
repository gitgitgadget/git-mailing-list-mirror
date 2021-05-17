Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDF1C433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 13:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE1B6100B
	for <git@archiver.kernel.org>; Mon, 17 May 2021 13:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhEQNfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 09:35:07 -0400
Received: from elephants.elehost.com ([216.66.27.132]:21083 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhEQNfG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 09:35:06 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 14HDXkaK050953
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 May 2021 09:33:47 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqh7j13kmc.fsf@gitster.g>
In-Reply-To: <xmqqh7j13kmc.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.32.0-rc0
Date:   Mon, 17 May 2021 09:33:41 -0400
Message-ID: <006501d74b21$438c2160$caa46420$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQG/Yb15Or4eeb15shZcVhQFK4t4zasXfsmQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


>-----Original Message-----
>From: Junio C Hamano <gitster@pobox.com>
>Sent: May 17, 2021 3:06 AM
>To: git@vger.kernel.org
>Cc: Linux Kernel <linux-kernel@vger.kernel.org>; git-
>packagers@googlegroups.com
>Subject: [ANNOUNCE] Git v2.32.0-rc0
>
>An early preview release Git v2.32.0-rc0 is now available for
>testing at the usual places.  It is comprised of 545 non-merge
>commits since v2.31.0, contributed by 76 people, 29 of which are
>new faces [*].

NonStop test cycle beginning.
-Regards Randall

