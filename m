Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6186B20C32
	for <e@80x24.org>; Wed,  6 Dec 2017 22:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752235AbdLFWDj (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 17:03:39 -0500
Received: from mout.gmx.net ([212.227.17.21]:54377 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751990AbdLFWDi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 17:03:38 -0500
Received: from bedhanger.strangled.net ([188.193.86.106]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Mh5h7-1eivUR1pEf-00MOHz; Wed, 06 Dec 2017 23:02:58 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v7 4/7] checkout: describe_detached_head: remove ellipsis after committish
Date:   Wed,  6 Dec 2017 23:02:06 +0100
Message-Id: <20171206220206.3559-1-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
References: <20171203212743.10228-1-bedhanger@gmx.de> <20171119184113.16630-1-bedhanger@gmx.de> <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de> <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com> <20171119184113.16630-5-bedhanger@gmx.de> <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com> <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley> <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com> <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley> <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com> <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com> <20171124235330.15157-1-bedhanger@gmx.de> <xmqq4lpjkl4g.fsf@gitster.mtv.corp.google.com> <xmqqd145k9td.fsf@gitster.mtv.corp.google.com> <20171203212743.10228-4-bedhanger@gmx.de> <xmqqshcqmoe7.fsf@gitster.mtv.corp.google.com> <20171204231313.17929-1-bedhanger@gmx.de> <xmqq8tehjh6f.fsf@gitster.mtv.corp.google.com> <xmqqpo7rhkg7.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqpo7rhkg7.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:W6cuVH6n2+kYJodfCR+VvkyESLKp6FAZRvAsWeDetCWiej2+gHj
 Pdj1ea0LNOYU6juQk0DxWQM0er6SJtMIihXuqTeF5OX+yD4fB7TWM/fuPzUibFE1yvyNHor
 6HfDP62Tj+is3Xnp+bcUZHaJwQGTUPZI1OiYX348Wm6WUrmip2pQ3JyGYcd7zT81+Hn4Cfn
 ULhfGf/HTFCJ+98Na3++w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L7xBca//nqc=:IGaIYZwmBmhSN2nnXEwUFF
 IIpX3OSS4h4nhiPjuLLueBKyH4YlMPBE/4XN5YmrvfK6MmtzLE3WK+URo4YeXF8/+H5CPKG2e
 LSp8iJO9cxaunJCPnRm0Eb7zPGqR7LSqmsJTqnjLdgB85obAQ8+PvrTOwY2XIOS1j6NseU8u+
 lL9Kj9oFcSfwetifxUnBrbfO6oYwaTpYkEFt1r5v8KF+DA9QjO21KZhLE8sZrIHQXmxf7edes
 BWRs3vb2FndcN8LZxdso/Joi/FgEHZWcOcFkZoW5YP5ArPy/gSxwptY+7Wd6glsLYn4WEISQF
 HaonKnGY/WoSZW1q33zNfRGn1BeAkzF+RHY4hL100soEMHJXzE1ELEYxPTcjOwZ7k15x1E769
 LN3uGFXkOMGgO8bF+FGaVP1wm/8ephUVvbVTIMDRvBZF5xWklMzDo4ZOnV+h/GCiPGw4kV/ya
 UGkrIZDbNb0qp8FCWhFRAkT49TJZ99F5J/zXw21JYXNMpCWRdevqFmQmpZNln2rMiG+cVbT1C
 mV7cW4Vc1Uh4IBsrsw+de25ylQDFud4mW4A76ItdPOAA2Qopzc0bUtvV5vLnDSVagz8gN10YE
 8E3F72y1u8sv6ERw2xtGxMtgqmN5NkHYrAJ88v19jqLjIHBQ54tkDCwq3idM8AB8KZ0jqvDHc
 tq44VOtnP8VwDrghWY3W4zg4BPgQ4nxAgzaoL6c9xkptbs78GJ2MVVQ6n2xXdm4xXSxsh2RaH
 j6/B/eAgPd8HnBbouuPwUDrwbVdhN0dbYWjL96kbAL2uIaU76n0BYgv5nyLcKhR0bSk/3UeMN
 TJIg64Lul9I4ARHyUwhrHpuR91Szw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I've however queued the following on top of the entire series.  I do
> not mind squashing it into this step, though.

> Subject: [PATCH] t2020: test variations that matter

That sounds and looks fine to me.  I'm going to do this on my
side (getting it from 'pu' once the squashing is done).

Thanks.
