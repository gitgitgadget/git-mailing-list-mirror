Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E30C41F856
	for <e@80x24.org>; Sat, 10 Sep 2016 08:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754652AbcIJIQE (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Sep 2016 04:16:04 -0400
Received: from mout.gmx.net ([212.227.17.21]:58192 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753019AbcIJIQB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2016 04:16:01 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MfEsY-1bOFJW2NXG-00OlXB; Sat, 10 Sep 2016 10:15:56
 +0200
Date:   Sat, 10 Sep 2016 10:15:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     =?UTF-8?Q?Sergio_Mart=C3=ADn_Turiel?= <sergio.martin@accelya.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Missing RPM spec file in tarball
In-Reply-To: <CAGZ79kYu=0ik9W9g5yCbc5142_a2fb1er45TFEZ6RrekZRZM9w@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1609101014530.129229@virtualbox>
References: <4c42a1f4-4f03-0fdf-8bd2-8a7f1f978073@accelya.com> <CAGZ79kYu=0ik9W9g5yCbc5142_a2fb1er45TFEZ6RrekZRZM9w@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-756338497-1473495356=:129229"
X-Provags-ID: V03:K0:iYhqs0TsJY+blyv8jEDXNFTT8lOv9ojKnqfclUddbcU9MneqJWZ
 WUoJKBgcCLhjzoOg04gz+ngGRsuGPoRkYiZN3v1dGJmoVZ/cTvgVUX0Ca4YXoLsBn0I0rcV
 moGKl+/dYcvKoUSS9BWV3ULgGZgOVea//bYVQjuQ6/wJffxyHji5YaEAwyOEWbnFqI3M9LJ
 VSQaK0WscvQDEqtWSbs3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ai4E1sn+u44=:3ruRyLZdujVEpPzrM4U/B7
 XaHuNh8Ts5LBreJc5zdF+ppZg0ulCVzHH45FhJHPhTKsOV8UqlsDn5ufkfqDJvVz5Ze+S/lqx
 Ytu5zlrxHV4BWQJx4aX5uEg57Ndlzv9yK72TWf/1V9A6F7HXAvSXjCSlr08GT8++3TbZh3+KT
 7JFDGS/b7lj3eR+hCXeSJ9+HfOHch/kyfA5H+j+Ld0dqk18PZ/OeOpw5XsKwTQw6Mzbs5AcGP
 i9cgOA1bP2boTqCw0wYcAhLTeJrIFxaEAr3i0B59Wgkvw+UzMhbfTt1btzWT8h1/h+YsXVZsc
 sqp3opMcpDtkeqC4Fpq6mww4ic9Zo7zQzW3DQGaFOI0/WfNGA2vpybHoU2MWXG7MWwzcWoPBB
 5JxSnMiplTtRisuww3znyfOIcNX2ceCihXCNlhEQTLRjD5f/UQw2HG9cKA5lRQ/VRresvigKY
 NdTIl1wTHidt/YaLOWNr4N6JIIGts0Ylmc+ROe/L/+qmisOCWembR1SO6JnNgUGAPddNPwsS8
 NjEici01OO4Ni6ADmHXxO6HlR2WPC4am9EYHG1wKDzG7Zk15qSr90Msr7hqspDrGmaptSvDY8
 PnbrRLONoJHa1vP1ok2PH5wlXXhTB4QyvYKabycpS5Cz6X/dKVbyCWg7TuJDqzv2mUWbBGd7a
 GPQa76RxZocL2cUlMRqdCA5400bGs1AFgBJ3uUtrnlEjeh+gcyRh6CdtzV4lMZt1hmEPH2jHs
 F+ZUUmTJ3W1YiWRFlMPEbo3g8pzh6d0taaSE3D585oZNbvyvO97QYJkcRxbP+10r8CCin/NFM
 W+FRSPT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-756338497-1473495356=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Stefan,

On Fri, 9 Sep 2016, Stefan Beller wrote:

> On Fri, Sep 9, 2016 at 9:19 AM, Sergio Mart=C3=ADn Turiel
> <sergio.martin@accelya.com> wrote:
>=20
> > Can you tell me what I'm doing wrong?
>=20
> Not crying out loud when that commit was discussed on the
> mailing list. ;)

Umm, I think it would be more: "Not stepping up to maintain the RPM
specs"...

;-)

Ciao,
Dscho
--8323329-756338497-1473495356=:129229--
