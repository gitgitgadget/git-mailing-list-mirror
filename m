X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Documentation/git-commit.txt
Date: Fri, 8 Dec 2006 23:42:13 -0500
Message-ID: <20061209044213.GC18204@fieldses.org>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612082141260.2630@xanadu.home> <7vpsatelvv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 9 Dec 2006 04:42:25 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vpsatelvv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33800>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsu2W-0005jN-S8 for gcvg-git@gmane.org; Sat, 09 Dec
 2006 05:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758360AbWLIEmR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 23:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758525AbWLIEmR
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 23:42:17 -0500
Received: from mail.fieldses.org ([66.93.2.214]:60741 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1758360AbWLIEmR (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 23:42:17 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1Gsu2P-0007HE-UO; Fri, 08 Dec 2006
 23:42:13 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Fri, Dec 08, 2006 at 08:25:24PM -0800, Junio C Hamano wrote:
> Hmmm.  I was merely trying to respond with recent requests on
> the list (might have been #git log) to make common usage
> examples more prominent.  While I feel that following the UNIXy
> manpage tradition to push examples down is the right thing to
> do, you and I are not the primary audience of Porcelain
> manpages, so...

I think manpages are primarily reference documents, so it's more
important to be able to get to the list of options without paging down
too far....

We could always say "see EXAMPLES below for more detail", or "see the
chapter 3 of the tutorial/user manual/whatever".

