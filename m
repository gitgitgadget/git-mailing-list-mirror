Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8331C6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 20:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCMU3L convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 13 Mar 2023 16:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCMU3J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 16:29:09 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653427C9DB;
        Mon, 13 Mar 2023 13:28:41 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 32DKRWbb472912
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 20:27:33 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <xmqqjzzkv8xz.fsf@gitster.g>
In-Reply-To: <xmqqjzzkv8xz.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.40.0
Date:   Mon, 13 Mar 2023 16:28:00 -0400
Organization: Nexbridge Inc.
Message-ID: <015d01d955ea$516c2390$f4446ab0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKUDg380+wddaX1P8vy4ObDoGlvvK2Dt7yw
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, March 13, 2023 1:49 PM, Junio C Hamano wrote:
>The latest feature release Git v2.40.0 is now available at the usual places.  It is
>comprised of 472 non-merge commits since v2.39.0, contributed by 88 people, 30 of
>which are new faces [*].

My team, ITUGLIB, is building 2.40.0 for NonStop ia64 and x86 and will be available soon (2-3 days) in the usual place at https://ituglib.connect-community.org/apps/Ituglib/SrchOpenSrcLib.xhtml. Please see Google Groups comp.sys.tandem for further announcements.

Regards,
Randall Becker

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



