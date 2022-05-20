Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBC0C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 16:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241143AbiETQWr convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 20 May 2022 12:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351562AbiETQWm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 12:22:42 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3D6170F13
        for <git@vger.kernel.org>; Fri, 20 May 2022 09:22:41 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 24KGMcVR008345
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 20 May 2022 12:22:38 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Alice Merrick'" <amerrick@google.com>,
        "'Emily Shaffer'" <emilyshaffer@google.com>
Cc:     "'Jonathan Nieder'" <jrnieder@gmail.com>,
        "'Git List'" <git@vger.kernel.org>,
        "'David Aguilar'" <davvid@gmail.com>
References: <CA+Yb-VSaeKy-g_ywkZzQuEX=k3EXM+Ky-rHOb2az0SHGVbdaVw@mail.gmail.com> <Ynndk0L6r9O7jLVU@google.com> <CAJoAoZ=t=BEfsfHBay1K7CY2MYEwcvPYKYxvgv_BvLL3SMcf_A@mail.gmail.com> <YoEnsb2UpDwdjDpd@google.com> <CAJoAoZnP47PT9EQYkNib9+_a-Qg=HxhjowgUx7qJ1V7=KY5iiA@mail.gmail.com> <CA+Yb-VQx2CMixGh6GExce9n=QxR-esuhPuuHwzfDKYNow4Zyzw@mail.gmail.com>
In-Reply-To: <CA+Yb-VQx2CMixGh6GExce9n=QxR-esuhPuuHwzfDKYNow4Zyzw@mail.gmail.com>
Subject: RE: Let's have a user experience workshop
Date:   Fri, 20 May 2022 12:22:33 -0400
Organization: Nexbridge Inc.
Message-ID: <028801d86c65$d2785db0$77691910$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFz2vmS2SKxDSIWIk7j/fBGjCh5MQHAbuKkApbb2NcBvxu0YgD9B1oeAhjL1W2tp7NIcA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 20, 2022 12:18 PM, Alice Merrick wrote:
>>"3. Testing ideas
>> with users" I would find it worrisome if getting user input would
>>require reviews on a given patch stalling out until the next monthly
>>meeting.  (Reviews are already slower than they should be as it is!)  I
>>don't know that that's what you meant to suggest; I'm just aiming to
>>understand what you mean about the "all 4" above.
>
>I agree, you wouldn't want to wait until something is in review to get user
>feedback or testing. I think a Lean UX
>(https://www.scaledagileframework.com/lean-ux/) approach would be more
>appropriate especially when there is no designated UX person. You might need to
>lean more heavily on design standards and instrumentation for feedback, but
>sessions with users would still be important for developing standards and could be
>used as needed if it's not possible to do them on a regular basis.
>
>> > > I'd envision it as something between a working group and a book
>> > > club - we could learn different aspects of UX design and research,
>> > > and apply them in various ways.
>
>I like this idea. A working group could work on developing design standards and
>work out what to measure and how to measure it.

I would imagine that some patch series do not directly impact UX while others do. Figuring out which are what might be a starting point. In some places, an API change would be UX - if the users are developers. Just a thought.
--Randall

