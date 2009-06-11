Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 10327 invoked by uid 107); 11 Jun 2009 15:46:17 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Thu, 11 Jun 2009 11:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbZFKPp5 (ORCPT <rfc822;peff@peff.net>);
	Thu, 11 Jun 2009 11:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbZFKPp5
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 11:45:57 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:42956 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbZFKPp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 11:45:56 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090611154559.SOBH17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 11 Jun 2009 11:45:59 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2fly1c00G4aMwMQ04flyZy; Thu, 11 Jun 2009 11:45:59 -0400
X-VR-Score: -10.00
X-Authority-Analysis: v=1.0 c=1 a=BAjMoHc70cUA:10 a=UCtxeOKJ4AkA:10
X-CM-Score: 0.00
To:	Nick Woolley <nickwoolley@yahoo.co.uk>
Cc:	Mike Ralphson <mike.ralphson@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] git-cvsexportcommit can't commit files which have been removed from CVS
References: <4A1F1CF5.8030002@yahoo.co.uk>
	<e2b179460906100106x2b9c0bb4r931b0a12959d4314@mail.gmail.com>
	<4A311053.5060802@yahoo.co.uk>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Thu, 11 Jun 2009 08:45:58 -0700
In-Reply-To: <4A311053.5060802@yahoo.co.uk> (Nick Woolley's message of "Thu\, 11 Jun 2009 15\:10\:27 +0100")
Message-ID: <7vy6ryixjd.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

