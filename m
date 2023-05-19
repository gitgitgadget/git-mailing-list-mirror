Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB6AC7EE26
	for <git@archiver.kernel.org>; Fri, 19 May 2023 18:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjESSFm convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 19 May 2023 14:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjESSFj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 14:05:39 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB409107
        for <git@vger.kernel.org>; Fri, 19 May 2023 11:05:38 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 34JI4Hvm3280528
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 18:04:17 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqedncqkzf.fsf@gitster.g>
In-Reply-To: <xmqqedncqkzf.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.41.0-rc1
Date:   Fri, 19 May 2023 14:05:28 -0400
Organization: Nexbridge Inc.
Message-ID: <006901d98a7c$81d5a3a0$8580eae0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFng4JSClOdHVWgTX/ctFnUudpWO7BF783w
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, May 19, 2023 1:39 PM, Junio C Hamano wrote:
>A release candidate Git v2.41.0-rc1 is now available for testing at the usual places.  It
>is comprised of 516 non-merge commits since v2.40.0, contributed by 79 people, 24
>of which are new faces [*].
>
>The tarballs are found at:
>
>    https://www.kernel.org/pub/software/scm/git/testing/
>
>The following public repositories all have a copy of the 'v2.41.0-rc1' tag and the
>'master' branch that the tag points at... <snip>

The build succeeded on NonStop x86. Testing has started. Will report back when done (tomorrow-ish).
Thank for the hard work.
Regards,
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



