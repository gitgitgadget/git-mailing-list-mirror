Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88C1C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 22:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391818AbiDUWuh convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 21 Apr 2022 18:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbiDUWuf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 18:50:35 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E637246164
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 15:47:43 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23LMlejG099481
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 21 Apr 2022 18:47:40 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     <git-packagers@googlegroups.com>
References: <xmqqh76qz791.fsf@gitster.g>
In-Reply-To: <xmqqh76qz791.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.36.0
Date:   Thu, 21 Apr 2022 18:47:35 -0400
Organization: Nexbridge Inc.
Message-ID: <023e01d855d1$ceaf7240$6c0e56c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFUeO93BUHdWKKalC9KEFtFO1+sda4CsWCg
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 18, 2022 12:28 PM, Junio C Hamano wrote:
>The latest feature release Git v2.36.0 is now available at the
>usual places.  It is comprised of 717 non-merge commits since
>v2.35.0, contributed by 96 people, 26 of which are new faces [*].
>
>This release contains the same fixes as the recent maintenance
>releases to address CVE-2022-24765 as well.
>
>The tarballs are found at:
>
>    https://www.kernel.org/pub/software/scm/git/
>
>The following public repositories all have a copy of the 'v2.36.0'
>tag and the 'master' branch that the tag points at:
>
>  url = https://git.kernel.org/pub/scm/git/git
>  url = https://kernel.googlesource.com/pub/scm/git/git
>  url = git://repo.or.cz/alt-git.git
>  url = https://github.com/gitster/git

The NonStop builds for 2.36.0 are heading to the ITUGLIB website after passing their build/test cycle. Thanks all.
--Randall

