Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B106207B3
	for <e@80x24.org>; Fri,  5 May 2017 15:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbdEEPZ2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 11:25:28 -0400
Received: from mout.web.de ([212.227.15.4]:63406 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751464AbdEEPZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 11:25:27 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mcnuz-1dObSq3oy9-00Hszc; Fri, 05
 May 2017 17:25:22 +0200
Subject: Re: not uptodate. Cannot merge
To:     "G. Sylvie Davies" <sylvie@bit-booster.com>,
        Git Users <git@vger.kernel.org>
References: <CAAj3zPzHiwgS=2CSKP1y8zGUxHUWiq9TSeMhixeL+9ZfffY-pw@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <8b15577d-f997-79b5-5a77-2a8c01e20cf7@web.de>
Date:   Fri, 5 May 2017 17:25:16 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAAj3zPzHiwgS=2CSKP1y8zGUxHUWiq9TSeMhixeL+9ZfffY-pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:bXVmBb7StiREVF1P+Rb4ubuNhnE6ynIBOkNQMF9RYa9/yFFAGC9
 15BtXyFdll9g2y9z3eIXOLlFgH4LaH1m/9va3L9KPYVF1KY1yfK+X4rdNlBXlBjjOlFF6D8
 wifL+RIkG1smxyco1Ok1X73OjSUbQmCdUE8EZU/Z+/9jfKes/rJXSuHaBKovUbIN7t8FjE5
 FTsYuSPjB+8RDprD25Jew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KikCclffqqo=:KmAmUM9ZBQrI7kF9lPOE+e
 5A/zOoJU3oZ6kPQ9OkPRknS4OJPYVU1UylfvgDpM23I/19H1QXMbbCGH/7b5pJ50fxPGBlp6h
 6Lk6We1g6qKQSqGdXzDHr6WeQroNA/1bX1hLGad04OzuJt5ppJ2itJmwkvp5Z6U4vLYznkjrY
 fttRgp4/kyfurL2W7x4q6IYHafXtS3xCi3Nj/AhC8taGP1/d9wNpSZjiohw/1I0FUawWAyHO5
 8sWczzsc5I/Z7FfcS9wwO/4ALL/YiUAxTcXE7mgTUfvOoAbexbUMNPfOGN1mywSurzPjMvGDm
 PRgGG23wEKKACcB1Tswv5PemklOJfy0r6KXhaIGZMNbrGd2w1lqsLdkrZQbQzaqDPyQJDL23u
 p/qI+jsYhoDZtRnTxNrUcQJ5eSNnl02XvLc92jZi++mZlO1LCjER07wUHa5BWqNJ/OoZaAaaX
 frYfXHj6IevTHhDUvMbBnAbFwFmEgaIelBID4CFiS4Jc5tYEZPvbiB4+tliEbTl9t9Emvoeq7
 c+FUaxyylzVbWWfwn6aRU/hZoAUDltJamxUjAgowjCpIa0VgpTncR06p1nCysde6MwqrF1CVM
 O/p43j6QPauILj/fhIfHW9E5i+yoJqXmGcNZEY3g2/D18NnOTRbOKqpe2XWHty6gyUFnbejMp
 jdL9N5j7Lx4VULMmX7WVPckKrYdSsek7KzGwbgvS/TAxGOhawAv+bYHNZNihaMGykLk+aqiYr
 gR44C/Wjfp9d8/T53+6xcO4zujq4Q7QPHn93WviFdl1qnELbgQ9cFm/2xUigTFjiCs1Z/AQSH
 JfWvofM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-05-04 23:40, G. Sylvie Davies wrote:
> Hi,
> 
> My little bitbucket "cherry-pick" button is failing on Windows from a
> "git reset --hard" blowing up.
> 
> My situation:  Git-2.10.2.windows.1 / Bitbucket-4.14.3 / Windows
> 10-10.0-amd64.   But I suspect even more recent Git will have the same
> problem.
> 
> Now, I'm pretty far from Kansas here as you'll see from my "git clone"
> invocation:
> 
> git.exe clone -c core.checkStat=minimal -c core.fileMode=false -c
> core.ignoreStat=true -c core.trustctime=false -c
> core.logAllRefUpdates=false --shared
> C:\Users\gsylvie\dev\bb\target\bitbucket\home\shared\data\repositories\1
> C:\Users\gsylvie\dev\bb\target\bitbucket\home\caches\bbClones\1
> 
> 
> Right after cloning I create a ".git/info/attributes" file containing
> just this one line:
> 
> * -text
This -may- be part of the problem.
In general, it is possible to add attributes on your local copy like
this, but it is not recommendet, at least not from me.
In general, the project should have a .gitattributes file, which
belongs to the project and which travels together with push and pull.
And of course, files should have been "normalized" and have LF in the repo.

In your case:
What does
git config core.autocrlf
say?

[]

