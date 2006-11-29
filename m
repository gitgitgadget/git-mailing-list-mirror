X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: xdl_merge(), was Re: [PATCH 0/2] Making "git commit" to mean "git
 commit -a".
Date: Wed, 29 Nov 2006 22:50:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611292248310.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
 <7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net> <87bqmswm1e.wl%cworth@cworth.org>
 <7vodqse90q.fsf@assigned-by-dhcp.cox.net> <87ac2cwha4.wl%cworth@cworth.org>
 <7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net> <878xhwwdyj.wl%cworth@cworth.org>
 <7vk61gcnzl.fsf@assigned-by-dhcp.cox.net> <7vd5786opj.fsf@assigned-by-dhcp.cox.net>
 <871wnnwi3k.wl%cworth@cworth.org> <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611282322320.9647@xanadu.home> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611291234350.9647@xanadu.home> <7vzmaaozi8.fsf@assigned-by-dhcp.cox.net>
 <456DDADC.7030509@midwinter.com> <Pine.LNX.4.63.0611292059480.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vlkluoulf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 29 Nov 2006 21:50:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vlkluoulf.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32672>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpXK2-00089O-2J for gcvg-git@gmane.org; Wed, 29 Nov
 2006 22:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758150AbWK2Vu0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 16:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758151AbWK2Vu0
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 16:50:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:40853 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1758150AbWK2VuZ (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 16:50:25 -0500
Received: (qmail invoked by alias); 29 Nov 2006 21:50:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp037) with SMTP; 29 Nov 2006 22:50:24 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 29 Nov 2006, Junio C Hamano wrote:

> By the way, I've been having fun with the xdl_merge() stuff; thanks for 
> a job well done.  I will push some of it out in 'pu' shortly.

Oh *blush*, I fixed a few things since I sent that out... Will submit the 
remaining things as soon as the beast shows up in pu.

Ciao,
Dscho
