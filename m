X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: multi-project repos (was Re: Cleaning up git user-interface 
  warts)
Date: Fri, 17 Nov 2006 00:40:03 +0100
Message-ID: <455CF6D3.9050507@xs4all.nl>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org> <455C412D.1030408@xs4all.nl> <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org> <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org> <455CA2A8.5010700@xs4all.nl> <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org> <Pine.LNX.4.63.0611162315110.13772@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.
 0611161436230.3349@woody.osdl.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 23:42:00 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <Pine.LNX.4.64.0611161436230.3349@woody.osdl.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31638>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkqq7-0001e6-U5 for gcvg-git@gmane.org; Fri, 17 Nov
 2006 00:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424557AbWKPXkL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 18:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424569AbWKPXkL
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 18:40:11 -0500
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:24075 "EHLO
 smtp-vbr4.xs4all.nl") by vger.kernel.org with ESMTP id S1424557AbWKPXkJ
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 18:40:09 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kAGNdx2T023989; Fri, 17 Nov 2006 00:40:01 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds escreveu:
> A lot of the complaints seem to not be about the interfaces, but about 
> people not _understanding_ and knowing what the interfaces do. If you were 

From the point of view of a user, there is not really a difference
between the two.  As a user, you form a mental model of how things
work by looking at the interface. If the interface is bad, the user
creates a faulty model in his head, and starts doing things that
are perfectly logical in the faulty model, but stupid and silly when
you consider the actual internals.

A nice book about this is "The Design of Everyday Things" by Donald
Norman.

-- 
