Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92E9C433EF
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 14:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiDPOyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 10:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiDPOyU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 10:54:20 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D15E9967
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 07:51:47 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nfjm5-0002Tp-At;
        Sat, 16 Apr 2022 15:51:45 +0100
Message-ID: <0ddf91f4-2ea7-e77f-7342-38e4dd379286@iee.email>
Date:   Sat, 16 Apr 2022 15:51:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 1/1] Documentation/ToolsOnGit.txt: gather information
 about tools
Content-Language: en-GB
To:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        COGONI Guillaume <cogoni.guillaume@gmail.com>
Cc:     "derrickstolee@github.com" <derrickstolee@github.com>,
        "git.jonathan.bressat@gmail.com" <git.jonathan.bressat@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "guillaume.cogoni@gmail.com" <guillaume.cogoni@gmail.com>,
        "shaoxuan.yuan02@gmail.com" <shaoxuan.yuan02@gmail.com>
References: <CAA0Qn1tZxGR0cUi2JSJtTFYe2Nk9xoGuHkruji1-53-Fhokmig@mail.gmail.com>
 <20220416123433.28391-1-cogoni.guillaume@gmail.com>
 <63d7dc69656e47f7bc7bce4839711f32@SAMBXP02.univ-lyon1.fr>
 <0f8dbbd6-4d7b-4530-ec85-2eddfcdc9825@univ-lyon1.fr>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <0f8dbbd6-4d7b-4530-ec85-2eddfcdc9825@univ-lyon1.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/04/2022 14:25, Matthieu Moy wrote:
>
>> +== Summary
>> +
>> +This document aims to gather tools that have a README and/or scripts
>> in > +the GIT project.
>
> I don't think having a README should be the criterion here. To me the
> criterion should be "tools that may not work out of the box, but for
> which some explanation, configuration or script allow using the tool
> properly".

I'm of the view that a README is a positive indicator that there is some
informational value regarding the tool's use for developing Git being
made available. It doesn't always have to be code before it is of
assistance in developing Git.

Just my £0.02.
--
Philip
