Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22BB91F4DD
	for <e@80x24.org>; Fri,  1 Sep 2017 23:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbdIAXDP (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 19:03:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:63963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752537AbdIAXDO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 19:03:14 -0400
Received: from virtualbox ([37.201.193.79]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LuOYx-1dOeAi28Fr-011nAM; Sat, 02
 Sep 2017 01:03:11 +0200
Date:   Sat, 2 Sep 2017 01:03:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Kevin Daudt <me@ikke.info>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc/for-each-ref: explicitly specify option names
In-Reply-To: <20170901144931.26114-1-me@ikke.info>
Message-ID: <alpine.DEB.2.21.1.1709020102490.4132@virtualbox>
References: <20170901144931.26114-1-me@ikke.info>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3LFwPrLpWcc2X3axANrHoy5pIIwGsehA6EgbZ+LD+qsJbNHKuOX
 veI16wGZlWiavyTmzOoxB0RTU7yev07oecpmcW4OMJ0B7qZR5Wq4EqY68ZrJg4bC7liLBny
 h6WPaBj6efceXdtRqiaczbUcxlfUywWPjZopMXUPYD5W8YsMIrz7vQmVK2mmIks8uIGSXj1
 Uo9DyfhoQEI+e1RgOsfCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bY174997IFk=:6uCw55yz/0qs7s5I8FWKPo
 99l3wU0qG0yWtUp4f9pEiMTz62VeIEp8lQw1OqI84cKoohcK+avgbN839TkrWRK7tCEv48yTV
 j5XWaFr4eqkSO//9blYJAXwJZySjD3aXlM66ZPoDKjHWJ3ckqmh1SgsF1CJi8U+rkShVOYr+C
 oPfDYTmcZ31xWPG7l80JqYUS1VELiyXvBhftPg8Ha4hyP+dGwdoC80X+G9KnLccmE8+L/376h
 OVDqCetxSW1ytoDJOGEU5m3beIUISZgV7Oc5Uybe2tp+ojQ8WUT50HjXRsak1rc2cfP9e3QLB
 WfQG11aLJaZZ08gvzUT8+p0OaOH12xm7uJfLElmsQ6GsHZgj1G1JbT8AyDyxdRqzxyApoTckJ
 a9EAyKWfyOKX/57T/VR3OH1UlT6lrVPbXXw68a9FeMbDfFdp7FkGHLmFc6xrUvcnVvUfJAMVN
 RLKG47YQvUjhs4E7FFzD2vHpfb18PRYLtjgpaYNlIgoHVqZO+sfWvXa7kgGwv2NlDQ+jjCj3n
 EimrTnOVZ64IMDWrWNGV/3U4vC2KJUMLM70gkWkTBzOHVyfgZlJFNZnNkK3PcPRQPd8LcwWxe
 WV7p0Zhw5ocDcnJ61ICDg5zDQlcGwrqFokc8pYcBdrujadlasO/JszbIsyLNiX+MQ44CmJU61
 +ihW2CRhB+M+ZdLsn4q4CKaxEVu3Fg5oxpxprD6EoujcG9nZ8Hj0Fbzccag3JhHDlekZn5yA9
 Vx7S6VoEG7ZUw8WrZg533pWls/cgwmAUnb+XUV42Y3wQm+HM87J+HcB8kMp830azM09CijfIi
 fSFU4vD/A6anCgAOd2jy1HPhWmBq091QOb8VFxt7lkySonMwoKLapqRIAnMtnVtrgIrsFRz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kevin,

On Fri, 1 Sep 2017, Kevin Daudt wrote:

> For count, sort and format, only the argument names were listed under
> OPTIONS, not the option names.
> 
> Add the option names to make it clear the options exist
> 
> Signed-off-by: Kevin Daudt <me@ikke.info>
> ---

This patch makes sense to me.

Thanks,
Johannes
