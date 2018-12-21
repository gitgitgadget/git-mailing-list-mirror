Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA3F71F405
	for <e@80x24.org>; Fri, 21 Dec 2018 15:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732889AbeLUPzy (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 10:55:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:60295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731928AbeLUPzy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 10:55:54 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MbgWb-1gqeyw3xIL-00J6sI; Fri, 21
 Dec 2018 16:55:52 +0100
Date:   Fri, 21 Dec 2018 16:55:35 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     David Brown <david@davidwbrown.name>
cc:     git@vger.kernel.org
Subject: Re: Unable to install latest git version. Claims git process pid
 running
In-Reply-To: <d2bb51d06b263f5a4d60256e5c2ff33c@davidwbrown.name>
Message-ID: <nycvar.QRO.7.76.6.1812211652150.41@tvgsbejvaqbjf.bet>
References: <d2bb51d06b263f5a4d60256e5c2ff33c@davidwbrown.name>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IEQs9/nDP7VTxoCU3XgS5xqi0rbdSi5Yrh3bpZ5K7cHIxluipA8
 HqWkWos54Zniztd4JKqEcz4x2XcEbgrSPvxbrLKDij6cg9C3f4716yEP1gJ8V5PuxTNJX8P
 gMJCHm1vLbVotlL9uDHEmYuGP0J8vZKCjw/0B8hJx17vUYW5qVfo19ZKrQvjaFZrMoU4MwS
 dPuOcoZ+bK1QTr1Kafm2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EsrgVXxL1UE=:E9JMkqrVjuaWFj5r74wkvT
 PhdvtJ2L5G3iINQG3TnoSfnRi+jpWLWDYCmzZZ2rK/ZYildg6dypzU5mOAq2i0PV596c82aGc
 3br5Z27gMODbW4Y/4T3/kaWqRAwKdFRIzGrkY/d+FlSzSUUZDOdzCpLNdqMSYqOTLXvilF5N5
 Zlmv+76ZJS+ZgSScuwQgSvUGStkdCcQK9zuh56MwaQTbWwaA3tlX+roEFqoYIcZT4zu1GuBoN
 VPqDJJi6B3FCzEpwTCyG4V4nopARAjwwrbki2F6MIPxm4+Q2WnHmrpdAd0QFtulZsJ2VBeeGn
 qBP8Cdj6mRLmxZrusDzp41STrEg2lPUIXGPKxpVh8Nt0NPvGsr5J3hzO1nRHsNHOokbDBG+y2
 wgMmTx1GJ8+IFqGCh7niMXd6utqqoa2l4CKL1/N/DeuLPSMzfEs50btpJe7TRNqrrUdc+vk0h
 U1cs9lz3ehQQBzSNgCGVlGrW4qo279lgvB0yiBcU0tDVyQ50gSTHbn4kY6E0XfmBHrbAEZRAk
 k6owejV1+dYgtrGSLHOQa7l2LeuvIhnBm4+PSLpAEfXVPJ60UJjvqHFRa9JXC+h6/ep1ReRUy
 ga7OeKiHkbgFtIzQf1tOsLnpLbx1UBfM2AKxBitziEkM60Qt+rvjWLwgEEEBnJxWlEYR6I6Q9
 1q8JSfnPdwB3lJYUBDPhEc/M4zXz1P3dzYLXvgnMAUp9cN4g27Plj/uWhAsaA/OFlisrD6hmo
 Kdk4YLGXaqEKnOM4l7wkADU6YKxzIxWH4mRrMunb6Ic4xkPbbukk3tqtQJR3+utAao8KNgWJZ
 wQUQ+TdmQ5Z3KO2qgOCjSI2vzBPWQz6RXvUlY9KMcITaDo+rdoMxz4gOdjavGXJ7/GN7iCac0
 vQm6UjPyjKHnSDFzVg/iuetJvnxlvTWwDYlN+JiGgJOGaQSv2jB+dxOef0ZMkI6MLt1BhACk2
 KaBH9WNQdaQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 20 Dec 2018, David Brown wrote:

>  - [ ] I was not able to find an
> [open](https://github.com/git-for-windows/git/issues?q=is%3Aopen) or
> [closed](https://github.com/git-for-windows/git/issues?q=is%3Aclosed) issue
> matching what I'm seeing

That's a new one. I saw many bug reporters simply deleting the issue
reporting template at https://github.com/git-for-windows/git/issues/new
(and usually then filing only very little information, definitely not
enough to make sense of the bug report), but I never saw this bug
reporting template being used to report a Git for Windows bug to the Git
mailing list yet ;-)

> ### Setup
> 
>  - Which version of Git for Windows are you using? Is it 32-bit or 64-bit?
> 
> $ git --version --build-options
> 
> git version 2.20.0.windows.1 cpu: x86_64 built from commit:
> 95155834166f64fe9666f2c0a4909f076080893a
> sizeof-long: 4
> sizeof-size_t: 8 **
> 
>  - Which version of Windows are you running? Vista, 7, 8, 10? Is it 32-bit or
> 64-bit?
> 
> $ cmd.exe /c ver
> 
> ** Microsoft Windows [Version 6.1.7601] **
> 
>  - What options did you set as part of the installation? Or did you choose the
>    defaults?
> 
> # One of the following:
> 
> $ cat /etc/install-options.txt Editor Option: VIM Custom Editor Path:
> Path Option: BashOnly
> SSH Option: OpenSSH
> CURL Option: WinSSL
> CRLF Option: CRLFAlways
> Bash Terminal Option: MinTTY
> Performance Tweaks
> FSCache: Enabled
> Use Credential Manager: Enabled
> Enable Symlinks: Disabled
> 
>  - Any other interesting things about your environment that might be related
>    to the issue you're seeing?
> 
> ** A so-called VDI running on a Dell WYSE **
> 
> ### Details
> 
>  - Which terminal/shell are you running Git from? e.g
> Bash/CMD/PowerShell/other
> 
> ** Bash **
> 
>  - What commands did you run to trigger this issue? If you can provide a
>    [Minimal, Complete, and Verifiable
> example](http://stackoverflow.com/help/mcve)
>    this will help us understand the issue.
> 
> ** Windows git upgrade dialog **
> 
>  - What did you expect to occur after running these commands?
> 
> ** latest version of git installed **
> 
>  - What actually happened instead?
> 
> ** No such pid 10128 to close therefore cancel install **

This typically means that that process existed *at the time the installer
checked*. If it was a short-lived process, you can check again by clicking
that "Refresh" button on the lower left.

Ciao,
Johannes

> 
>  - If the probleminsert URL herey, can you provide the
>    URL to that repository to help us with testing?
> 
> ** Internal company url. Windows git install dialog is issue **
> 
