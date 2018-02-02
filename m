Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39FD51F404
	for <e@80x24.org>; Fri,  2 Feb 2018 23:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbeBBXBS (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 18:01:18 -0500
Received: from mout.gmx.net ([212.227.17.21]:53340 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751468AbeBBXBR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 18:01:17 -0500
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEtba-1eXGzY39LO-00G3wT; Sat, 03
 Feb 2018 00:01:14 +0100
Date:   Sat, 3 Feb 2018 00:01:13 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Keith Goldfarb <keith@blackthorn-media.com>
cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: Git on Windows maps creation time onto changed time
In-Reply-To: <0B8B61C6-0EB6-4134-BDA9-FA7750B79BB2@blackthorn-media.com>
Message-ID: <nycvar.QRO.7.76.6.1802022353220.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CCB76F06-DBA9-4342-8830-402F8AF9854A@blackthorn-media.com> <c1e419ae-feae-5a31-ead6-20b25fa92f85@kdbg.org> <040E3C3E-BC8E-4658-A882-5149D10AD408@blackthorn-media.com> <nycvar.QRO.7.76.6.1802022216370.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <0B8B61C6-0EB6-4134-BDA9-FA7750B79BB2@blackthorn-media.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1658781926-1517612474=:35"
X-Provags-ID: V03:K0:B42MvgnE0QCXgRd2pmA2a8LOLbrtCB7QCEEprhTuU3OK7HwgrdL
 hUZrd/Vp8ZKGo5ou1XGfPh1h1hrg29xqliOvRookRJzRemiwBdcSgy6H6WKWmmKkEqd++8G
 +608wWv6AO/xfrnwZPlc3s3SjyjsK8gDloYLgVCkbxdmCr2ZNoOsGysPCw5qXjPx3cNvJia
 YRYHHOjEVICk2fVenNA1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:znYwhWkwsTc=:r7r6Z6y6XwrjVQPjuH0xX1
 BKnziZ+b+8YxqT2pg0pNPk7P6aFkyG199Fi4FMyyYXZXKev5o1Huh3GKwXZneJA3fQfBDX9bc
 se99kDMMdjoBRyrNhR3U7TudFNlWHse0mCz6faBs1Yv+Q+tdr+dlFktzWmxCB415I6Ao4VRLP
 AY0+ESzX+vk2zauWgJee/UT7suKbaCr3oRh0lcd49nNC+4piwRoq19C3pQfJbB35G5X+K+Kfj
 Q9NveuTI1YtLK+6ILS/IK1YNlgSNVpe0QxYSqHrKAmfwcaktaMKEwovcRUqoBsPEi4IqajKm1
 IzkDHtrzBP3y49Z6h57EhfkWpHxJ7PzvqBgkAGEmeQbF5drgXrPiz89BwY0LuHF/f/QRuDD7W
 HnR6QaVyirSE/MCo3mWQQ93cQVH5XWdg0lB5y+e7LuK9bS0dzVfpvW0acN2s0I48yOhOLwBOp
 pxQAiNJkbMx25iHv7zSUhfG/eEKMxTY4U1aWbl0m93odItTi53/NscRD/X9LFeEyoGlgQl2Qd
 iKbaBZuwnuxJXCCKssePguJtECQ/up45hLQr8yVVi6Lg6vQcd4DBq0ELB7uGFJHsy9y9IK6mh
 fwZdao6tnoe0O4ARe5WtvhzLhBU66u2n0c2p0nUedgKEGRz8owLy71w/gGsi6EVzs0KbyqHcN
 q3gWIvtdziX+BZRlvwRAGXgLUar/1JHqf9jvPwFtA8AAERcpbPW2mmMWfSAIWYrjFAWTEncxp
 DZQ/SN9zol00svgOE5p6RamzjwXaAqq/87li0v8ag76FwSKkepO1LhYZGy1AB5Za71JKgzF4S
 Ejfs+bb0EdhTVDWyBVphoQ2PL98Hwl65931u4qHPa/9tsUmAGLR6EVCXlGyHYWU6LuPudpp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1658781926-1517612474=:35
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Keith,

On Fri, 2 Feb 2018, Keith Goldfarb wrote:

> > On Feb 2, 2018, at 1:18 PM, Johannes Schindelin <Johannes.Schindelin@gm=
x.de> wrote:
> >=20
> > You cannot assume that the inode numbers are identical between file
> > systems/operating systems. That's simply not going to work.
>=20
> Yes, I agree with you, I cannot assume this, so I checked. In my case, th=
e inode numbers are indeed identical.
>=20
> > I know you really want *so hard* for the same working directory to be
> > accessible from both Windows and Linux. I have a lot of sympathy for th=
at
> > sentiment. Though I do not see much chance for success on that front.
>=20
> I=E2=80=99m certainly willing to accept that there are going to be limita=
tions by using a filesystem from two different operating systems. But regar=
dless of the problems caused by that pattern, would you agree that the Wind=
ows code should be using the actual inode number (well, 32-bits of it) inst=
ead of zero?

In all likelihood, you have enabled the FS Cache feature. And for a good
reason: it makes many Git operations much, much faster.

Still not as fast as on Linux because Git is quite tuned to assume all the
Linux semantics. So instead of using tell-tales for file modifications
that are portable, Git uses tell-tales that are readily available on
Linux. And instead of using access patterns that are portable, Git assumes
POSIX semantics where you simply use opendir()/readdir()/closedir() and in
that inner loop, you call lstat() to get all the stat data.

This is obviously not portable beyond POSIX. On Windows, for example,
there are really fast FindFirstFile()/FindNextFile() APIs that even allow
you to specify patterns to match (which Linux has to do manually, by
inspecting the file name obtained via readdir()). You even get some stat
data back at the same time, really fast, without additional API calls,
unlike on Linux.

But Git's access patterns really are tuned to the *dir() way, and we have
to emulate it in Git for Windows. This is very, very slow.

The FS Cache feature tries to gain back some speed by using
FindFirstFile()/FindNextFile() pre-emptively and caching the data, looking
it up upon the next time stat data is queried.

The stat data obtained that way does not, however, include Change Time nor
inode number.

And that, dear children, was the story for the day: this is why Git for
Windows uses the CreationTime instead of the Change Time and why it marks
inode as 0; Because to do it accurately would be a lot slower, and we
cannot afford even slower because we are already super slow because we
have to work around Git's assumptions as to what APIs are available.

Ciao,
Johannes
--8323329-1658781926-1517612474=:35--
