Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19EC8207D6
	for <e@80x24.org>; Wed,  3 May 2017 09:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752988AbdECJrv (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 05:47:51 -0400
Received: from mout.gmx.net ([212.227.15.15]:54392 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752467AbdECJru (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 05:47:50 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9JYE-1dE4Mf2cNK-00Cg4x; Wed, 03
 May 2017 11:47:47 +0200
Date:   Wed, 3 May 2017 11:47:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     ankostis <ankostis@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: CYGWIN git cannot install python packages with pip
In-Reply-To: <CA+dhYEX+GgEHnVBnLQqnNW99xpf9kWcataTTt3Ya6ivGFgscMw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1705031147040.3480@virtualbox>
References: <CA+dhYEX+GgEHnVBnLQqnNW99xpf9kWcataTTt3Ya6ivGFgscMw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:afBqMbzDVLIvaZFkCaFP9qv2WQc+HsqXpn9fMg8TFl74rhUVnde
 pcaq4Tu0iIULLZjlphh7VsNchtjKa/8n1HgY5E+Ptf1bjp03rP0411nLx/+AOCCjPE3SnQu
 iTAtbUwdqPg0tKj5VWCFZ8AZgrqJlYiw6HqgewSacCvRAcxjDa80CfNYJTladcBTIpKd77A
 uds4kYCjRj6vls3Ahs3pA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7RTp9CHFacQ=:jsqFlE0FNdDuD1iv3fIytF
 yLnvWQ+4Y2koExBTP3uslhL2oDyN7KSc3OpuYWpg8T7wWcaGlH1TniLp4nE1Lw66Eq7hDc1ae
 allREU7ifm3/0lr+rK2p/j8i4QkHm5A7BpobaGSTM+kMwPRaR0zWlEHUABxOsyjit/FL2ff/Y
 Try1n4hicR8EKv53C8kOrIWfTRuv0zgMJSKUItlaRYwjTJQxLEwxLGB/HOltv9svCA7R+OSd8
 XOrt9ruWLEAmAsPjD3jMb8yDDTgY8wXumJcVMke7TZrDWA7lgxx+EJaQOV6aqJJAaWM1FiKXC
 uRHvFXGK8NhOxWOsGMbjhYVhBHdG1z9hoLXNoWYQ3IJdAVqFjmJcEE4xdGpzpST4biLxVT+J8
 EH2VWduMTo7wQlH7UePjAc5fjj1ZQF6vW2OVTsr0KLMD5bZALYy/4htSGElRTQR2vOYxrug1v
 mNZaRsISIa+TdAfSIw6RQ3cQQxWGREogm2s8JDsptq/4GbWhMPyWmBA7qHRSt6kkaU9OWXKbg
 Fc+9mrFvzJaegtp+NQGDxfM9Nki2LI9vUspYWlvwhOYkxvCvS4FpX5H2e+iDAc0l+ZyqTGHo9
 FNlgAsS/jn+38/DNRKddtXJkEFzA8QbQyYKjhWVkmztU9mZZBOpx5g+rJm2vUUtCTgU01/xPm
 BJd+6eDoeBeGjYOjQoJE5OKyLe+1jpjCXxRSW6CZURC5qJzPJyiZ9isCnQM9nmhIZrMlOdHmx
 gmIyfQC04UmBjeAIsSPAK7pou99VSEHScRS7VlxZksEaZrGRuISfAC7RTuRWqkFozGuyTmuYh
 bRcZveI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


On Tue, 2 May 2017, ankostis wrote:

> On Windows, with Cygwin-git 02.12.2-1 the python command:
>
> [...]

You forgot to mention what python/pip you use (is it the Cygwin one, or a
standalone one?). Intentional?

Ciao,
Johannes
