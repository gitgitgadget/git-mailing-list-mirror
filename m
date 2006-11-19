X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [DRAFT] Branching and merging with git
Date: Sun, 19 Nov 2006 12:50:40 -0500
Message-ID: <20061119175040.GB15608@fieldses.org>
References: <20061116221701.4499.qmail@science.horizon.com> <20061117153246.GA20065@thunk.org> <20061117182157.GC11882@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 19 Nov 2006 17:51:01 +0000 (UTC)
Cc: linux@horizon.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061117182157.GC11882@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31844>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glqoi-0001Lf-Ph for gcvg-git@gmane.org; Sun, 19 Nov
 2006 18:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932306AbWKSRuo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 12:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWKSRun
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 12:50:43 -0500
Received: from mail.fieldses.org ([66.93.2.214]:55975 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S932306AbWKSRum (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 12:50:42 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GlqoS-0004HI-CG; Sun, 19 Nov 2006
 12:50:40 -0500
To: Theodore Tso <tytso@mit.edu>
Sender: git-owner@vger.kernel.org

On Fri, Nov 17, 2006 at 01:21:57PM -0500, bfields wrote:
> On Fri, Nov 17, 2006 at 10:32:46AM -0500, Theodore Tso wrote:
> > It would be nice if there was an easy way to direct users through the
> > documentation in a way which makes good pedagogical sense.
....
> How about this as a strawman "git user's manual" outline:

In fact, I'm tempted to submit a patch that just assigns a chapter
number to everything under Documentation/, slaps a single table of
contents on the front, and calls the result "the git user's manual."

Of course, the moment people started trying to read the thing they'd
complain that it was a mess--some stuff referenced without being
introduced, other stuff introduced too many times.  But then over time
maybe that'd force us to mold it into some sort of logical sequence.

