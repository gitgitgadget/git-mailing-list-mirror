Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B362201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 17:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbdCNR7i (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 13:59:38 -0400
Received: from mout.web.de ([212.227.15.4]:64380 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751653AbdCNR7h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 13:59:37 -0400
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MMIdp-1crQZX2ZEz-007zoh; Tue, 14
 Mar 2017 18:59:34 +0100
Subject: Re: fatal: Could not get current working directory: Permission denied
 | affected 2.10,2.11,2.12, but not 1.9.5 |
To:     Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>
References: <elvahoiwfqayelbskykd@qjih>
 <7d947891-ce40-23e7-2bc7-0f76dee53665@web.de> <hpulcgxossrwvfbbcvcl@zndn>
 <10cc42b8-0f63-2d97-8da1-2943970d63cc@web.de> <ogwsaxvtiqlsiwojzxul@owpk>
 <3ba0c8e3-894a-846f-ba99-dad1deba7cdf@web.de> <tskgutqgpyszzedvyfra@prol>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f2ab799f-5f0a-0ce0-0625-13513bc1973d@web.de>
Date:   Tue, 14 Mar 2017 18:59:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <tskgutqgpyszzedvyfra@prol>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:MhTpiGFoy6rKSKNYXh/PwPz+eFcmBuNGRJh40upZQg7JVXV9TZs
 Ylu1Bs/h92r8h7xACi6s/5wOfQAt/PEMjsa9EpCfu9rkwCC4i3fwEBxKxbBRpGHO25J4YCX
 xcjEz+D1rC1evGlnuPsz8fpS9bSMgXhJHNLy15xZleiI8CxzrXYnomjsuyWEemRjImAyxl7
 Tt9ylWlhaSj4AnhjW6ecA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WQ/x7LkCG1s=:hNN8J/3V2O+f/PtJlNuwmx
 mYYybe0cGKG7akFW1tbRFOCc3hD0whfRDQ0PuToni4NDT7vLHqA4RfJOdRwuoKBVs9WZhMPPW
 d/kxtY8SxQt55cHLemjemFG160ve7JW0P9Xu4egW6r5SMJg6woDGWpBKCzf00Rfo2z/DVMdpa
 ex5zfZTjw+sA+MrrTErnyun4T/3TTmQgsxa7wtCYaJ2LQt2mZdk8z13H80M+2x1xjTyug1/Cx
 uMk7QoM9rpSOTa9hst3O5gjEN1I3Dvjo7JqvxEkdRXcq6UKKybK1eeaXUJW+9PvTzKEc+K+bd
 HjebWTi7cQhxz1OyZjtDEwqcCQnh2Fo8BTPoterY2fLIs8vsazX8fvBCyLxBF9cwvKpk+GG3G
 SCzOaIkcAFHpwXpOcL4AS6qLfSkuwe/rEF7IiubPIElPDyLDz+jw5278aFFbakEf6ubXsGM/9
 CmBQhnF3Phalyp4ViZxucAdO0TqyMnaGNbh/Pb54O/ZjZ1vocClQkZOXZm3+AaFoqALrTd7ZN
 ag335vjFNOBoJQ6+2fYCLUDB90qAUMK4/F9xqdsHyzdLRQ4yWWErYfonNKrzOmlQfxVMu7CD9
 +VIcGL5kya34XcNkNzJepD8vJfOuLUpQGMNzgRKxeF9jm7TyxYlJqg1XLKH90WIyQaqZ51o1h
 fGVTg2B0ZaHzYfxeKU3S0ZLB0t8cyd1MzRa28pscgY2XkGe4FXkfgzKVWeXnXjrzMLPWNUuri
 7uy7DkW3tRveucum17qj7zTzObZZes47lu8idRnHYnYsVtjJBNszP4gAGS0zx8yC7NgFkMDTc
 cADci6z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.03.2017 um 08:44 schrieb Zenobiusz Kunegunda:
> Od: "René Scharfe" &lt;l.s.r@web.de> Do: "Zenobiusz Kunegunda"
> &lt;zenobiusz.kunegunda@interia.pl>; Wysłane: 22:31 Poniedziałek
> 2017-03-13 Temat: Re: fatal: Could not get current working directory:
> Permission denied | affected 2.10,2.11,2.12, but not 1.9.5 |
>
>>
>>> Am 13.03.2017 um 14:23 schrieb Zenobiusz Kunegunda: Bisecting: 0
>>> revisions left to test after this (roughly 0 steps)
>>> [a26bc613a64ac2c7ee69a50675e61b004a26382d] pretty.c: make
>>> git_pretty_formats_config return -1 on git_config_string failure
>>>
>>> This is what I found with git bisect
>>
>> Strange, I don't think git_pretty_formats_config() is even called
>> by git status.
>>
>> René
>>
>>
>
>
> a26bc613a64ac2c7ee69a50675e61b004a26382d - is actually working
> revision
>
> The question is - is git history linear enough for git bisect to
> produce any useful result? Gitk produces rather complicated diagram.
> Especially for year 2014. I'm not sure about reliability of this
> method. Or maybe it should be used in a specific way I'm not aware
> of. If you have any advices how to use it in this specific case,
> please let me know.

Ah, right, I didn't pay enough attention, sorry.  Step 0 is the last 
one, but you need to rate it as good or bad before reset presents the 
result.  History is not really linear in git's own repository.  But if 
you didn't reset bisect's status you may still be able to finish it by 
running "git bisect good a26bc613" now.

(And if that doesn't work then at least you now have a much quicker way 
to check using the long directory name..)

René
