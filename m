Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E540F1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 14:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeA3Osk (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 09:48:40 -0500
Received: from mout.perfora.net ([74.208.4.197]:64830 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751197AbeA3Osj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 09:48:39 -0500
Received: from [192.168.1.104] ([194.237.255.67]) by mrelay.perfora.net
 (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MS3lE-1eJ03g2j7K-00TOgD
 for <git@vger.kernel.org>; Tue, 30 Jan 2018 15:48:39 +0100
Subject: Re: Location limits on development, staging and production
 environments
Cc:     Git Mailing List <git@vger.kernel.org>
References: <baf15388-adb4-ddce-889f-3e71b1574044@meddatainc.com>
 <CAGyf7-GeEaCFeY7q3=-7cN6aLaWUBwbNAMAbtfHw6ZXanAy3hw@mail.gmail.com>
From:   H <agents@meddatainc.com>
Message-ID: <e737ea6f-493f-f6e4-7491-ee9c19609ee2@meddatainc.com>
Date:   Tue, 30 Jan 2018 15:48:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAGyf7-GeEaCFeY7q3=-7cN6aLaWUBwbNAMAbtfHw6ZXanAy3hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K0:9uMx2RTV4LIwekZIs/1ZQGOQPt/klCgOz2iu1P1lI5Q4U6/swCj
 qt8NR1JOnngZQpb8vCAxckDtL4kscVDahRMEAfYlpvzFnH/B7YS/siNw5st7jKaMbWJ+Q0F
 IOxcdCf1YUq5qz9dS49nt9bcdf92Y1CP/o1BEdFR9+L5uxSzwV2pd3s+wHocDL3aUz8/q6M
 Q709Pns/GzHZyGx2DnGsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q2HDoRsXUws=:a2Cs+H/evHxfSpBJ+ydsnR
 YV5WBiZk9Zv8K882DKz37S2N28MDTByE9CBGuMHzQApOiJETlH2yXzvDffrG4fxst21BC0nsV
 jM79/3ejyOgNGDGcbTkvPsf89uJ/7JVT4zH/KNxJUpSlUAG2/uXnNfS21wMdU9OOvnZ1FAttg
 4uR7ILGj0Hzb04OtMORoaxfp/ycK9fAyibhcrLtErGJsVX1X0JQtdcDsmpr9v3CQkOkAnJE/q
 DjyjVy3flGODZ73pE2k7cF9evhvVDp0x5f3Z3I4hx7ESmJ3xfODQDg3kKp4cxH+Vgz4po3Ame
 BZLZXUIdCPFBCIQlOxYPIskwY/N/qkUrLFfc/vjzxroqMTj9D5WtDRyXMKkgjIUztg1utcxmM
 1jDKYLcd+bnDd2F1dfR9Z4UeOHuJt0LYjisZ521kS3guz8HcAL4efYnGB6x+NAez7m8HIZHvr
 HNf7ZqTfIVIzNDU9l7ooPRJ8NeRxHAbbRakPamZxoXVfx4lzr1N4CkAai8UDXFNA8GO/1CFVD
 7pEDjQxTZuMmEkaGjmNByvpEEc+/QXT8rvRVzYQJq7su92v5uYdA/HzeZxXhP3IStRdjS1Shd
 hUiYx0ykpAt/pwvs1qEmC0QZIzOFCpvcsl+Dp6AEKoxnT2eKMZKi14oaHiBSqkWM7YbGX4Vqn
 aqWVQqv2Y4c0ouDRfBO+dRe+wVMwugguIqBQm9D9zbo7jibjOk3BRUjNlKFauxh8htZUze6nt
 H+9GOxrBcYAawJU+LrCo+vlkVF9jGA5I0NlGWWwSdVBZIO5DzD8kBm9SqkA=
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/29/2018 10:02 PM, Bryan Turner wrote:
> On Mon, Jan 29, 2018 at 11:08 AM, H <agents@meddatainc.com> wrote:
>> I am a newcomer to git looking to set up a web development environment where individual computers are used for development, the development.git, staging.git and production.git repositories are stored on an external server reachable by password-less ssh and the staging and production websites are on yet another server, also reachable by password-less ssh from the git-server (and the development machines).
>>
>> Locating the three git repositories on an external server works fine but I have not been able to have the staging and production deployment files on another server. I believe this is what is referred by GIT_WORK_TREE and based on what I found on the web I created a post-receive hook of staging.git with the two lines:
>>
>> #!/bin/sh
>> GIT_WORK_TREE=user@1.2.3.4:/var/www/html/dev.whatever git checkout -f master
>>
>> I believe this should deploy the files from the development work tree.
>>
>> The above, however, fails. Should it work? I am running git 1.7.1 on CentOS 6.
> No, I wouldn't expect that to work. GIT_WORK_TREE is not remote-aware
> in that way. It's expected to be a normal-ish filesystem path.
>
> Based on your description, and the hook you've written, it seems like
> your intention is for the source to automatically be fetched and
> checked out on the staging environment after each push. (This is
> dangerous, and likely _not_ what you actually want, but I'll get to
> that in a moment.)
>
> One option would be to setup something like NFS, so the git-server can
> mount the filesystems from the staging and production nodes.
>
> A different, likely better, option would be to have the post-receive
> script on the git-server use straight ssh to trigger a checkout script
> on the staging server, e.g.:
> #!/bin/sh
> ssh example@staging-server -C /opt/deploy-staging.sh
>
> Your deploy-staging script would then do something like:
> #!/bin/sh
> GIT_WORK_TREE=/var/www/html/dev.whatever git pull origin
>
> That said, though, having such a simple script is dangerous because
> Git is fully capable of having receiving multiple pushes concurrently,
> and they can all succeed as long as they're updating different
> branches. Since your script isn't considering what branches were
> changed by the push, it could end up triggering simultaneous git
> processes on the staging server all attempting to deploy concurrently.
>
> The stdin for the post-receive hook receives details about which refs
> were changed, and you'll likely want to update your script to parse
> stdin and only try to deploy staging if a specific, relevant branch
> (master in your example) has changed.
>
> Lastly, I'll note that using post-receive will make the pushing
> (remote) user wait while the staging server is deployed. If that
> process is likely to take very long, you might want to decouple the
> two somehow.
>
> Hope this helps!

I should perhaps also have mentioned that although I am the only developer, I may use different computers to develop on. IOW, there should not be any conflict due to code being pushed by multiple developers.

Let's see if I understand this correctly:

- Unless NFS is used, the git archive and the deployment of the website code in this case should reside on the same computer.

- The combination of the checkout script and the deploy-staging script should work provided not multiple updates to the same branch are pushed at the same time.

I will try this later today but any other hints or suggestions you may have would be greatly appreciated!

