X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 00:29:17 +0200
Organization: At home
Message-ID: <ehooeo$1g6$2@sea.gmane.org>
References: <453DAC87.8050203@research.canon.com.au> <Pine.LNX.4.64.0610232318200.3962@g5.osdl.org> <Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu> <Pine.LNX.4.64.0610240812410.3962@g5.osdl.org> <Pine.LNX.4.64N.0610241300450.8112@attu4.cs.washington.edu> <20061025084810.GA26618@coredump.intra.peff.net> <Pine.LNX.4.64N.0610250157470.3467@attu1.cs.washington.edu> <20061025094900.GA26989@coredump.intra.peff.net> <453F6B7A.60805@op5.se> <Pine.LNX.4.63.0610251450040.1754@qynat.qvtvafvgr.pbz> <20061025221531.GB10140@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 25 Oct 2006 22:29:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 31
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30112>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcrFK-0007Xf-5B for gcvg-git@gmane.org; Thu, 26 Oct
 2006 00:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965240AbWJYW3K (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 18:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965241AbWJYW3K
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 18:29:10 -0400
Received: from main.gmane.org ([80.91.229.2]:54226 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S965240AbWJYW3I (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 18:29:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GcrF1-0007UN-NF for git@vger.kernel.org; Thu, 26 Oct 2006 00:28:57 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 00:28:55 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 26 Oct 2006
 00:28:55 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:

> David Lang <dlang@digitalinsight.com> wrote:
>> a quick lesson on program nameing
>> 
>> On Wed, 25 Oct 2006, Andreas Ericsson wrote:
>> 
>> >I'm personally all for a rewrite of the necessary commands in C ("commit" 
>> >comes to mind), but as many others, I have no personal interest in doing 
>> >the actual work. I'm fairly certain that once we get it working natively 
>> >on windows with some decent performance, windows hackers will pick up the 
>> >ball and write "wingit", which will be a log viewer and GUI thing for
>>              ^^^^^^
>> 
>> how many other people read this as 'wing it' rather then 'win git'? ;-)
> 
> Yes, that's certainly a less than optimal name...
> 
> What about gitk?  Is it "gi tk" or "git k" ?  This has actually
> been the source of much local debate.  :-)

You can always use CamelCase, i.e. WinGit or WinGIT (or wgit,
but this is also silly).

Cute names are taken: CoGITo, gitk, qgit (GTK+ history viewer is gitview,
not ggit, curiously ;-) and tig.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

