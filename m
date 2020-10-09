Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B283EC433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 20:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6887A22284
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 20:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391657AbgJIUHA convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 9 Oct 2020 16:07:00 -0400
Received: from elephants.elehost.com ([216.66.27.132]:60070 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390896AbgJITv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 15:51:59 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 099JptkQ025853
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 9 Oct 2020 15:51:55 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
Subject: RE: [ANNOUNCE] Git v2.29.0-rc0
Date:   Fri, 9 Oct 2020 15:51:49 -0400
Message-ID: <052201d69e75$a3add8d0$eb098a70$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQMIzznH8O/y4dzt8Qo74xBDvobD46crTGxw
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 5, 2020 6:41 PM, Junio C Hamano wrote:
> An early preview release Git v2.29.0-rc0 is now available for
> testing at the usual places.  It is comprised of 588 non-merge
> commits since v2.28.0, contributed by 76 people, 22 of which are
> new faces.

The NonStop build/test went well. We got to t7601 before rc1 came out so I'm restarting based on that commit.

Thanks,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



