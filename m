Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4F6F1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 14:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757222AbdCXOVr (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 10:21:47 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:64001 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753072AbdCXOVp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 10:21:45 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue101 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0LjrTN-1cKH8E0jO5-00boyq; Fri, 24 Mar 2017 15:21:31 +0100
Subject: Re: [PATCH v3 2/2] l10n: Add git-add.txt to localized man pages
To:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20170312200248.3610-1-jn.avila@free.fr>
 <20170320210225.13046-1-jn.avila@free.fr>
 <20170320210225.13046-3-jn.avila@free.fr>
 <xmqqpohbtxi3.fsf@gitster.mtv.corp.google.com>
 <5036581a-f989-2db6-06ba-621db05c6de1@free.fr>
 <xmqqpoh9kx5q.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZBq+dL7hEj108DPU5KbVeJX2nYEw88jS0Eq78GxzCabA@mail.gmail.com>
 <xmqq1stpkun7.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZUAQ1sR0d0=KtkbWprO9VmpHO2SFFW7AYMS=wwaKjLtw@mail.gmail.com>
Cc:     =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>,
        git <git@vger.kernel.org>, Jiang Xin <worldhello.net@gmail.com>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <29db2bb2-e244-6848-32fd-9ea5434c55e9@grubix.eu>
Date:   Fri, 24 Mar 2017 15:21:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZUAQ1sR0d0=KtkbWprO9VmpHO2SFFW7AYMS=wwaKjLtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:iSyh8NhfurI5jSZwd4EX8sjUpbE4i9l4JeEfPBzeiVPEKPgUCZK
 Ey8Ov2O75LdpsKTuCha4nJGrmMWff+i+9nNRGLe5U0RhnqF4Q+sEfVniOZ69kgnBfA2BtqB
 /37iGo8ZXI18yRwWXQQlFxdOlU4t73o9GfrIk+vedKS1BuYQR33hpHXMnIzi3LQSmzvh7mq
 ZKXAx0jpWY54I2eVjDBkw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DLbwAllxgok=:E3L/rbue4hRwUM/BmPMt5Y
 1yrARyWOqzxfItkxUvWqUXQXek1P9m2F0Y3D4Z10PqFuNx+QlDIHHQXLlftxXStbWniIEC58p
 Ar/wqNHAD0AoqZdkUG0ztFjJ/JvW2dn1fe3FvdIDoEEtz2LnpojU8K63WV/SnQMsIlkrKqYu9
 /9R1X58apw0YjVQSMspDeHoG+VvyT3VWWGZcs0OOJ9DP0mUhYUHyWSeUkYr/doGUI7RzfXQ4P
 FWnewfRGLnHTjw8/6DyyS472ad5Kh002iHRSaJmMvKqiDVOdE2UUvs81uRR2MWzQu3yXcaZfF
 7hMMgdCsjOYANzQn2IjU4TubhD/LzV48v9v9pJz3zVJAQz2TB8r6EHxEakvZkOPxRpt/JNsi3
 I3lW81Kb2gBknBKQmX8CLB7ivo8g85gDtqwl6h8GD4z6DA5WX9NILyxloUZ4c4Dk4hIW8BSqw
 azVgtp1GveootQwne3bx+86dAVJ/NShkj1gQH7aOEqbPtU5QJR6ZeraCwFUh7XZV7pphdca0s
 jtiU0yTmJhRPl+ROn1BhkS2RRznqFZ05plq8noOtmj67lZwZi1+X9wJ3rnMV+/r2gLSiSI1Xk
 ICpZlNDyj6IeWo9NmBhyQFLOHrEwzhDsjA5gljIEI34hfhSEfyIatKWHeAynvVzMtD9TX534T
 2F61i9El7VlHG0NNPylyNNVY2F7CQlpWurgIUD6NTGN4QogMQGEK8ECvHb1s3iS/mKZp/HPIF
 boeAUlgOsW7h0yMX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller venit, vidit, dixit 22.03.2017 19:59:
> On Wed, Mar 22, 2017 at 11:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> So we'd want to be able to say:
>>>   "get a tarball including all submodules except the superproject"
>>>   (This would produce the "optional language pack tarball")
>>
>> You do not need that.  Just go to the gitman-l10n project and grab a
>> tarball out of it.
> 
> Oh, I misunderstood your proposal.
> You said: We have *one* submodule for all languages, but I understood
> we'd have a submodule for *each* language.

In general, submodules would remove the major gripe that I have with the
current organization, that is carrying out-of-date translations in tree.
submodules make it clear that git.git refers to a specific revision of
the translations.

Now, since not even git.pot is insync with the l10n mark-up in the code
base, I'm afraid everything in po qualifies for being externalized.
Junio's current "pull l10n" would be substituted by updating the l10n
submodule version that git.git references.

In turn, the l10n coordinator may want to update submodule versions for
each language rather than pulling updates. That would allow the space
savings for the common uni- or bilingual developper that we are after.
Recursive submodules, yeah ;)

I'm unsure whether we should/can treat translations of git and the man
pages the same. I tend to say yes (being unsure about the consequences),
as I would hope that translators would be the same so that we keep
consistency across several tranlations in one language.

Michael
