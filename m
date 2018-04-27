Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 354B61F404
	for <e@80x24.org>; Fri, 27 Apr 2018 07:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757500AbeD0HDi (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 03:03:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:33725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757373AbeD0HDi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 03:03:38 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M5a9E-1eRYzN0cTw-00xYZe; Fri, 27
 Apr 2018 09:03:17 +0200
Date:   Fri, 27 Apr 2018 09:02:58 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Christian Hesse <mail@eworm.de>
Subject: Re: What's cooking in git.git (Apr 2018, #03; Wed, 25)
In-Reply-To: <4d0bd1a2-2f51-4a11-7e31-1e1ac5213c51@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804270857260.72@tvgsbejvaqbjf.bet>
References: <xmqqmuxr4r6n.fsf@gitster-ct.c.googlers.com> <87zi1rd14k.fsf@evledraar.gmail.com> <20180425174300.GA49485@google.com> <4d0bd1a2-2f51-4a11-7e31-1e1ac5213c51@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-333150051-1524812597=:72"
X-Provags-ID: V03:K1:rXqxCSxrwy7hlEgyIdSJaSlb3Kht3AVn+acYUgD9AM5kEiOFs6J
 i4kcPi5JGDHPuLQkMhlgEDVJ6Fm0NmqNjZSJSxIFMpwbdDBld1HQszb7GHVTf6ZXYkZKhBV
 OMfE8Z6ycfD7/+JvK/JMwIL1n9ZbKoJaLhWtSyMAB1nhXeeE5dGDOiPkb755q8Wd91R49Gv
 /wtpuPIlu58gVn+uEtcrA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:krph6eKd854=:geDtz3EFiObmCytRLwZgXy
 W+oCk4ODbKsww/nPrVwili9bfS992F0V4zNjLQr4M9OrByTC2nRlaeM7XdDqp2SsOl2evyBtA
 0MsK/5GuhE/MCGDms05WS/7aitJqLKdwGVxddq3mgTjnazp7oVEXC7/9sWOkQin/mWEwztV7W
 +jKHwWOzmYTgrMSn00wYbw5KA9xmlMoJ1hnnij7u53bXxS481BWYIR5wHdYX81PIAMr3uGYYi
 2AetuMwgHwczEmJS1t68priHtNgAF+CAeSW6nRW2ZkyTeP86saOb//wdDLKHIQc65r3Zxu77X
 4AHqJhYWQPmPUHvDGIzgNZ91TV/wFIxoQlDqEUv6Ok3qhRQ2jV2q/qvnobOJUpHPFqPpKyG8o
 rCejB5DgCShQcQCrFjhL0SWufACIh28AhQFvY1Iwufj1BRDBK65156tyqRTnpsBVExKL266Gt
 HsGWAwk/bj5IOAo3ooryj7079+K/MO5Kszm3e1lWbYzhmZxavuIRJ1hqJ3YtqCvvdsUyVprsm
 unYPtyU7Gphtu5idrWlGd8oVpt53yRBVp5OPmzCfBDO6tltxXsS2xuQqo8/WmlSk7gLG//njB
 wZlFxuuQ0l5+HNfxPZwJ1QV6obNQU0143vPMlVMBdrZRW1sFjFpIYSoRl1qsDypJ4nQUofuq4
 RaVE6PTzCq09bqsIwHbWMC4DgV1jziqAPYLXsXVlc5fHDHqUuUfEIVI4S3fY/xR8ePCAcizFL
 z1+gR1GaZR9gNW///iE6nni0xlYX8HROGum+ShbvokN5TIKLn8mZ5sEdDHRlorA6UE55vidkl
 lDpNWLF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-333150051-1524812597=:72
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Thu, 26 Apr 2018, Derrick Stolee wrote:

> On 4/25/2018 1:43 PM, Brandon Williams wrote:
> > On 04/25, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > > > * bw/protocol-v2 (2018-03-15) 35 commits
> > > >   (merged to 'next' on 2018-04-11 at 23ee234a2c)

[... snippppp ...]

> > > >   (this branch is used by bw/server-options.)
> > > >
> > > >   The beginning of the next-gen transfer protocol.
> > > >
> > > >   Will cook in 'next'.
> > >
> > > With a month & 10 days of no updates & this looking stable it would
> > > be great to have it in master sooner than later to build on top of
> > > it in the 2.18 window.
> >
> > I personally think that this series is ready to graduate to master but
> > I mentioned to Junio off-list that it might be a good idea to wait
> > until it has undergone a little more stress testing.  We've been in
> > the process of trying to get this rolled out to our internal server
> > but due to a few roadblocks and people being out of the office its
> > taken a bit longer than I would have liked to get it up and running.
> > I'm hoping in another few days/a week I'll have some more data on live
> > traffic.  At that point I think I'll be more convinced that it will be
> > safe to merge it.
> >
> > I may be overly cautions but I'm hoping that we can get this right
> > without needing to do another protocol version bump for a very long
> > time.  Technically using v2 is hidden behind an "experimental" config
> > flag so we should still be able to tweak it after the fact if we
> > absolutely needed to, but I'd like to avoid that if necessary.
>=20
> There's no testing better than production. I think if we have an
> opportunity to test with realistic traffic, we should take advantage.
>=20
> But I also agree that this series looks stable.
>=20
> I realize it's hard to communicate both "this series is ready to merge" a=
nd "I
> appreciate your caution."

To add to Stolee's comment: in our (day job) team, we are huge fans of
"Feature Flags". We blog plenty about it, GitHub uses it in their
Scientist approach, and even here in the Git project, we managed to use
the paradigm: remember the transition from the scripted version of
`difftool` to the builtin version? That was also done via a Feature Flag.

In the same vein, I would treat your config setting as a Feature Flag, and
I would be very much in favor of having the code in production, with that
feature flag defaulting to "off", and with a description that tells people
very clearly that not only the flag is experimental, but that we might
need to change the protocol, still, before v2 goes final.

I would then add an entry to Git for Windows' installer's "Experimental
Options" section, to give it a bit more exposure (mainly to verify that
the v2 client <-> v1 server connection works flawlessly), also as opt-in.

How does that sound?

Ciao,
Dscho
--8323328-333150051-1524812597=:72--
