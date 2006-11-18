X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Possible but in gitweb
Date: Sat, 18 Nov 2006 19:41:42 +0100
Message-ID: <20061118184142.GN7201@pasky.or.cz>
References: <4d8e3fd30611180858xf28e958g8511f2eb68d53848@mail.gmail.com> <ejng62$k2m$1@sea.gmane.org> <4d8e3fd30611180942p548a92d1ufc9e0dcfabedb59@mail.gmail.com> <200611181901.31708.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 18:42:01 +0000 (UTC)
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611181901.31708.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31787>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlV8O-0006uy-HL for gcvg-git@gmane.org; Sat, 18 Nov
 2006 19:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755314AbWKRSlp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 13:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755317AbWKRSlp
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 13:41:45 -0500
Received: from w241.dkm.cz ([62.24.88.241]:15073 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1755314AbWKRSlo (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 13:41:44 -0500
Received: (qmail 18812 invoked by uid 2001); 18 Nov 2006 19:41:43 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Sat, Nov 18, 2006 at 07:01:30PM CET, Jakub Narebski wrote:
> Paolo Ciarrocchi wrote:
> > On 11/18/06, Jakub Narebski <jnareb@gmail.com> wrote:
> >> Paolo Ciarrocchi wrote:
> >>>
> >>> Browsing the repo I reach the following URL
> >>> http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git?a=blob;f=LinuxKernelDevelopmentProcess.html;hb=HEAD
> >>> that is not accessible.
> >>
> >> Because HEAD is master, not html, and there us no such file in master branch?
> > 
> > Fair enough but then there should be no link in the web interface.
> > That sounds like a bug in the interface.
> 
> Where did you find this link? On what page?
> 
> "Browsing the repo" is not enough information to discover where
> there is a bug.

It's not really hard to find. :-)

http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git?a=blob;f=LinuxKernelDevelopmentProcess.html;h=b5e39498997930cd14ecddfe120f62c577ce2e28;hb=html

I think the link shouldn't be 'HEAD' but 'latest' and point to the
latest version in the currently browser branch.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
