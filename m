X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 21 Nov 2006 13:01:27 -0500
Message-ID: <20061121180127.GB27221@fieldses.org>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org> <20061120232507.GH12285@fieldses.org> <20061120233333.GD20736@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 18:02:56 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061120233333.GD20736@admingilde.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32009>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmZwN-0003IX-Ac for gcvg-git@gmane.org; Tue, 21 Nov
 2006 19:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031235AbWKUSBr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 13:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031243AbWKUSBq
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 13:01:46 -0500
Received: from mail.fieldses.org ([66.93.2.214]:6035 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S1031235AbWKUSBq
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 13:01:46 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GmZw0-0007DT-38; Tue, 21 Nov 2006
 13:01:28 -0500
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

On Tue, Nov 21, 2006 at 12:33:34AM +0100, Martin Waitz wrote:
> On Mon, Nov 20, 2006 at 06:25:07PM -0500, J. Bruce Fields wrote:
> > Would it also be possible to allow the "Tree:" line in the commit object
> > to refer to a commit, or does the root of the project need to be a
> > special case?
> 
> this would then be something like the branch-archival proposal.

Do you have any pointers to previous discussion?  (A couple obvious
searches don't turn up anything for me.)

