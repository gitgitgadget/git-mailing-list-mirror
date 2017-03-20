Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 189C82095D
	for <e@80x24.org>; Mon, 20 Mar 2017 11:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754054AbdCTL62 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 07:58:28 -0400
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:52696 "EHLO
        4.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754053AbdCTL6R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 07:58:17 -0400
X-Greylist: delayed 12001 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Mar 2017 07:58:17 EDT
Received: from player792.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id 69A833EFED
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 09:21:49 +0100 (CET)
Received: from [192.168.1.112] (static-csq-cds-097114.business.bouyguestelecom.com [164.177.97.114])
        (Authenticated sender: jean-noel.avila@scantech.fr)
        by player792.ha.ovh.net (Postfix) with ESMTPSA id B5FC4A0086;
        Mon, 20 Mar 2017 09:21:46 +0100 (CET)
Subject: Re: [PATCH v2 1/2] l10n: Introduce framework for localizing man pages
To:     =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>,
        Junio C Hamano <gitster@pobox.com>
References: <20170312200248.3610-1-jn.avila@free.fr>
 <20170312200248.3610-1-jn.avila@free.fr>
 <20170318175353.24578-1-jn.avila@free.fr>
 <xmqqfuia1ifx.fsf@gitster.mtv.corp.google.com>
 <xmqq37ea192h.fsf@gitster.mtv.corp.google.com>
 <xmqqr31sy9xe.fsf@gitster.mtv.corp.google.com>
 <46714f87-bf42-81a5-4af0-9b3a3282ad56@free.fr>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jean-noel.avila@scantech.fr>
Message-ID: <859618f1-4305-9603-21ae-37609fb276f3@scantech.fr>
Date:   Mon, 20 Mar 2017 09:21:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <46714f87-bf42-81a5-4af0-9b3a3282ad56@free.fr>
Content-Type: multipart/mixed;
 boundary="------------2B1FB7B5DD31122308AD4C30"
X-Ovh-Tracer-Id: 10456513910005335005
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelhedrieeigdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------2B1FB7B5DD31122308AD4C30
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

Le 20/03/2017 à 09:10, Jean-Noël Avila a écrit :

> So I guess you made your trials on 14.04. So, switching to 14.04 on
> Travis would help, at least for this patch series, but that would help
> much for the (close) future.

 that *would not* help much for the (close) future.

--------------2B1FB7B5DD31122308AD4C30
Content-Type: text/x-vcard; charset=utf-8;
 name="jean-noel_avila.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="jean-noel_avila.vcf"

begin:vcard
fn;quoted-printable:Jean-No=C3=ABl AVILA
n;quoted-printable:AVILA;Jean-No=C3=ABl
org:SCANTECH FRANCE
adr;quoted-printable:Savoie Technolac, BP244;;34, All=C3=A9e du Lac d'Aiguebelette;Le Bourget du Lac;;73374;FRANCE
email;internet:jean-noel.avila@scantech.fr
title:Embedded Systems Manager
tel;work:+33 479265450
tel;cell:+33 633046418
x-mozilla-html:FALSE
url:http://www.scantech.fr
version:2.1
end:vcard


--------------2B1FB7B5DD31122308AD4C30--
