Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URI_HEX shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC0AF1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 15:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfAGPPE (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 10:15:04 -0500
Received: from n2.nabble.com ([162.253.133.85]:61659 "EHLO n2.nabble.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbfAGPPD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 10:15:03 -0500
X-Greylist: delayed 535 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Jan 2019 10:15:03 EST
Received: from n2.nabble.com (localhost [127.0.0.1])
        by n2.nabble.com (Postfix) with ESMTP id 822296A19E63
        for <git@vger.kernel.org>; Mon,  7 Jan 2019 08:06:08 -0700 (MST)
Date:   Mon, 7 Jan 2019 08:06:08 -0700 (MST)
From:   paduarte <pantonio260@gmail.com>
To:     git@vger.kernel.org
Message-ID: <1546873568530-0.post@n2.nabble.com>
In-Reply-To: <1329837442995-7305031.post@n2.nabble.com>
References: <1329828722466-7304605.post@n2.nabble.com> <1329837442995-7305031.post@n2.nabble.com>
Subject: Re: cvs2git failed in pass2 ...
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi supadhyay

How did the complete command work?

cvs2git  --encoding=ascii --encoding=utf8 --encoding=utf16 --encoding=latin

or 

cvs2git --encoding=ascii --encoding=utf8 --encoding=utf16 --encoding=latin
*+ parameters of git*

?

Tks
:)



--
Sent from: http://git.661346.n2.nabble.com/
