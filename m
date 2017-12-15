Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B12531F407
	for <e@80x24.org>; Fri, 15 Dec 2017 12:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755293AbdLOMkG (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 07:40:06 -0500
Received: from mout.gmx.net ([212.227.17.21]:49442 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755048AbdLOMkG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 07:40:06 -0500
Received: from [192.168.0.129] ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M4kfR-1fF4Xy2hHZ-00z0EB; Fri, 15
 Dec 2017 13:39:59 +0100
Date:   Fri, 15 Dec 2017 13:39:58 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2017, #03; Wed, 13)
In-Reply-To: <xmqqzi6mutcc.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1712151339110.406@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <xmqqzi6mutcc.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1jJZI8p2QWUvFXxdyG9LIYlr1IHPXPYZ3aTHamGAKwI/7RAqhYS
 UWtin1EmeW7PDrJuejdD92QZcP0nNILHajUvkvGzA86mud6uZe/z737xABM2JVtBZGPxveM
 FtABOV1zvU3nJnZ/o0WsB8FXPgOHLrWLXWFMzOqtcydFhTI0bJg4XIOSmWEaisjrunUEs8u
 1hC5a3qtPNIsFPnVDx5tg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pIc9InXfd9I=:mJQXzLBvP/qH90ixdLu9B/
 VB1k5Y4HbgZ96aZfMRXvokzVs9H87Ah1DkrkXeOBAbiHYQTuf+S9dMNg/6sjt8hvnsTXp+muo
 Ls6NXD6iXnjw6CFgsbKeoQewgXLMhcW4dEDQegjHupWFWvi6HOauqVCJSPe2minVcbZM6g9XO
 yDSzyyL8iumptfvobFVO2JOqxUhRmjSISxtJHh67rhEaD/CK51QAR0ztsjZEmLVDfaiOADvk/
 aHP5mSOXmUcJG9tgHd1weQErOmRNbaR+AQNyF0/0Be+Zi6gu+1LdeqtaqJUgo9xg5w0NpwKnP
 j15zblQWXjemnD3pQSNkiGMHxHdDnoXl98zunmtrGlZ4CCRO6V5s6MK7WKx7OyN2z8j33RlNB
 gF8RKxHtKE8uuSStOtzsbYEJinC71z4mZqa3mDFs6hmE8gdKd4aoZDnenA2LLT2zUyxzVrP1c
 XHlFanbq4nBGa/8Cc+fWVvocs2F5qE7XW2xqrrXWju9IghGMI4qWWJHIHgBYswa+gOg6568Md
 cBG+4OhUWtTDgDHATQKBjobLU2b9wAhJw+wShgarXFLuJq5RCGKOm6PTGPJFsbQu5KWdCaZXp
 dbCjkapG7VyidiCYahQyQblBCTfZcf9JxjH9+ZDDrQ/lSosGNVZ7IpET/f/SdyQ3s9vWylyzZ
 HqCrmUmLp8MJ96C8agOZtWaMhRmbVKmooW4Dez+KL1smWOL4Gpgm35cUhLdqAG7GekxdxynZe
 cqvUckZXJxJm1KlUF1k9ii9lElX78+902lar0NuxpZcktBiSGiQEiwTPGd2om6zHdeOVM+Fkk
 oMVPqME1eGbLConXN/Db+LtxMMfuanyFylRteIWKsTsDkIAebU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 13 Dec 2017, Junio C Hamano wrote:

> * db/doc-workflows-neuter-the-maintainer (2017-12-08) 1 commit

I hope you do not mean this literally. There is no need to bring family
planning into a technical document.

Ciao,
Dscho
