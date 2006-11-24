X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Show remote branches on gitweb
Date: Sat, 25 Nov 2006 00:59:11 +0100
Message-ID: <20061124235911.GO7201@pasky.or.cz>
References: <loom.20061124T210559-701@post.gmane.org> <ek7jsp$j83$1@sea.gmane.org> <ek7m6m$qqd$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 23:59:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ek7m6m$qqd$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32247>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gnkww-0006RR-EK for gcvg-git@gmane.org; Sat, 25 Nov
 2006 00:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933772AbWKXX7O (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 18:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934382AbWKXX7O
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 18:59:14 -0500
Received: from w241.dkm.cz ([62.24.88.241]:25493 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S933772AbWKXX7N (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 18:59:13 -0500
Received: (qmail 26038 invoked by uid 2001); 25 Nov 2006 00:59:11 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Fri, Nov 24, 2006 at 09:56:29PM CET, Jakub Narebski wrote:
> Jakub Narebski wrote:
> 
> > Pazu wrote:
> > 
> >> Is there any way to do it? I'm using git-svn to track a remote subversion
> >> repository, and it would be very nice to browse the history for a remote branch
> >> for which I didn't start a local branch yet.
> > 
> > Planned, not implemented yet.
> 
> The problem is that to implement it _well_ we have to get remotes, both
> $GIT_DIR/remotes and config remote.xxx, info. And the latter (config
> remotes info) needs config parsing, something we lack.

Does that mean we _can_ parse $GIT_DIR/remotes? ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
