X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: What's in git.git
Date: Sun, 19 Nov 2006 18:01:23 +0100
Message-ID: <20061119170123.GV7201@pasky.or.cz>
References: <7v64dcbdgb.fsf@assigned-by-dhcp.cox.net> <7v1wo0bb4z.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0611191547460.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 19 Nov 2006 17:01:52 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	alp@atoker.com, jonsmirl@gmail.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0611191547460.13772@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31841>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glq34-0007d2-Ch for gcvg-git@gmane.org; Sun, 19 Nov
 2006 18:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756789AbWKSRBZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 12:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756791AbWKSRBZ
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 12:01:25 -0500
Received: from w241.dkm.cz ([62.24.88.241]:1934 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1756789AbWKSRBZ (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 12:01:25 -0500
Received: (qmail 3904 invoked by uid 2001); 19 Nov 2006 18:01:23 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Sun, Nov 19, 2006 at 04:17:17PM CET, Johannes Schindelin wrote:
> As for shallow clone support: I am a bit underwhelmed by the enthusiasm 
> to test this thing by the people I thought would be most interested. It 
> really could be the case that it is not needed at all.

I was underwhelmed all the same by response to my multifetch work.
Perhaps we need some better mechanism to get feedback from the
downstream users which were main requesters of the $feature (I think
that in both cases people can see how it could be useful generically but
there's not too much immediate enthusiasm for playing with it inside the
community). I think the main user of multifetch was xorg while the
primary user of shallow clones would be Mozilla, right?

It would be great if, when wishing for some large feature, they could
say something like "if this ever gets done, please prod $mailinglist and
we'll give it a stab and get you some feedback" (apparently there's
noone from there monitoring the mailing list consistently, which is
understandable though since it's not a too much low-traffic one).

Alp? (xorg) Jon? (mozilla)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
