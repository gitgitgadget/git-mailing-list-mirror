X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Patch to tutorial.txt
Date: Mon, 20 Nov 2006 14:13:21 +0100
Message-ID: <20061120131321.GA7201@pasky.or.cz>
References: <4d8e3fd30611191444r710f23e5uc488d35aa4abaf06@mail.gmail.com> <ejqnh8$peb$1@sea.gmane.org> <4d8e3fd30611200030p1d117445qd3f7d619c18a0633@mail.gmail.com> <200611200949.32722.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 13:13:40 +0000 (UTC)
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611200949.32722.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31912>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm8xj-0000QE-Fv for gcvg-git@gmane.org; Mon, 20 Nov
 2006 14:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965844AbWKTNNY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 08:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965864AbWKTNNY
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 08:13:24 -0500
Received: from w241.dkm.cz ([62.24.88.241]:22954 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S965844AbWKTNNX (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 08:13:23 -0500
Received: (qmail 26046 invoked by uid 2001); 20 Nov 2006 14:13:21 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Mon, Nov 20, 2006 at 09:49:31AM CET, Jakub Narebski wrote:
> On Mon, 20 Nov 2006, Paolo Ciarrocchi wrote:
> > On 11/19/06, Jakub Narebski <jnareb@gmail.com> wrote:
> >> Paolo Ciarrocchi wrote:
> >> [...]
> >>>  ------------------------------------------------
> >>>
> >>>  at this point the two branches have diverged, with different changes
> >>> -made in each.  To merge the changes made in the two branches, run
> >>> +made in each.  To merge the changes made in experimental into master run
> >>
> >> I would rather say:
> >>   To merge the changes made in the two branches into master, run
> > 
> > Why Jakub? There are only two branches, master and experimental.
> > While sitting in master and doing git pull . experimental I would
> > expect to merge I did in experimental into master. Changes did in
> > master are alreay merged in master. Am I wrong?
> 
> For me, "merge" in "to merge the changes" phrase is merge in common-sense
> meaning of the world, not the SCM jargon. Merge the changes == join the
> changes, so you have to give both sides, both changes you join.
> 
> Merge the changes == take changes in branch 'experimental' since forking,
> take changes in branch 'master' since forking, join those changes
> together (merge), and put the result of this joining (this merge) into
> branch 'master'.
> 
> On the contrary, in "merge branch 'experimenta' into 'master'" phrase
> "merge" is in the SCM meaning of this word.

I personally find the SVM meaning much less confusing, but I can't tell
how much I've been contaminated already - "merge in the two branches
into master" really strongly suggests to me that it's about some _other_
two branches.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
