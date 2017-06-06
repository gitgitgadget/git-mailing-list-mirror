Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 814C6209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 14:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbdFFOrh (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 10:47:37 -0400
Received: from mail2.pdinc.us ([67.90.184.28]:50866 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751741AbdFFOrg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 10:47:36 -0400
Received: from blackfat (234.sub-97-34-194.myvzw.com [97.34.194.234])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id v56ElMCM009821;
        Tue, 6 Jun 2017 10:47:23 -0400
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     "'Adam Dinwoodie'" <adam@dinwoodie.org>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "=?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0_Bjarmason'?=" <avarab@gmail.com>,
        "'Ramsay Jones'" <ramsay@ramsayjones.plus.com>
References: <20170605203409.GB25777@dinwoodie.org> <CACBZZX6vOr+ZjUaAf8i1xdjEFfY_Exj+_Xn2-1u0RcWoLy+X1g@mail.gmail.com> <xmqq4lvtap3m.fsf@gitster.mtv.corp.google.com> <20170606100355.GC25777@dinwoodie.org> <xmqqmv9l8h5z.fsf@gitster.mtv.corp.google.com> <20170606124323.GD25777@dinwoodie.org>
In-Reply-To: <20170606124323.GD25777@dinwoodie.org>
Subject: Continous Integration (was: RE: Git v2.13.1 SHA1 very broken)
Date:   Tue, 6 Jun 2017 10:47:20 -0400
Organization: PD Inc
Message-ID: <6D15A44412C346E2822A74A91FDF77B1@blackfat>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdLewoOYC1BEZfyuSGyPGtDqab71AAAEN5TQ
X-MimeOLE: Produced By Microsoft MimeOLE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do we have Jenkins (or something else) setup for Git?

We would be happy to donate (slave) VMs for cygwin builds og Git.  

-Jason Pyeron

