Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D9E01F859
	for <e@80x24.org>; Mon, 29 Aug 2016 05:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756036AbcH2Ff2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 01:35:28 -0400
Received: from mout.gmx.net ([212.227.15.19]:55240 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755930AbcH2Ff1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 01:35:27 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MMBiP-1blgHC2e6P-007z9Y; Mon, 29 Aug 2016 07:35:19
 +0200
Date:   Mon, 29 Aug 2016 07:35:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     Eric Wong <e@80x24.org>, Stefan Beller <sbeller@google.com>,
        meta@public-inbox.org, git@vger.kernel.org
Subject: Re: Working with public-inbox.org
In-Reply-To: <d4c44d3c-7361-2a33-4ae5-03cc45f8a034@gmail.com>
Message-ID: <alpine.DEB.2.20.1608290719270.129229@virtualbox>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com> <alpine.DEB.2.20.1608181430280.4924@virtualbox> <20160818204902.GA1670@starla> <alpine.DEB.2.20.1608191720040.4924@virtualbox> <20160819223547.GB16646@dcvr>
 <alpine.DEB.2.20.1608221509010.4924@virtualbox> <20160822225549.GA25383@starla> <alpine.DEB.2.20.1608251457310.4924@virtualbox> <d2c4d54f-e3be-8e17-860c-d9b8bacf68e0@gmail.com> <alpine.DEB.2.20.1608281033340.129229@virtualbox>
 <d4c44d3c-7361-2a33-4ae5-03cc45f8a034@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-705345098-1472448919=:129229"
X-Provags-ID: V03:K0:PbD9Q2/5JWHTxZbp+g2lpErTcCMZDYZYW9azX6PD9ajDXl53Uo3
 +tm9u4iKIDqFgK+K7PN79Z/4R9zIRqgMGzEYq6vkJMtp55VlYz/INb1MrFOYtRrRwDdqP9k
 SaJhojaeCd9D8N5XuhmMTOPwgS3GYBBZlyU2a60+f3SGO2rK8FoIyAw65gkzozkeBRs/vx2
 aC85CMV9ef2uCDNuGRgHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7dKXp2YrPTE=:ddPZL0aoEY/6DXRPVGN+xs
 xulGR7eDK+DfDlhA9cySKmgkdTVuIIwWH1yg6ULEpzF6UKimPC1pklMkr2oV0O9lI+S4+vWIw
 xIh7I1Lvl2i9e+ftIs7voD24KM1HylKducq0fYPy1tHSPUAp/HZmH3UoQGpVQRpi0e5PqT1e5
 z/g6s0/7AbwkOMfSVRX0W00dQQqDn+y1BaqHpKpdPGu/k8VrY3f4umMcEqiHfo5NpcoZbIF7G
 xwTHYxuljlJvK4iTopzMpHfg2PC9j6h1/DDoIL3GiDKvhoyfhPNFpjzyzR0ln4GmFN26mdtfx
 zBWJFEjdPA0I7RrUZsSmrXCMR9o4Bam/lHU85hojidsMYcAEXnne6LqFj1chTM1OLIooZIk/x
 yFO2GCOGPk1UQScBXE0wB9K+6UGto4m4i5fJJjyin4hfueG7L6byooOxqI5iEhqRcsJwfHjvU
 SPb3oCde1ftDWSyxNLjtOzrkZGqS9TP2BAijmVwW1mVB7sulbE0k7MggWVcKaO9wKC2f+ZGXN
 +6F3H4wmD55KyBR/5rBsp9HVYuGKoMHGgSk7Ew90MQIM0US8j4zV74zxzFrQUURd3nMCIUrWv
 UrZNdyhOCx0PKASKir6NHz4fAkr2aG3PE7IKUhGtdzYSaKGS9a5JpGKilARXkuaBgiSoj+33M
 QrOyIDs6AOszfky5yIeybo1TAl4mNPYaZ4zBsQhYld/0yaiYMRxKityRrDJUx2XdXHKYHO18I
 dAevM07Yzsut6A/AvnfIrWRIBDhWR5tJKLQqHrJTupu9NHT8UOALOnILooy+8dBsq/xy4/AfK
 yn8lKyC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-705345098-1472448919=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Sun, 28 Aug 2016, Jakub Nar=C4=99bski wrote:

> W dniu 28.08.2016 o 10:36, Johannes Schindelin pisze:
> > On Sun, 28 Aug 2016, Jakub Nar=C4=99bski wrote:
> >
> >> Arguably for some federated/decentralized tools are preferred
> >> (for philosophical reasons), even if they do not achieve even feature
> >> parity with centralized tools (c.f. FSF).
>=20
> Philosophical and ideological reasons.

My mistake. In my mind, I corrected the grammar to skip the "for", not to
insert "developers" after "some".

Still. Based on my experience in the workforce, it appears to me that you
still confuse ease with convenience: many Windows developers I worked with
are quite capable of doing much more complicated things than configuring
imap-send/send-email. But why would they?

Coming back to your "philosophical and ideological reasons". IMO it is not
very wise to go down that path. Much wiser would it be to make provable
time savings a guiding principle.

Ciao,
Johannes
--8323329-705345098-1472448919=:129229--
