Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015F1C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 13:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238680AbiCGNsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 08:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiCGNsh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 08:48:37 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1388E03D
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 05:47:41 -0800 (PST)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 227DlblN038839
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 7 Mar 2022 08:47:37 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Firas REGAYEG'" <fregayeg@iga-tunisie.com>, <git@vger.kernel.org>
Cc:     "'Imed ZARROUK'" <izarrouk@iga-tunisie.com>
References: <DBAP191MB1308984738C90410C8B4C61782089@DBAP191MB1308.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <DBAP191MB1308984738C90410C8B4C61782089@DBAP191MB1308.EURP191.PROD.OUTLOOK.COM>
Subject: RE: Git - Git flow assistance
Date:   Mon, 7 Mar 2022 08:47:32 -0500
Organization: Nexbridge Inc.
Message-ID: <07ce01d83229$e80e9f70$b82bde50$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFwyNOCUzA7gqxTRUsoKj7MhcEODK2Cwdmw
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 7, 2022 8:16 AM, Firas REGAYEG wrote:
>I'm Git fan, I'm using it currently in my job. Git is awesome, I really
like it.
>
>I have an issue with git flow command and need some help please My problem
is:
>In my team we create branch names with a pattern:
>
>developer_identity/feature_or_bug /task_number-brief-description
>
>Now when I'm using the command it asks me to enter feature branches prefix
>with a suggestion "feature/", is there a way to use variables in the name
of
>branch?
>
>for example, a prefix like this one:
>
>developer_unique_id/
>
>=> We need to make a global variable as prefix in the branch name.
>
>If this isn't possible, is there another way to do something similar?

Is this being done in a git command directly or in some web UI (like
BitBucket)?
-Randall

