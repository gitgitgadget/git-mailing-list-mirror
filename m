From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: PATCH: fix git-fmt-merge-msg on ActiveState Perl
Date: Tue, 21 Feb 2006 23:18:01 +0100
Message-ID: <20060221221801.GC5948@steel.home>
References: <81b0412b0602210745i637692d3p5462c2b3a00df793@mail.gmail.com> <81b0412b0602210748t76d02007s316081a04ee685c8@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 21 23:18:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBfpo-00053w-U4
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 23:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbWBUWSJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 17:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161114AbWBUWSJ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 17:18:09 -0500
Received: from devrace.com ([198.63.210.113]:31507 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1161095AbWBUWSH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 17:18:07 -0500
Received: from tigra.home (p54A05C42.dip.t-dialin.net [84.160.92.66])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k1LMI2Dt076203;
	Tue, 21 Feb 2006 16:18:03 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FBfpZ-0000cy-00; Tue, 21 Feb 2006 23:18:01 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FBfpZ-0001uq-4V; Tue, 21 Feb 2006 23:18:01 +0100
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <81b0412b0602210748t76d02007s316081a04ee685c8@mail.gmail.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16562>

Alex Riesen, Tue, Feb 21, 2006 16:48:43 +0100:
> On 2/21/06, Alex Riesen <raa.lkml@gmail.com> wrote:
> > For people who stuck with ActiveState Perl, as there seem to be
> > no chance for it to support the list form of "open" in foreseeable future.
> 
> Too late... Sorry :)

Not too late, actually. It'll work for everyone with ActiveState Perl
