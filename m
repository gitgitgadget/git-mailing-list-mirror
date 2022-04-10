Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9014C433EF
	for <git@archiver.kernel.org>; Sun, 10 Apr 2022 16:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbiDJQQk convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 10 Apr 2022 12:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiDJQQg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Apr 2022 12:16:36 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07A655BF9
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 09:14:24 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.251.39] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23AGELSQ026764
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 10 Apr 2022 12:14:22 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     <git-packagers@googlegroups.com>
References: <xmqqy20fjgpy.fsf@gitster.g> 
In-Reply-To: 
Subject: RE: [ANNOUNCE] Git v2.36.0-rc1
Date:   Sun, 10 Apr 2022 12:14:16 -0400
Organization: Nexbridge Inc.
Message-ID: <013e01d84cf6$0a507360$1ef15a20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHpJyxHFOvIWHJBeyvJNZFd5bt++6zE9JgAgAKivYA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 8, 2022 7:38 PM, I wrote:
>On April 8, 2022 7:31 PM, Junio C Hamano wrote:
>>A release candidate Git v2.36.0-rc1 is now available for testing at the
>>usual places.  It is comprised of 673 non-merge commits since v2.35.0,
>>contributed by 85 people, 25 of which are new faces [*].
>
>We did not make it to t6200 on the previous cycle. Restarting. Note that I did not
>get an answer on changing the PATH to SSH, which is still outstanding for us.

2.36.0-rc1 (ab1f2765f78e) passed on NonStop ia64. We are waiting on x86 results, but this is encouraging (30 hours remaining).
--Randall

