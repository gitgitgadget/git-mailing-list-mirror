Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEA8520188
	for <e@80x24.org>; Tue,  9 May 2017 11:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbdEILUV (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 07:20:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:64274 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751368AbdEILUV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 07:20:21 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MYwyp-1dUNOC35xj-00Vi3A; Tue, 09
 May 2017 13:20:11 +0200
Date:   Tue, 9 May 2017 13:20:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 7/7] t4051: mark supporting files as requiring LF-only
 line endings
In-Reply-To: <xmqqefvz9asb.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705091306480.146734@virtualbox>
References: <cover.1493728172.git.johannes.schindelin@gmx.de> <cover.1493891336.git.johannes.schindelin@gmx.de> <f648bb03c7fe3945042480f05b9ac229350412b3.1493891336.git.johannes.schindelin@gmx.de> <xmqqefvz9asb.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RndvoBvbEjMOwfVBliGgUVOFqcib5ZZr3iZSTIhnh4wo09T59EF
 EbEzR9CUeuniN4kJCvraHHwzoZpQRTeqS5/sBOqhFw3rMTUD5BtDq47Ssb6ug88h+jDgzVw
 azzkCudxDsBQDNWfaP5Nt1+7DSpZL+1d/1Y++3IQ9ircrYxMCuURjgwOsdiIu5cFBb9uj6E
 BCr544YD1LZTIz7wCAIkg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:luRcKVpMk24=:EgoinFSy0BZYzzmp71WzyT
 V2qElGjPrw8jCq/vSH2IaQgLalP1lxk4xc4Q6MCwKEH3uROt+JGKztgKVf81Pwmfrr7MreHmo
 tKoCVa1/DPOAX6GY1BmzfqUP3sXu2DI2Vjp3HmQ9URjd17+UQhiJ5KT8ByOZ2dWpBcOCbN37S
 GARogAgazViEAT0TfVsRcT9C6WaaZRwQMlAlUlAvPU3OuOcyWIhPkMvQMkkVnQZglsOkw4psj
 RY5RqZ4rXzzkdDKc8twZHNfKOfsNnwWES9T17y304aFSEG3SvaxoykBuMqJnGouk5pdr+T+cL
 rAY55cZ8i8sczjIZCz57qDTVVzsYuciVBNX3I5wCqCw/X1zh3svF1gqK2nLQ832ZOtWXda3Te
 CUK+JORaI4nMA2rFnfx7LveZgx6PQoMblCDVPV14NSbsiwXN2GtX50W9iIja53ou29G9PIoNQ
 Hnr+xFwTwLbvQLzbptoEgHBDarazmrBxUtPkLwai8NXOqrZ4m7WJq3E5j5jSMTU7IzInejHI8
 907I0zUs4KJAZEjESmFIuEo9LimQ3F1rbFPbDkWEYyATltZxT5YkwlKdlXSCXnXoWl27ocPQR
 zA7CqUDSm0lI7KmUU+q1uDQ66OkVbel8WycVIhrXjF1R5Xm7zICJH+v3TfoKZShDSKV6gl6KG
 EIQaBpe70pFn0DYp1FvlSPKehYwxO47+ugk5I3VHdBLi8eUNuN/AeLdz+nw3QrZYMNRxL3oQx
 mZ6dVd0qMroOShN8QPMwzeVVcngmKQro3j6H658qJ9ol26r1hDs3jgjygCQKNnhkqf0w6YR4C
 Kcwga9R
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 8 May 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > The test t4051-diff-function-context.sh passes on Linux when
> > core.autocrlf=true even without marking its support files as LF-only,
> > but they fail when core.autocrlf=true in Git for Windows' SDK.
> >
> > The reason is that `grep ... >file.c.new` will keep CR/LF line endings
> > on Linux (obviously treating CRs as if they were regular characters),
> > but will be converted to LF-only line endings with MSYS2's grep that
> > is used in Git for Windows.
> 
> Ahem.  
> 
> I thought that according to your claim a UNIX tool like "grep" would
> alway use LF endings?  ;-)

The maintainers of the MSYS2 grep package apparently disagree with me on
that point. You should be familiar with that reaction.

> > As we do not want to validate the way the available `grep` works,
> > let's just mark the input as LF-only and move on.
> 
> I agree with this conclusion; just like we do not want to worry about
> how `grep` works when given CRLF files in this patch, we do not want to
> worry about how other commands like `sh` works when given CRLF files.
> And that is consistent with the overall theme of this series that marked
> *.sh, *.perl and other files with eol=lf attribute.

Good. That agreement is something on which you and I can build.

> The only question I still have with this series is about the
> README/COPYING thing.  I _think_ it was my ancient mistake to use the
> toplevel README and COPYING as test files, and that mistake was
> corrected by somebody else earlier by having a frozen copy in
> t/diff-lib/ and making tests use these files from that directory.  If we
> broke our tests to again use these files from outside t/diff-lib/, then
> we would need to fix the tests not to do so.  And if we are only looking
> at t/diff-lib/ copy, then I think it is more consistent with the rest of
> this series to mark them with eol=lf rather than passing them through
> "tr -d '\015'".

Thank you for pointing out that the README and COPYING files were
reproduced in t/diff-lib/ specifically to serve as files for use in the
tests. It had not really occurred to me, as I mistook this to be an extra
anal licensing clarification for the diff-lib ;-)

I will "re-roll" the patch series, dropping the ugly tr calls and marking
t/diff-lib/* as LF-only, as you suggested.

Ciao,
Dscho
