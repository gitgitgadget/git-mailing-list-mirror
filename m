Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F4251F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 19:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932993AbeGITPL (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 15:15:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:44099 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932947AbeGITPK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 15:15:10 -0400
Received: from MININT-6BKU6QN ([89.204.155.168]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlGoc-1gCDMD34Eg-00b1Gp; Mon, 09
 Jul 2018 21:15:00 +0200
Date:   Mon, 9 Jul 2018 21:14:58 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Daniel Harding <dharding@living180.net>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] t3430: update to test with custom commentChar
In-Reply-To: <1084a573-4ed5-5a8c-a159-7773f7465704@living180.net>
Message-ID: <nycvar.QRO.7.76.6.1807092109440.75@tvgsbejvaqbjf.bet>
References: <20180708184110.14792-1-dharding@living180.net> <20180708184110.14792-3-dharding@living180.net> <20180708210200.GA4573@genre.crustytoothpaste.net> <1084a573-4ed5-5a8c-a159-7773f7465704@living180.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yZsCxhzFgbMKv0Bx4H5iIUsrKR3YdJU2mlOX0KHwdXLlWcklOqF
 mTbhsNHpyzVvfImvGFHpy57KM+8XfVtLHFfugffv9QebAdEsyhpQ19oikaKou39PCMWsoi1
 wi+1ORAFAZdN4S3QcyJMNiBnza5E5yH8AwS9b1bi5xCa8d6BY1mlY2kMdldrk7VVMYujXC0
 zb/8TmFAZpJJ1d13ZaHvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iabanSaxk24=:MHIpPBJqBIou3fkNHZ9ZHk
 lFugJB4epEOOgOEt423rEEdJwTw8EuUet60VLCB01y+iJIjZcM8o89efqKOVCrWtdSVfYoXSa
 KV35s8hKnm49xr1NvPeIvy80NpM3pUekqj2tJui6AC0XkE6NnPgcfiPt+xrlNNo9xDhbIrmlR
 PX6rJ8VH2ddzlLbg11vmdLEH4K2Ly1a436AzhyQ/yUHRNgZunemnnbCTkZGc2sRr1/E95KK1V
 ZgJrNqxvwqU5Uor6NkHKeNd/lH3Tf7jotHe3bg/Rc6L9ZByd9L6cmeVWyPvMjStNAjlxXf7Fa
 NJKs8OTpgE6Ai8wrQWSVIyYo7UeGm1q9m+LR6yZ65rGxIFbBfW3d2RsbKMBnihzpRFZoxUQw/
 JxJWJvcx1ZTuPNSIfuFxsgqG+ZwJIRfHW9a+F4oIYPE3mcQ23jS7IksdrfFNuBNCB1PgqplUs
 +SEUkw2F57s8wPdBriOEBQH56dHNQijXD45vTPKTZsMQmg3qhRCzsZZAkXRnJfmMY/Vt4uesp
 z/1eE0mEmQWrf2190caMQiIx6RTjLBd99CQ0JAVZE8/lDAo7CYiTb0CF2fYGOnB803XWX2Qix
 QWQgtToSVLGcF8zX+exb+NECd+h1F3QAayV/dzlNSLO11AcEQcnxiAuVwyvRuc94R9MZWzM1L
 AtfLfeIZSsPBUXeqJllucxTX8ETlYsfUBCDoe4mTbiluoqyLYSU2BfPMxNUtr6MBTlgzcI4Vj
 /RwYtlelhoUWhMMwIOevVkiEkSUqVcVefRX5+mbkeycNJBzX058iPLQalCivNDximJoRMyofb
 KpwRQBV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Daniel,

On Mon, 9 Jul 2018, Daniel Harding wrote:

> On Mon, 09 Jul 2018 at 00:02:00 +0300, brian m. carlson wrote:
> > On Sun, Jul 08, 2018 at 09:41:11PM +0300, Daniel Harding wrote:
> > > Signed-off-by: Daniel Harding <dharding@living180.net>
> > 
> > > diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> > > index 78f7c9958..ff474d033 100755
> > > --- a/t/t3430-rebase-merges.sh
> > > +++ b/t/t3430-rebase-merges.sh
> > > @@ -56,12 +56,12 @@ test_expect_success 'create completely different
> > > structure' '
> > >    cat >script-from-scratch <<-\EOF &&
> > >    label onto
> > >   -	# onebranch
> > > +	 > onebranch
> > >    pick G
> > >    pick D
> > >    label onebranch
> > >   -	# second
> > > +	 > second
> > >    reset onto
> > >    pick B
> > >    label second
> > 
> > Should this affect the "# Merge the topic branch" line (and the "# C",
> > "# E", and "# H" lines in the next test) that appears below this?  It
> > would seem those would qualify as comments as well.
> 
> I intentionally did not change that behavior for two reasons:
> 
> a) from a Git perspective, comment characters are only effectual for comments
> if they are the first character in a line
> 
> and
> 
> b) there are places where a '#' character from the todo list is actually
> parsed and used e.g. [0] and [1].  I have not yet gotten to the point of
> grokking what is going on there, so I didn't want to risk breaking something I
> didn't understand.  Perhaps Johannes could shed some light on whether the
> cases you mentioned should be changed to use the configured commentChar or
> not.
> 
> [0]
> https://github.com/git/git/blob/53f9a3e157dbbc901a02ac2c73346d375e24978c/sequencer.c#L2869
> [1]
> https://github.com/git/git/blob/53f9a3e157dbbc901a02ac2c73346d375e24978c/sequencer.c#L3797

These are related. The first one tries to support

	merge -C cafecafe second-branch third-branch # Octopus 2nd/3rd branch

i.e. use '#' to separate between the commit(s) to merge and the oneline
(the latter for the reader's pleasure, just like the onelines in the `pick
<hash> <oneline>` lines.

The second ensures that there is no valid label `#`.

I have not really thought about the ramifications of changing this to
comment_line_char, but I guess it *could* work if both locations were
changed.

Ciao,
Johannes
