Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 291C62018A
	for <e@80x24.org>; Tue, 28 Jun 2016 16:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbcF1QY3 (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 12:24:29 -0400
Received: from mout.gmx.net ([212.227.17.22]:65048 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018AbcF1QY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 12:24:28 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MIiHs-1bK8jA3Ydc-002KXz; Tue, 28 Jun 2016 18:24:08
 +0200
Date:	Tue, 28 Jun 2016 18:24:05 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <blees@dcon.de>, Stepan Kasal <kasal@ucw.cz>,
	Jeff King <peff@peff.net>, Lukas Fleischer <lfleischer@lfos.de>
Subject: Re: [PATCH] Remove obsolete comment from color.h
In-Reply-To: <xmqqinwt9v6e.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606281822240.12947@virtualbox>
References: <16f3d3edb03c2cb9a6c11b745eda9fb2274af182.1467108142.git.johannes.schindelin@gmx.de> <xmqqinwt9v6e.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jLBJsxwq4wSepyFxGBleR2Wz5LhlYsRDnQpf+wjMVVtHdBOaO5h
 nlcaVAbp41t+Hnr8pFFSkXwgFZmMMx+RbUODll59CNoe5L8h+lHaa1g5pveq7e25fm899ap
 ZW0K0f6W/KWe0bUZISasYmWDr3ZxdQdWFkNBfQJHAlFsD3cQw56JNVHgKwjrQWgqB6ePXzx
 tYsV6BZXDuLA2GXn2NnlA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:+OFtcMI4qI4=:r52SVmrODR7qk61NdtDeOM
 F59y9E10fHCynu36eux3HXTQ+XlYttnkpnXwB+sbB8DFpjeJ+4Ve0m3DXr7Qv7jEDhq/EqdbP
 B2kM4r5t2yBwYz0Fetn435GyRbRvXzzVx2vg9K3Oedxm3wj0NvWdh9Lq6pu0sIGtsZiA6SB8P
 8/HOCHd9PYlr9576mfyz28ZdNwEnZ4EjlSGVsqGxHjdyIHInM54PY/U06tkERyAp4tvfbWxxJ
 kTA45DIyynMppGDHR7M4ZFwiVcxx24Ce/4cEkvh68D+uMOOq0jD5zEvjSTlo2T3GetlZQqJp9
 3h2t1wYjaYYmncG1RgykPtVEvmfC0Kr4pufG8tmR2zFffpb+DUSHMIjjD/OHzYZe5doELrg9r
 tYpWkhRdtLQ+aUWLXvdHXZvlTgypHmIE1MqJuWzVHPWxAMWZrLyeNo5Fbx3O20pfWlpUiUCq/
 OYRo8T2ZIPBzZNxLbFoodsKJwjHXn/NK6HVWcY7vOQx/3WD2hqv7BjxAZgfeyTJ6qorUgK/YR
 rY9WJqrzFvXPAbZyfgeZ1agBErJctVAFW5VbSSK8Wc2bPiN1MWuCJvyjf7c9NIb5rxprbKNvB
 0/+HRqR8jYMHu2abu0pZ4n9QnmC2ysg3iRNKIuU/T1vVasHBMcq+etj4+wwRYQnVIkOE1B+KR
 Y+3xHAgzRo/Uxw2MGJuflZYZaT4OWYYyNsQaV5uIyAgXEVTs6UfuVZcwubmsmj8lElw+kKJas
 QojlTvOHaQtoIHbLTFIa74N6le0PX6FI/at63O+gUh7Y7ljlI8sgL+7Mc+8l16wOBfuLGSYMR
 L9FJJgr
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Tue, 28 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Originally, ANSI color sequences were supported on Windows only by
> > overriding the printf() and fprintf() functions, as mentioned in e7821d7
> > (Add a notice that only certain functions can print color escape codes,
> > 2009-11-27).
> >
> > As of eac14f8 (Win32: Thread-safe windows console output, 2012-01-14),
> > however, this is no longer the case, as the ANSI color sequence support
> > code needed to be replaced with a thread-safe version, one side effect
> > being that stdout and stderr handled no matter which function is used to
> > write to it.
> 
> So as long as we write via stdio to stdout/stderr, you can show
> colors?  Or is it now stronger, in that as long as we do anything
> that ends up writing to file descriptors 1 or 2, you can show
> colors?

It means that we override stdout/stderr with a pipe that is parsed for the
color sequences. If stdout or stderr are reopened later, this color
handling will not apply to the new file descriptor/stream.

Essentially, the caveat in color.h that one should use fprintf() and
printf() when outputting color sequences to a terminal no longer holds
true. fwrite() or write() work just as well.

Ciao,
Dscho
