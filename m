Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5F192098B
	for <e@80x24.org>; Tue, 18 Oct 2016 11:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755806AbcJRLeV (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 07:34:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:64229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754276AbcJRLeU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 07:34:20 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LwGDy-1d1GK70etC-0184Bz; Tue, 18 Oct 2016 13:33:45
 +0200
Date:   Tue, 18 Oct 2016 13:33:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2016, #03; Tue, 11)
In-Reply-To: <xmqq7f96ykkc.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610181330430.197091@virtualbox>
References: <xmqq1szm8ukf.fsf@gitster.mtv.corp.google.com>        <CAGZ79kZu71+6QmvKgXJ5t+97jvTeAhSRtHpMQR9Rmk4Ep5RHhw@mail.gmail.com>        <xmqqk2de7e70.fsf@gitster.mtv.corp.google.com>        <alpine.DEB.2.20.1610131439400.197091@virtualbox>       
 <xmqqzim6zzc7.fsf@gitster.mtv.corp.google.com>        <alpine.DEB.2.20.1610151020480.197091@virtualbox> <xmqq7f96ykkc.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:morHcix6nZsrsCP+/oG3G3TG3M/VvnIi3s3tdGbTkhAu4i08Z5H
 PUMf5jRK7kLTMi4y4UsF4C08uMSHIUzdzR8sc66C59UgNp0wWwHxPdE9trWzFasg7EClNSQ
 gb1cFyQeaJG/Fy7HvMq0NvusV2tr32W1J4U4d7dZjcFSBv/yK9cLWxjV73C6qeCiizOqEqx
 Uw/ggwlx3HTuvJKCfcTuQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9C9gHAmBeJ0=:iCjnAd5C36e7tjGttvaq0p
 2d7LA6WFXp3cvE8ES5DU6yXhls99doaPShMjnwssh4vG1xS4HzY7GRCsG35wzDfYfP+S2l0er
 9ayBFmgD86/+jjTDy5kWe2UXymlLazeg6bM9N4cY1ryyKeynhUzIRSSA9z9CDktjef1oLAR8u
 ZauVANaNATJLJUbqZIhwWg4vG332NkUK4KXq0vIjU/RlY9C/iHsCzRwWh1sbjf5vy959U+c+b
 OkdSBUdGjO9W0JhbVfRuekBLsXhUH78V8sX1ptKpyhRddgDVKJ7/CFxrTChpxd3usvR/jCIpi
 DjTBuMxypnYl6ruBxlxrQOsQ2qBJL4bk8fakkQXMrDPSty/8BsCDKixcKPQNVwr/5pgdEs5Ny
 FPmC47GKu3ur2cw6i30WrYPq7rMh0gB5KYG0x/Qg7ZBPKkIue4zU4R90QAwUFqjWI7NCn+oQf
 Uae5aJ+1umnFj+P/xVVhPdkQc6n7tnnDyrMnsoaTWxBZUFY727sAuzD7nxNj82sF19Kmsh+Ju
 Dt27w6MqyerMWFcOGxlfFkdLmSALnOMJpdKoCQ7TML4aymqaxYjM0DLt/+AjXvmJbj9t7vKBb
 sGwgHBVM411nyQL6P1h8PvprIXjDyLML14b9cmERo+36vkTuYpTbOw0+cO9JKfDesOp7aOQ69
 yetOsqwYd2HzeQRt2L6kzUSVAWYtGEZb2y31iq7WfcCcMSSAIsilehy7pfpNfiv431zwUZHdI
 lCt0Y0XtMOPz3dYqWrXvVJfpIVXcPufugOAuTg1Mz7uuOjbNHbuFeoDlkLXFwxLemLha3nc64
 +Ni/Jlo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 17 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I'll mark it as "wait for follow-up fix" in whats-cooking.txt (on
> >> 'todo' branch) to remind myself not to merge it yet.
> >
> > May I request your guidance as to your preference how to proceed?  ...
> 
> I guess I didn't see this before I sent my response to the review
> thread, which was in my pile of "these need more thought than others
> before responding" topics.  
> 
> > Here are the options I see:
> >
> > A) remove the tests in question
> >
> > B) mark them as !MINGW instead
> >
> > C) change just those two tests from using `$PWD` (pseudo-Unix path) to
> >   `$(pwd)` (native path)
> >
> > I would like to hear your feedback about your preference, but not without
> > priming you a little bit by detailing my current opinion on the matter:
> >
> > While I think B) would be the easiest to read, C) would document the
> > expected behavior better. A) would feel to me like shrugging, i.e. the
> > lazy, wrong thing to do.
> >
> > What do you think?
> 
> As to my preference on tests, I guess what I suggested was a cross
> between your B and C below, and I can go with either one as an
> abbreviated version of my preference ;-) 
> 
> I am still wondering if the test is expecting the right behaviour,
> though.  If some codepaths rely on a question "please resolve '../.'
> relative to 'path/to/dir/.'" being answered as "that's path/to/dir
> itself", it smells to me that the downstream of the dataflow that
> expects such an answer, as well as the machinery that produces such
> an answer, are acting as two wrongs that happen to cancel each
> other.  Am I grossly misunderstanding what that test is doing?

I think your "let's take a step back" was spot on: when being passed a
path ending in "/." and being told to normalize the relative path "../."
on top, the very special meaning of "." should be taken into
consideration.

Thanks,
Dscho
