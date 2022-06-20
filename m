Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B46C43334
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 23:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345964AbiFTXRj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 19:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347341AbiFTXRF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 19:17:05 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F3127B2C
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 16:13:20 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 25KNDIVU074230
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 20 Jun 2022 19:13:18 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Stephen Smith'" <ischis2@cox.net>, "'git'" <git@vger.kernel.org>
References: <12011256.O9o76ZdvQC@thunderbird>
In-Reply-To: <12011256.O9o76ZdvQC@thunderbird>
Subject: RE: SHA-256 transition
Date:   Mon, 20 Jun 2022 19:13:12 -0400
Organization: Nexbridge Inc.
Message-ID: <00e601d884fb$53ccfb70$fb66f250$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKdzPESrq0KdVHDZKCsGYSrLnv73qvOXI2Q
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 20, 2022 6:51 PM, Stephen Smith wrote:
>What is the current status of the SHA-1 to SHA-256 transition?   Is the
>transition far enough along that users should start changing over to the
new
>format?

I had the same question at a conference last week. Could not answer it so am
curious about the plan.


