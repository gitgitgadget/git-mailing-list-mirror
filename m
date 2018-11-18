Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA7FE1F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 17:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeKSDgP (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 22:36:15 -0500
Received: from mout.web.de ([212.227.17.12]:41035 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbeKSDgP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 22:36:15 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LcgZv-1fhhNq2CQx-00k8fZ; Sun, 18
 Nov 2018 18:15:25 +0100
Date:   Sun, 18 Nov 2018 18:15:25 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Steven Penny <svnpenn@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Cygwin Git with Windows paths
Message-ID: <20181118171525.GA25854@tor.lan>
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
 <20181118154124.GA21680@tor.lan>
 <CAAXzdLXSJU5bC_D1Q_gCWqKG7mcdcAvRkiYzano-VsrRRxazDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXzdLXSJU5bC_D1Q_gCWqKG7mcdcAvRkiYzano-VsrRRxazDQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:pIg9Q9OssUvkzdIjnhUMpMsJXI1mCwsF56sCcExzsGyX3RSKujp
 anV1VraeBMzZh2u6QR7KketKwjcp11UpG5PIPSH92fR2NjrC1+IbyXqvZ5f4p2EsKvYx4s6
 c2QXLE9AgJnIyT/ygpKIlOCnodMSGdwTluF+GfiDFet55PGE6IJA1LWb43lG5M8WrAmhWrw
 431xz28KbKpDC8N9xDeUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JOpPXa0g+kY=:P9AbJKzpEFc3QmUkNJKNoT
 UppQJsa9qaG9XxjTBbNsMVGVrHKm5PjHGfxHiUYW7j5lICc623E3CkLVsD8AoANHS59eQIeDM
 USPG8gGlKvLRTd8CdvG0WnDwsQUBZ7ctH9kCah4OCRwDEGdHSHVLWFo8WGSuTLPdGvNF6lbBq
 vXeeMpjG9/IWjAHYdevGmYwtIlFSovsXvlvyrQaZ6LYmbm4CibZLi7Mas4excqZFWzozqQ0bB
 iK85RRjIskRUQ8+bwyod9i5oraBKhoYyGY2+ufhKodHNKSjJy+WHDqgLF02GUOOoyOdTT9SCt
 I9EL6AUJxK0RftsYDDn3uwnNPHguZ48pXJuxmn7FGemDl846WtJYKyl0/w012w/kScgsg76oc
 VxuH1E7O68JJxX79uWoYmuT9lcPewS/MlmZs2vk5+j7tQexhfhxWTAUaECKFpBwUy753vX0VY
 Drko/2IfSZqLbndI6616+CV0YxEUaDgMH7rP6LsWKQ8WWu31Lv0Bm22Ptg5BbPn9UG458RYoH
 H6bUGv0bl4w1XfwlciJZz+E24dLFYYiKiSEMWHJhrRb9oJcyN4yAliikAWlJcdYsCMIsCp+Td
 w1RVdY3LUKdKrr+B0P92kwp84JvHYv7PrWXKJnZJfJ/w+0KZdB2RY+0alIIpLUrln+YmthuiE
 kYrG6a8Hn6M2wjLvi635WelCNxNLkJHmHa2i8ge8GWw0PvssCfaq6wI0RskKlcDZMYD1s3R7k
 cn10vjGh/UcFvB7cyVruxwX9Qagd+GWJz9+oCVn0pdku2+tYWc22xz1A8UNKvfPvv61Wnianv
 tB4IaXlU0CMudh6eHx9FAXR9D9TDR6PSsiazHNmeJnj+chhuL6A1h/lhCOdsSGl2DqKTqIM+K
 VXTasrDAyE91TEByVGWpdIbj09zwAtWhQZwwlsUMQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 18, 2018 at 10:23:19AM -0600, Steven Penny wrote:
> On Sun, Nov 18, 2018 at 9:41 AM Torsten Bögershausen wrote:
> > Thanks for the report
> > It seams as if "C:" is not recognized as an absolute path under
> > cygwin.
> > May be it should ?
> >
> > Does the following help ? (fully untested)
> 
> that looks promising - but its not getting pulled in where it needs to be.
> perhaps another file need to be modified to utilize that macro?

The macro should be utilized, see git-compat-util.h:

#if defined(__CYGWIN__)
#include "compat/cygwin.h"
#endif

And further down

#ifndef has_dos_drive_prefix
static inline int git_has_dos_drive_prefix(const char *path)
{
	return 0;
}
#define has_dos_drive_prefix git_has_dos_drive_prefix
#endif

#ifndef skip_dos_drive_prefix
static inline int git_skip_dos_drive_prefix(char **path)
{
	return 0;
}
--------------------
But it may be that we need to pull in more stuff, similar to mingw,
to get the C: stuff working, see
"skip_dos_drive_prefix"

And it may even be that we need a special handling for the "\" to be treated
as "/".

If you implement "skip_dos_drive_prefix" similar to mingw,
(rename mingw into cygwin) does

git clone <source> C:/my/dir/
work ?

That would be a progress, I think.
