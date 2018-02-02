Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1557A1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 21:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbeBBVST (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 16:18:19 -0500
Received: from mout.gmx.net ([212.227.15.19]:57261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750805AbeBBVSS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 16:18:18 -0500
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0ML6qP-1ehzhm3Thx-000K0V; Fri, 02
 Feb 2018 22:18:15 +0100
Date:   Fri, 2 Feb 2018 22:18:14 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Keith Goldfarb <keith@blackthorn-media.com>
cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: Git on Windows maps creation time onto changed time
In-Reply-To: <040E3C3E-BC8E-4658-A882-5149D10AD408@blackthorn-media.com>
Message-ID: <nycvar.QRO.7.76.6.1802022216370.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CCB76F06-DBA9-4342-8830-402F8AF9854A@blackthorn-media.com> <c1e419ae-feae-5a31-ead6-20b25fa92f85@kdbg.org> <040E3C3E-BC8E-4658-A882-5149D10AD408@blackthorn-media.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-228025792-1517606295=:35"
X-Provags-ID: V03:K0:YcFb9F2sS4jSS1nKJAe3/s1gXzTczesaDXLV/gB78Isu82PlH66
 ze/5antgpIKhSaLqud3dM9RkWOu4aPlNEqtCXoZyfwJmFlABUmp9i6ttTOElgu372NsV8Wj
 7/AUvuUXWTY7sYxx+wVvJyQlEZIn8aWeV499Dcte/pLUxdNjcVtOr3J2gjDHHxnggEdlDCq
 UOxLaISlD+I9ubgCS7N3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Yu4f/FEEi6A=:4BuaokzSWwavBSdCqY7slf
 OzxoZirHLVxxaoHLKlwxHO8LxOjo1HLc8YFwoJk7dYWBpqycCvHniuL4BoReFL8Ee8p/gnfQA
 VkRTwd15mm8tN6SrsjffuVrM0fEI4Etu4d6YPvQjHdDuWi3Eu0qUTcDKGHER0poxKMzw3s5i6
 VJBBGtIqzP6pD18ppPJ6+3IZUjUGQicr7TWvp46A38gIuaR9b7M6+KaTzj9oy1cqZmgnGkNV9
 z7ABgi3bPl24YJjpAgsUgpYvmUgJwRVHzWyvJGlM5QHu/QSw7IWgVkEevs7ua1h3sHnMXP8VX
 esa9F9xBzACeBb44KwxU7GjHWrlJyVfpULCjs1nZhTn0FLSw5LD2obhCXuMyp6Rb3+o+yiak6
 j7B2ymv4rFjYXYP1dPenuQySczDWKTjm+NOP7biBwCa5ccqd51eAf+Hf6GwkY35Qap07+g16/
 Goq8NIeppNDczPRUE5gsXtjj0liM7lcr77hBZdlkKBbRZZ+qGFH7KkGRc0DV1hgKASPUjF/7T
 to/m1rD0HS04na5FTxmW8QJ3OhSUVWYODg7/bHeppqlzZSTVPA9hOjHZhK9To/1MgAsKb/4HS
 d4mDoKpGeMsUDkzvMYS/ovQIZLRXtdQHnucRrr9RlZK0+Rkac0rI8QO5gac8RVpPePkD5bJMG
 dx0N1sRlf53+kUR12/ydNlaWcAeOsae0qz2m5jEHJBGFhtPb28i6/3LMQAkpnha3/VLViFRV/
 /5rTlzIYwaIqrVAtyj49g7XXR3LNaA/lznW4F5SlhNPRmIWtGHYRQeqbvVuMBCJ8cFjnWPMhc
 8ezIV6Xu3Yabe2zh0cznM5462gz8daMDcUzhpVh48ENXrHHjG2jxiFN4kq2jVOAJM5QZAHx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-228025792-1517606295=:35
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Keith,

On Fri, 2 Feb 2018, Keith Goldfarb wrote:

> > The purpose of these values is to allow to notice a change on the file
> > system without going through the actual file data. Duplicating
> > st_mtime would be pointless.
>=20
> Well, I agree with the first statement. I disagree with the 2nd. It=E2=80=
=99s
> not pointless to fix a problem, and in theory the creation date of a
> file can never change.
>=20
> > Don't do that then. Use core.trustctime.
>=20
> I am. Unfortunately, my problem isn=E2=80=99t solved by that alone. Perha=
ps this
> deserves its own thread, but on Windows the st_ino field is set to zero.
> This can also trigger a false positive, causing the whole cache to be
> rebuilt unnecessarily.

You cannot assume that the inode numbers are identical between file
systems/operating systems. That's simply not going to work.

I know you really want *so hard* for the same working directory to be
accessible from both Windows and Linux. I have a lot of sympathy for that
sentiment. Though I do not see much chance for success on that front.

Ciao,
Johannes
--8323329-228025792-1517606295=:35--
