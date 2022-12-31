Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B18C4332F
	for <git@archiver.kernel.org>; Sat, 31 Dec 2022 22:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiLaWI7 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 31 Dec 2022 17:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLaWI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 17:08:57 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6371B31
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 14:08:56 -0800 (PST)
Received: from Mazikeen (ec2-35-183-135-208.ca-central-1.compute.amazonaws.com [35.183.135.208])
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2BVM8iw1077345
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 31 Dec 2022 17:08:45 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Filip Lipien'" <aaa@164.ooo>, <git@vger.kernel.org>
Cc:     <torvalds@linux-foundation.org>
References: <7hfRSnKTRnT4uJh5Pok8U8gfLm_NXzCS6w_7_Rc9OH3a9Lv8hpjySZqxDglBFC-fTOdZHi-ODCihiEHlQD9nIhUmld5jYvRx_JvB0z2IAL0=@164.ooo>
In-Reply-To: <7hfRSnKTRnT4uJh5Pok8U8gfLm_NXzCS6w_7_Rc9OH3a9Lv8hpjySZqxDglBFC-fTOdZHi-ODCihiEHlQD9nIhUmld5jYvRx_JvB0z2IAL0=@164.ooo>
Subject: RE: Request to remove Junio C Hamano as the Git Maintainer
Date:   Sat, 31 Dec 2022 17:08:39 -0500
Organization: Nexbridge Inc.
Message-ID: <001201d91d64$732e4e90$598aebb0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQK97OIf+77EERR77E0ZHrIZeusuvKy+7TiQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 31, 2022 1:11 PM, Filip Lipien wrote:
>There are more than one million questions on Stackoverflow related to the usage
>of Git.
>This is not normal.
>
>Git is in its current state not a tool that's made for humans.

Git is used by hundreds of thousands to millions of humans on a daily basis. It manages most of the popular operating system code and compilers and without git, CI/CD would (arguably) be where it was 20 years ago. Git is part of a critical supply chain, including automation, to deliver software to production servers and edge devices.

>It's realistic to assume, that millions of working hours were wasted due to his
>ignorance of developer experience.
>The financial damage goes into the billions.

Claims like this require extraordinary evidence; rather like claiming aliens are hacking our git repositories (they are not).

>I hereby request the removal of Junio C Hamano 濱野純 as the Git Maintainer.

I hereby strongly support Junio's continued participation and hope he is not disheartened by the OP request.

Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



