Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23A8D20248
	for <e@80x24.org>; Fri, 15 Mar 2019 15:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfCOPo2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 11:44:28 -0400
Received: from mout.gmx.net ([212.227.15.19]:45287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbfCOPo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 11:44:27 -0400
Received: from [192.168.0.129] ([37.201.192.41]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LsTDk-1gtdt62pXk-011x18; Fri, 15
 Mar 2019 16:44:20 +0100
Date:   Fri, 15 Mar 2019 16:44:04 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3] rebase: remove the rebase.useBuiltin setting
In-Reply-To: <20190315134548.24479-1-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903151643300.41@tvgsbejvaqbjf.bet>
References: <87ef79bho5.fsf@evledraar.gmail.com> <20190315134548.24479-1-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-722291273-1552664660=:41"
X-Provags-ID: V03:K1:BR3mv6jKpO+PsafYllfYROphHbZVEUqV0rTXurX0mf+Vu8WDXFj
 BabZ6wYzWzhUpZF0jBepNqTEvGnp8/Ivp9hIg9qycQxEU9EAsQI7hmxtkVNT3+lpfP5JrxW
 j/ava9ibakfwUIGlmymuUiizeibyd/CGtK+6PhLA42f0pa1YM2aj2Aei6fTxZyDdmoMCt8/
 LEHO3BSzwNh+y3KAOLBhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2SC6Z356jP8=:CTEvU4SRTn9aIQFihaSQay
 ycA0fJFDAZGTJ1YQJl0YbawNepUhlPfeG69g/A9Zzf92WQrT+miDZvPd1/CcweHv9QJOjNPx+
 M313F2EcwIhXchqDuFk98Td9xUooVc44+Fw+AuDLtkKMK7a1phTbBN/X6eboC2WkGbc0Qqk6o
 iFHY8A6dXDydO/ESuQ5IXQGUaP/xYYRMAqdoInNL3wGlIFFQwd6ZGGpyMgbfugT+N9qCtDggc
 DbSpdTpRKtzAPVME8PrWqgf3HfVhLptkGWY7NUdhVNI2+8bA5K8HxcD4jsLdJieixTFLFFOQ/
 QOIVN+p+OixVHm9GCFIDsrmC5GLEH1sD/xoKGSdVbZ4Z4TTYJC9tBqC17in9xF47+qyLdWeRy
 Kv7E0R1hdCYkJnJg30VIlFHEBliJqEW6Q2z2F/D8vVkkFU9bqxgQCA/+6cJr33VK56hS9UhIm
 nQ1cOc5DvQNV8HOEQH15HQixHhfHRyWK9LC+gSfN/Siu0S6sUdb9Br7fpxBjGl3Y/ARF9o4r4
 +ufYu8k6YN/fnfCdlIxJhMGWuGzE0CL8PQfGQGzHupnOlnhjS2j0W4MlQ0glqvfcsV+DrEaHJ
 4w+DjLrMrzugFeMh0hSx/HwI/lmEj4kX1tpXcqzY0DX2Tu0leAGDTxgh9Ci3/P9LUEr6MUbE0
 w/qt4V/Vgu1Lpc4DbT/dtsNDExrkaUWJURzvVUAhE3IxaCe13Vqunczesk+/jL4I0jqexPbZ3
 WdYIK7dbGRi6qHNqWakE8EXAuDidYO2LjRwpw2watCP57xmZsJcsWiJGMTZHOCwK4alK/N1HL
 EvHkfaGRKiMQspLX/h+uwIp/jEzAkiMkQKefNzvMZWGvnVDlRxJFBnjO8mQAgxOPo12UdN3ah
 f+eWlODURW6vWD9mi//kEHeNznurtjzFAssP93YMd4L7CdVvbAoTRRxasTMXEI1TRAjqRk9Lh
 8kc9fGWspVS8XioOWjENN2RS7adu8lC8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-722291273-1552664660=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Fri, 15 Mar 2019, Ævar Arnfjörð Bjarmason wrote:

> Remove the rebase.useBuiltin setting, which was added as an escape
> hatch to disable the builtin version of rebase first released with Git
> 2.20.
> 
> See [1] for the initial implementation of rebase.useBuiltin, and [2]
> and [3] for the documentation and corresponding
> GIT_TEST_REBASE_USE_BUILTIN option.
> 
> Carrying the legacy version is a maintenance burden as seen in
> 7e097e27d3 ("legacy-rebase: backport -C<n> and --whitespace=<option>
> checks", 2018-11-20) and 9aea5e9286 ("rebase: fix regression in
> rebase.useBuiltin=false test mode", 2019-02-13). Since the built-in
> version has been shown to be stable enough let's remove the legacy
> version.
> 
> As noted in [3] having use_builtin_rebase() shell out to get its
> config doesn't make any sense anymore, that was done for the purposes
> of spawning the legacy rebase without having modified any global
> state. Let's instead handle this case in rebase_config().
> 
> There's still a bunch of references to git-legacy-rebase in po/*.po,
> but those will be dealt with in time by the i18n effort.
> 
> Even though this configuration variable only existed for one release
> let's not entirely delete the entry from the docs, but note its
> absence. Individual versions of git tend to be around for a while due
> to distro packaging timelines, so e.g. if we're "lucky" a given
> version like 2.21 might be installed on say OSX for half a decade.
> 
> That'll mean some people probably setting this in config, and then
> when they later wonder if it's needed they can Google search the
> config option name or check it in git-config. It also allows us to
> refer to the docs from the warning for details.
> 
> 1. 55071ea248 ("rebase: start implementing it as a builtin",
>    2018-08-07)
> 2. d8d0a546f0 ("rebase doc: document rebase.useBuiltin", 2018-11-14)
> 3. 62c23938fa ("tests: add a special setup where rebase.useBuiltin is
>    off", 2018-11-14)
> 3. https://public-inbox.org/git/nycvar.QRO.7.76.6.1903141544110.41@tvgsbejvaqbjf.bet/
> ---

With the obviously intended SOB line: ACK!

Ciao,
Dscho
--8323328-722291273-1552664660=:41--
