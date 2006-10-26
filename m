X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 07:15:49 -0400
Message-ID: <20061026111549.GA15211@coredump.intra.peff.net>
References: <453F2FF8.2080903@op5.se> <200610251146.06116.jnareb@gmail.com> <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com> <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com> <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com> <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr> <20061026111338.GA15179@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 11:16:02 +0000 (UTC)
Cc: James Henstridge <james@jamesh.id.au>,
	Junio C Hamano <junkio@cox.net>,
	bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061026111338.GA15179@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30189>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd3DH-0002BU-0m for gcvg-git@gmane.org; Thu, 26 Oct
 2006 13:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752140AbWJZLPw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 07:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbWJZLPw
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 07:15:52 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:23446
 "HELO peff.net") by vger.kernel.org with SMTP id S1752140AbWJZLPv (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 07:15:51 -0400
Received: (qmail 12248 invoked from network); 26 Oct 2006 07:14:55 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 26 Oct 2006 07:14:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Oct
 2006 07:15:49 -0400
To: Vincent Ladeuil <v.ladeuil@alplog.fr>
Sender: git-owner@vger.kernel.org

On Thu, Oct 26, 2006 at 07:13:39AM -0400, Jeff King wrote:

> Yes (a commit is a tree, zero or more parents, commit message, and
> author/committer info).

Sorry, I should clarify: a commit is a _tree id_, zero or more _parent
ids_, commit message, etc.

