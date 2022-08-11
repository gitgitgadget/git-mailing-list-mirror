Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB38CC19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 22:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbiHKWNK convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 11 Aug 2022 18:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKWNI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 18:13:08 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C75A031E
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 15:13:07 -0700 (PDT)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 27BMD2YG037932
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Aug 2022 18:13:03 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     <git-packagers@googlegroups.com>
References: <xmqqedxmfyhe.fsf@gitster.g>
In-Reply-To: <xmqqedxmfyhe.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.37.2
Date:   Thu, 11 Aug 2022 18:12:56 -0400
Organization: Nexbridge Inc.
Message-ID: <00a901d8adcf$8682e370$9388aa50$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJuGbKJ0vZ3ztS36riUrbSEcLi1K6x/azzg
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 11, 2022 2:04 PM, Junio C Hamano wrote:
>The latest maintenance release Git v2.37.2 is now available at the usual places.

Builds for NonStop with various OpenSSL/Curl combinations are now in progress.

Thanks,
Randall

