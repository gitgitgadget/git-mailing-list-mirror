Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68F3E1F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 09:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbdBBJQp (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 04:16:45 -0500
Received: from mout.gmx.net ([212.227.17.20]:49535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751100AbdBBJQn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 04:16:43 -0500
Received: from virtualbox ([217.64.244.213]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LiHc7-1c3xPX2e4h-00nOYT; Thu, 02
 Feb 2017 10:16:33 +0100
Date:   Thu, 2 Feb 2017 10:16:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] nd/worktree-move update
In-Reply-To: <20170202085007.21418-1-pclouds@gmail.com>
Message-ID: <alpine.DEB.2.20.1702021015160.3496@virtualbox>
References: <20170202085007.21418-1-pclouds@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1540168489-1486026992=:3496"
X-Provags-ID: V03:K0:KGsjaO3JUoue/lvbcnhhc3hMHN9sc9jeyDOK3YPWhaSv4/T+YQi
 60Oc0qIhxe0f6wulmKrbgcXwIa3Ic/WVJcVFo5B+OPOQWSwW+DOwnbyWFh7mHh8YlncvVDZ
 XFbIViMTGu9PfbRdl00AWdU7UKM1iLgcpmuhoFCUNztTY6o+ny2qUFT4UU0UEruXlknjO4T
 lVHFtMwnC/RQ3+Mm4KcBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:y0cgWbR1tWc=:WHMcmhvx8u1M1Md14uyt0y
 rN74Et8DovcQI8VmuCUWRCtXJMoE+/KPaDPuDUckz/Gcuxb/GDY0MKRdU8Ofyu8Df6KTR+4tx
 1gVbRPnFxdWq8+Wzkfq22R3obSHIE4f4bXnY4qrSWfNXQjWlMOJy/TxNUtGIqjuOVrAVTw3aA
 1/QslKlrk1KN/u1R3Y2Y9glz1Q8x4APyX7QKmh37B9aoNMqNXfMaVi7Ee/GVEmfltOJQq56vD
 FmnccjImocW47dkeKhkJ0V92qUSO97oN9zpETfjA49yb2wYM2G8UrW9PO1APYJdeiw+Yko2/N
 t9rxf4Y4FsbcnS5TyBfcyFZ8qisKzoDyHYKEX9zhn+0fjrP4OSR21cDNNLJrvw9A6atLlBjml
 9yS7viQ/bn/NWlyZHW1tw/uq+TTmLAp1QsUXjqGkaywtP/4qZMNqDxUmT1zG5r2r1/TlpJoh7
 2Zy9gzQwejvN6aVuwkvzCUXp5fNlvGyUcRXDv8cBFUnU9AcU2sHneO2vNpfltnBdbDGXL4mnZ
 etWZzgd4e2utfT3DM29JBwVzIsEgZbQHn+Di2QBrHe3WexqdSXPVeBUwo/pkeAmHGaz7e15mD
 /cK/nEyx2QZo+eW8i2Pi4j+3r5w9gcUs9R4nrJMd21oLris5cyY5ioy6SvMeCoIOYfquX8yl6
 TebEZiESjjdB26Sx4NmJ93O55EWETsUh6Bod8wP88NvYfbHsT/flqzA7nrgfCS3Gx35GSJn6x
 dY6Zn7n/dHBBXDQOXz/iOyMZJ+Yqt5x5m/FnRrMKI9JMt4Rqb4FZy3Me8RceFUbIv/+viwDcf
 /CtLeRo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1540168489-1486026992=:3496
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Thu, 2 Feb 2017, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> This squashes two changes from Johannes and Ramsay: [...]

Sorry, I lost track of the worktree discussions... Could you remind me
which patch is supposed to fix my continuous reflog corruption?

Thanks,
Dscho
--8323329-1540168489-1486026992=:3496--
