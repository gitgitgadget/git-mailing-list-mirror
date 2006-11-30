X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Joseph Wakeling <joseph.wakeling@webdrake.net>
Subject: Re: git blame [was: git and bzr]
Date: Thu, 30 Nov 2006 19:24:22 +0100
Message-ID: <456F21D6.1060200@webdrake.net>
References: <45357CC3.4040507@utoronto.ca> <20061021130111.GL75501@over-yonder.net> <453F2FF8.2080903@op5.se> <200610251146.06116.jnareb@gmail.com> <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com> <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com> <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com> <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr> <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net> <Pine.LNX.4.64.0611271834090.30076@woody.osdl.org> <456CEF31.8080600@webdrake.net> <Pine.LNX.4.64.0611281906520.3395@woody.osdl.org> <456D7A76.3080605@webdrake.net> <Pine.LNX.4.64.0611290830010.3395@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 18:25:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
In-Reply-To: <Pine.LNX.4.64.0611290830010.3395@woody.osdl.org>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32784>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpqaL-0007UH-D8 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 19:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030981AbWK3SYf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 13:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030988AbWK3SYf
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 13:24:35 -0500
Received: from alf.nbi.dk ([130.225.212.55]:10768 "EHLO alf.nbi.dk") by
 vger.kernel.org with ESMTP id S1030981AbWK3SYe (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 13:24:34 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by alf.nbi.dk
 (8.9.3/8.9.3) with ESMTP id TAA32767; Thu, 30 Nov 2006 19:24:22 +0100 (MET)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> So it's fixed now, and probably would never trigger except for the stupid 
> special case that was "let's just show an example of this" ;)

I'm very happy my stupidity could help. ;-)

On a related note ...

Nicholas Allen wrote:
> Thanks for the informative response. It helped but I'm still slightly
> confused by git - I think I need to play around with it a bit more to
> understand and get more familiar with the concepts...
>  
> Purely from an initial usage point of view though, for me at least, the
> bzr output needed no explanation which I think is indicative of a good
> user interface whereas the git was not so clear or obvious - there must
> be room for improvement in git's user friendliness here surely. But that
> might just be because I am clueless when it comes to the way git works
> and the concepts it uses ;-)

I do think that bzr has quite an intuitive set of commands, and it is
easy to learn, though at this point I don't feel git is really *that*
much more difficult in itself.  Although the terminal output for some
problems could be improved, most of my difficulties are stemming from
overlap of command names when the commands themselves do different
things, and the fact that git's documentation is somewhat more technical
than bzr's.

What would be nice would be to have in the documentation a whole bunch
of stupid examples for the main commands, something where someone can
create a repo from scratch, create and modify some simple files
according to instructions, and see the particular command in action.
The tutorials do this, of course, but only for a few cases, when to be
honest it's the more complex commands that most need such explanation.
For beginners, especially less technically skilled ones, it would be
good to have a lot more of, "Do this, here's what git will respond, this
is what it means, here's how to fix it...."

As a relatively non-technical user, perhaps I should keep track of my
difficulties (and others') and try to write something up.

