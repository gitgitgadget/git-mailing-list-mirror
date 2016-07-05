Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EF132023C
	for <e@80x24.org>; Tue,  5 Jul 2016 10:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754460AbcGEKCM (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 06:02:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:61398 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754226AbcGEKCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 06:02:09 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Ldttv-1bjqNL4Aq3-00j35E; Tue, 05 Jul 2016 12:02:05
 +0200
Date:	Tue, 5 Jul 2016 12:02:03 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	tarun patanwar <patanwar.tarun@gmail.com>
cc:	git@vger.kernel.org
Subject: Re: GIT Integration with Siebel
In-Reply-To: <CAKK2_6ezVLd4ZMa4ToKZYq1Ab0Y5w3VJqj_8-BsUCj8Gf8f+ig@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607051200590.8378@virtualbox>
References: <CAKK2_6ezVLd4ZMa4ToKZYq1Ab0Y5w3VJqj_8-BsUCj8Gf8f+ig@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9XaVwgCoRIhW9vq0aU1cCTM5cRPfefbAKISts9ncFJo2Ok5ARqA
 6R1rxSa2XyUJbTtIx/PJjhnMovh6wt2zNmzsG98xOsJ5Kh7Aw1BkQB0XQ2IWVrhScEU0Biu
 pHptlQop2tI9kDFA/PNBjl8qfQzk2xgpL33vdUelml/6TmLIS+e+vTSdWam+/DcZ7Tq3b+2
 iewIM4nyqB33TaKH6/lSg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:SEBnTCYvD5A=:YiwpkFHKCOQnyEEUUKFRAo
 NHXxGtMzkxEifnFv0U+ggT3Gr8n7XsJOM0HQtJRcIu9Fm9nYfwm5mBrMbDWPvHwccA5TJTb8S
 f3PBTKOkORZ/UngOk+Vj0bT5J49SlWEFVrSwanEe4EXGO/aPIhmByqV27QM9dI45lhUsc/ElK
 t1VzUFQMW71ntP/w9UpVrcdv3w5Hvx55nzopCVP00AW55G2WV1Kdlrgbd019fYHtns3wvDPEa
 3+P3Do0n3yTlzHGBKPtFyiXVq4xv2XsqUQieq9kkhBYnlL/GpoaU1U5hRGaRv2w8h0CKeWeQE
 7DT4Fhw1p0sOrqYro+ij3zItzdeZuPb3rJyOrWGcUgLV9clXMvlt4o9+R/vApnxanQ9z64Zo5
 /o+0cOFNCDW/nrxXtJ4mUbp8/s39/Y6bgW3LjkH1wUDuSgu6MyyTDxinyoiOnz86y1WcSW/wW
 06k8jcxyKN4KE70Q/jalY4O6SmDDWhweI9S8EcMTX3NMm/icqjNLZvd8DbAAcvgjRSjhowpsI
 0vdhSywLXjedpCw6YRI0s2jOs/X0n7zebfyYI2MxLvSZPHdRwRrMbq8OXsFho5XKXzjCCB4vA
 /AovufPMG/6MTGcqudQlPWyUm/ty6NQ7HEG3+5Q4iXh6qg7AhmpNQrHnXWucvjBdHezA16ejx
 oixr0jjPvjUzUcMOgNDSHGV1Z9PeSLcjBWxjw5IY7IXHgCV3EY9tF56W22zVXEYjmd2E0On5O
 lkQ7omxaSZZiqDXdDbXzQbTXBaqYRro7CW6vLyUiLHtxxI+UPsEXK/cJwIOnkzLXYwvkX6uCz
 mCT9IKQ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Tarun,

On Tue, 5 Jul 2016, tarun patanwar wrote:

> We are trying to integrate GIT with Siebel 8.1 for source code control.
> We are not able to progress further since there seems to be no
> documentation available for the same.

Would you kindly explain what Siebel is, and what purpose the batch file
you want to adapt is supposed to serve?

Ciao,
Johannes
