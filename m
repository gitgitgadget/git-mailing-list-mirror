Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FE5C7EE29
	for <git@archiver.kernel.org>; Thu, 25 May 2023 17:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbjEYR0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 May 2023 13:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjEYR0M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2023 13:26:12 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB66B6
        for <git@vger.kernel.org>; Thu, 25 May 2023 10:26:11 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 34PHOnqM355968
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 17:24:49 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Todd Zullinger'" <tmz@pobox.com>
Cc:     <git@vger.kernel.org>
References: <xmqqedn5fluv.fsf@gitster.g> <022501d98e94$68c671c0$3a535540$@nexbridge.com> <ZG6gbN04DfldoadD@pobox.com> <025c01d98f17$f4b3bca0$de1b35e0$@nexbridge.com> <ZG-PCFEIDURrRVLe@pobox.com>
In-Reply-To: <ZG-PCFEIDURrRVLe@pobox.com>
Subject: RE: [ANNOUNCE] Git v2.41.0-rc2
Date:   Thu, 25 May 2023 13:26:04 -0400
Organization: Nexbridge Inc.
Message-ID: <027501d98f2d$ff2c1680$fd844380$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKqBzO6zDBfHf12TijP/VCsWNlc4wEmtn0UApIPU2EBj1WUbQGMPGHArZOqrAA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, May 25, 2023 12:39 PM, Todd Zullinger wrote:
>rsbecker@nexbridge.com wrote:
>> Setting NO_TCLTK=NoThanks inhibits processing of some .po files. I do
>> not know whether that is intended. Can you advise
>
>I don't used the option, as the systems I build for have tcl/tk, but I
don't see where
>setting that would have an effect on .po files (apart from those in git-gui
or gitk-git,
>of course).

Those two are where the .po are unprocessed.

