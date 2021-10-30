Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4C0C433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22EC60273
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhJ3VnH convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 30 Oct 2021 17:43:07 -0400
Received: from elephants.elehost.com ([216.66.27.132]:43801 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhJ3VnG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:43:06 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 19ULeUdO024835
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 30 Oct 2021 17:40:32 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     <git-packagers@googlegroups.com>
References: <xmqqwnlve57e.fsf@gitster.g>
In-Reply-To: <xmqqwnlve57e.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.34.0-rc0
Date:   Sat, 30 Oct 2021 17:40:24 -0400
Organization: Nexbridge Inc.
Message-ID: <000001d7cdd6$c3ddd6f0$4b9984d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGC0uXhP1Aml3iWzkTHQ49D7QKvMayVorFA
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 29, 2021 8:18 PM, Junio C Hamano wrote:
> To: git@vger.kernel.org
> Cc: git-packagers@googlegroups.com
> Subject: [ANNOUNCE] Git v2.34.0-rc0
> 
> An early preview release Git v2.34.0-rc0 is now available for
> testing at the usual places.  It is comprised of 760 non-merge
> commits since v2.33.0, contributed by 86 people, 25 of which are
> new faces [*].
<snip>
> Carlo Marcelo Arenas Belón (23):
>       wrapper: remove xunsetenv()

The builds on NonStop are fixed. Releasing this to our CI system for testing. Thank you.
-Randall

