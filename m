X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remove an unneeded test
Date: Tue, 7 Nov 2006 20:15:49 -0500
Message-ID: <20061108011549.GA11971@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0611071239560.18014@jalava.cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 01:15:59 +0000 (UTC)
Cc: git@vger.kernel.org, Tero Roponen <teanropo@jyu.fi>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611071239560.18014@jalava.cc.jyu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31108>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghc2k-0000Te-Rb for gcvg-git@gmane.org; Wed, 08 Nov
 2006 02:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753691AbWKHBPw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 20:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753777AbWKHBPw
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 20:15:52 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:33258
 "HELO peff.net") by vger.kernel.org with SMTP id S1753691AbWKHBPv (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 20:15:51 -0500
Received: (qmail 8832 invoked from network); 7 Nov 2006 20:14:55 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 7 Nov 2006 20:14:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Nov
 2006 20:15:49 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Tue, Nov 07, 2006 at 12:44:33PM +0200, Tero Roponen wrote:

> In wt-status.c there is a test which does nothing.
> This patch removes it.

Junio, please apply. This is leftover from an edit; there's no missing
statement which is supposed to go there.

