Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF43C433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 22:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4000E20672
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 22:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgGIWNk convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 9 Jul 2020 18:13:40 -0400
Received: from elephants.elehost.com ([216.66.27.132]:41273 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgGIWNk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 18:13:40 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 069MDZvX004449
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 9 Jul 2020 18:13:36 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     <git-packagers@googlegroups.com>
References: <xmqqh7ugwen6.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7ugwen6.fsf@gitster.c.googlers.com>
Subject: RE: [ANNOUNCE] Git v2.28.0-rc0
Date:   Thu, 9 Jul 2020 18:13:30 -0400
Message-ID: <090e01d6563e$312b2300$93816900$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIFMhVUdglvNsXUzajIS5RKgpTrdqiiF5tA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 9, 2020 5:41 PM Junio C Hamano wrote:
> An early preview release Git v2.28.0-rc0 is now available for testing at the
> usual places.  It is comprised of 284 non-merge commits since v2.27.0,
> contributed by 42 people, 9 of which are new faces.

I have kicked off our Jenkins Pipeline to build/test this release with our sparkling new OpenSSL 1.1.1f port and will report back on how this goes.

Regards,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



