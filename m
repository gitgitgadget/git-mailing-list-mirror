X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Theodore Tso <tytso@mit.edu>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 11:49:39 -0500
Message-ID: <20061116164939.GA26278@thunk.org>
References: <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <20061116011411.GB10512@thunk.org> <7vd57of2cv.fsf@assigned-by-dhcp.cox.net> <20061116160700.GA3383@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 16:50:14 +0000 (UTC)
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061116160700.GA3383@thunk.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31599>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkkQo-0001WL-6f for gcvg-git@gmane.org; Thu, 16 Nov
 2006 17:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424285AbWKPQtc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 11:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424294AbWKPQtc
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 11:49:32 -0500
Received: from thunk.org ([69.25.196.29]:2226 "EHLO thunker.thunk.org") by
 vger.kernel.org with ESMTP id S1424292AbWKPQtb (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 11:49:31 -0500
Received: from root (helo=candygram.thunk.org) by thunker.thunk.org with
 local-esmtps  (tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1
 (Debian)) id 1GkkU4-0003lA-9A; Thu, 16 Nov 2006 11:53:04 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
 (envelope-from <tytso@thunk.org>) id 1GkkQl-0000kn-WC; Thu, 16 Nov 2006
 11:49:40 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Thu, Nov 16, 2006 at 11:07:00AM -0500, Theodore Tso wrote:
> I think the problem is the people who have had years of BK or Hg
> experience.  Maybe it's more of a documentation problem; perhaps a
> "git for BK" or "git for Hg" users is what's needed.  The problem
> though is that while use of BK is definitely legacy, there are going
> to be a lot of people who need to use both BK and Hg.   

Err, what I meant to say is that there are going to be a lot of people
who will need to simultaneously use both git and Hg.

