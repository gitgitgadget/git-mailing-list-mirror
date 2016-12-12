Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92936206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 18:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752869AbcLLSMu (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 13:12:50 -0500
Received: from mout.web.de ([217.72.192.78]:57706 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752337AbcLLSMt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 13:12:49 -0500
Received: from birne12.local ([195.252.60.88]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPYNR-1cLC3A0RuL-004jPO; Mon, 12
 Dec 2016 19:12:45 +0100
Subject: Re: [PATCH 1/3] update_unicode.sh: update the uniset repo if it
 exists
To:     Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <1481499265-18361-1-git-send-email-dev+git@drbeat.li>
 <64bc846c-0304-dd7b-73bf-a6c3a4135381@web.de>
 <c96d013c38df7737cfd551a0fce87314@drbeat.li>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <ca10a51a-0fab-e4a4-8d7d-035673af4c06@web.de>
Date:   Mon, 12 Dec 2016 19:12:38 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <c96d013c38df7737cfd551a0fce87314@drbeat.li>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:jE9iqJyiI/BnSA4m1p2dcChUey0dDwq2k5x4qXf5s7+zcHXLAHw
 EJqRYGQQR2QH4kDan2lxo7OjLJVcfXz/JQu/6Fhnx25QV+Ht2ud7Hq/5gOD7I0jTT6MRunE
 XwUxY/sJ4MPwTLxOrlNwteiQHkZjeh0lQiuZpW+iVHv1g60hEcFRnjkYg7XuW8GvRGKnYDY
 gzttyXsAy5ilIL4UWjORA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ij9ajMmGn8A=:J5NQXI7rISPcf3CS8oXIoI
 LB6617DsTzPhGImLvlN2VzEjF/DjGjGSPwSMaH913E6zPNXHtLPsJ11CynAfT3QuRLqFpRF/8
 JWECw9eZvfoGS9xUgk29gAuXLeexG3RHXi00Uq2ebLAGCj/GmPSj6PouqMAPsMTzulXEltYGe
 3BeUst2sfvuU2/xzvvGQDLkxBoNq88lsv3xCRgNXSiq0XYlqOmlV0CgnLf5MZMhjalF0Wbgbh
 +6ZzG2QuXyLPZOCm7extaKa8hYkTbdegqVV0lFO6H1Vgh2eOG6yn1sjOYyXtZ6st4e4aDampk
 9p97UoCbcKjqfyiFXQyiUB2d5mExZO78gaKEXAE2UbCpm2pwtnhEoFOP4iFi9w6UNvOVduV8h
 38dXwgzQ8a4igSlFE1DNoTBg4rqHTVBGXygA65wXKdrr8MGb7R/b0+3d5osxLhrTEEhN4W83K
 Uo1v8PQu4y+EqwAGoBInvDnl/CmXoH7lPAKRkwivUEBDz9ZFnWKcVNaWqsZlq0QB0h6aI5dbC
 lOoNFXRq7qS1md3VHzaBfXzsiNvi07lX0tZ58k33EjB/JS5C5hbqOU+kVMMg1WM5xpbSjYWlO
 oj51wTn/759RR72WoB/BTjVajSmTuckX8+rwZGRg5REc32EB/2g2WFziqiai8RK37QUCjOgcW
 3qQX+rBSLh8dATOT+/J4DWlTMVUI95uw9XT21he/XksYEh95aCvZ0sj/qbL2+mBzt0dgMlFYH
 5Vb2UgLNKj+tZee7COj4weBbiWhlJ7qm46TQWJOApE0ySlCMrs69Oo6fflWCVJj63nkRDLSvp
 YvmW1Xs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


>> Minor question, especially to the next commit:
>> Should we make sure to checkout the exact version, which has been tested?
>> In this case  cb97792880625e24a9f581412d03659091a0e54f
>>
>> And this is for both a fresh clone and the git pull
>> needs to be replaced by
>> git fetch && git checkout cb97792880625e24a9f581412d03659091a0e54f
>>
>>
>> (Which of course is a shell variable)
> 
> I was actually wondering what the policy was for adding submodules to the Git repo,
> but then decided against it. Another option would be to fork uniset on GitHub and
> just let it stay on a working commit.
> 
> Junio, what's your stance on this?
> 
> Beat

If I run  ./update_unicode.sh on the latest master of   https://github.com/depp/uniset.git ,
commit  a5fac4a091857dd5429cc2d, I get a diff in  unicode_width.h like this:

-{ 0x0300, 0x036F },

+{ 768, 879 },

IOW, all hex values are printed as decimal values.
Not a problem for the compiler, but for the human
to check the unicode tables.

So I think we should "pin" the version of uniset.

