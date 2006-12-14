X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: git-svnimport breakage as of git-1.4.4
Date: Thu, 14 Dec 2006 23:43:27 +0200
Message-ID: <20061214214327.GH7838@sashak.voltaire.com>
References: <1165505193.26874.13.camel@systems03.lan.brontes3d.com> <20061208203230.GA9193@sashak.voltaire.com> <1165847230.13854.2.camel@systems03.lan.brontes3d.com> <20061211204904.GC1003@sashak.voltaire.com> <1166027289.21948.4.camel@systems03.lan.brontes3d.com> <20061214022142.GA14521@sashak.voltaire.com> <1166130300.21982.0.camel@systems03.lan.brontes3d.com> <20061214212033.GG7838@sashak.voltaire.com> <7vejr217v7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 21:37:13 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vejr217v7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 14 Dec 2006 21:36:58.0307 (UTC) FILETIME=[FB93D130:01C71FC7]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34408>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuyGK-0003Sn-AR for gcvg-git@gmane.org; Thu, 14 Dec
 2006 22:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932939AbWLNVhE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 16:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932938AbWLNVhD
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 16:37:03 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:29744 "EHLO
 taurus.voltaire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932939AbWLNVhA (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 16:37:00 -0500
Received: from sashak ([172.25.5.176]) by taurus.voltaire.com with Microsoft
 SMTPSVC(6.0.3790.1830); Thu, 14 Dec 2006 23:36:58 +0200
Received: by sashak (sSMTP sendmail emulation); Thu, 14 Dec 2006 23:43:27
 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 13:32 Thu 14 Dec     , Junio C Hamano wrote:
> >
> > Thanks for reporting. I still run git-svnimport against
> > http://tortoisesvn.tigris.org/svn/tortoisesvn, works fine up to now.
> 
> An applicable version of the patch with proposed commit log
> message would be much appreciated.

Sure.

Wanted at least to finish the test (it is running yet), then will
submit the patch in conventional way.

