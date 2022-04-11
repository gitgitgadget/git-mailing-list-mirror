Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0815CC433EF
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 11:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241475AbiDKLkn convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 11 Apr 2022 07:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiDKLkm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 07:40:42 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1D3457BD
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 04:38:28 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.251.39] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23BBcQbd081324
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 11 Apr 2022 07:38:26 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     <git-packagers@googlegroups.com>
References: <xmqqy20fjgpy.fsf@gitster.g>  
In-Reply-To: 
Subject: RE: [ANNOUNCE] Git v2.36.0-rc1
Date:   Mon, 11 Apr 2022 07:38:21 -0400
Organization: Nexbridge Inc.
Message-ID: <016801d84d98$a8c3c680$fa4b5380$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHpJyxHFOvIWHJBeyvJNZFd5bt++6zE9JgAgAKivYCAAUtyAA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 10, 2022 12:14 PM, I wrote:
>On April 8, 2022 7:38 PM, I wrote:
>>On April 8, 2022 7:31 PM, Junio C Hamano wrote:
>>>A release candidate Git v2.36.0-rc1 is now available for testing at
>>>the usual places.  It is comprised of 673 non-merge commits since
>>>v2.35.0, contributed by 85 people, 25 of which are new faces [*].
>>
>>We did not make it to t6200 on the previous cycle. Restarting. Note
>>that I did not get an answer on changing the PATH to SSH, which is still
>outstanding for us.
>
>2.36.0-rc1 (ab1f2765f78e) passed on NonStop ia64. We are waiting on x86 results,
>but this is encouraging (30 hours remaining).

NonStop x86 passes also. Thank you.

