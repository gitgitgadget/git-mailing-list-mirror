Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C652FC433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 14:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB5A320758
	for <git@archiver.kernel.org>; Fri, 15 May 2020 14:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgEOOVO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 15 May 2020 10:21:14 -0400
Received: from elephants.elehost.com ([216.66.27.132]:31349 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgEOOVO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 10:21:14 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 04FELAkb045657
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 15 May 2020 10:21:11 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqy2punll7.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2punll7.fsf@gitster.c.googlers.com>
Subject: RE: [ANNOUNCE] Git v2.27.0-rc0
Date:   Fri, 15 May 2020 10:21:04 -0400
Message-ID: <021601d62ac4$152ff770$3f8fe650$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQH1Eosa5ft2KDLOZlGih74JgloHn6hrYimw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 14, 2020 7:28 PM, Junio wrote:
> To: git@vger.kernel.org
> Cc: Linux Kernel <linux-kernel@vger.kernel.org>; git-
> packagers@googlegroups.com
> Subject: [ANNOUNCE] Git v2.27.0-rc0
> 
> An early preview release Git v2.27.0-rc0 is now available for
> testing at the usual places.  It is comprised of 479 non-merge
> commits since v2.26.0, contributed by 53 people, 16 of which are
> new faces.

Thanks Junio. I am starting the HPE NonStop TNS/X test cycle and will let you know how it goes. Our TNS/E system is in the middle of being moved so I'll probably wait until the official release on that one.

Regards,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
 MVS developer since (not admitting anything about this)
-- In my real life, I talk too much.



