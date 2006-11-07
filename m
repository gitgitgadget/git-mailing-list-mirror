X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: fork0@t-online.de (Alex Riesen)
Subject: Re: win2k/cygwin cannot handle even moderately sized packs
Date: Tue, 7 Nov 2006 20:27:59 +0100
Message-ID: <20061107192759.GA4484@steel.home>
References: <81b0412b0611070302h50541cd5mf0758afe0d6befda@mail.gmail.com> <45507965.3010806@peralex.com> <81b0412b0611070555u1833cc8ci1d37d45782562df8@mail.gmail.com> <eiq9vm$l7c$1@sea.gmane.org> <81b0412b0611070928l7be83e08kbfc9657937fe7c92@mail.gmail.com> <20061107174859.GB26591@spearce.org> <81b0412b0611071013j51254a40s749fb6cba65e6873@mail.gmail.com> <20061107181808.GC26591@spearce.org> <20061107182636.GD26591@spearce.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 7 Nov 2006 19:29:10 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061107182636.GD26591@spearce.org>
User-Agent: Mutt/1.5.11
X-ID: SrCO+eZSoeGj3bqs2E9dpQcoRMW-8J1DvCRGOr9bTOv3ZH+AUWlZcK
X-TOI-MSGID: 0ce9762b-2f42-4bb7-b9de-83c357115ba1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31090>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhWcN-0004fM-NT for gcvg-git@gmane.org; Tue, 07 Nov
 2006 20:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751907AbWKGT2P (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 14:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbWKGT2P
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 14:28:15 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:28374 "EHLO
 mailout02.sul.t-online.com") by vger.kernel.org with ESMTP id
 S1751907AbWKGT2O (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006
 14:28:14 -0500
Received: from fwd35.aul.t-online.de  by mailout02.sul.t-online.com with smtp
  id 1GhWc8-0007oC-04; Tue, 07 Nov 2006 20:28:04 +0100
Received: from tigra.home
 (SrCO+eZSoeGj3bqs2E9dpQcoRMW-8J1DvCRGOr9bTOv3ZH+AUWlZcK@[84.163.93.166]) by
 fwd35.sul.t-online.de with esmtp id 1GhWc5-0tNykq0; Tue, 7 Nov 2006 20:28:01
 +0100
Received: from steel.home (steel.home [192.168.1.2]) by tigra.home (Postfix)
 with ESMTP id 85DC5277AF; Tue,  7 Nov 2006 20:28:00 +0100 (CET)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian)) id
 1GhWc4-0001JE-0B; Tue, 07 Nov 2006 20:28:00 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce, Tue, Nov 07, 2006 19:26:36 +0100:
> Too f'ing bad this .patch I created with format-patch doesn't say
> what commits it was based on, 'cause I can't find anything it will
> apply too.  Or better, too f'ing bad I deleted that branch.  *sigh*

Maybe you just send the patch anyway? It could give someone an idea
where to start, or what not to do...
