X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 22:28:24 +0200
Organization: At home
Message-ID: <ehlt09$ard$1@sea.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com> <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE> <vpq4ptz2uh8.fsf@ecrins.imag.fr> <453DAC87.8050203@research.canon.com.au> <Pine.LNX.4.64.0610232318200.3962@g5.osdl.org> <Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu> <Pine.LNX.4.64.0610240812410.3962@g5.osdl.org> <Pine.LNX.4.64N.0610241300450.8112@attu4.cs.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 24 Oct 2006 20:31:02 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Followup-To: gmane.comp.version-control.bazaar-ng.general
Original-Lines: 19
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30011>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcSui-0001FR-SQ for gcvg-git@gmane.org; Tue, 24 Oct
 2006 22:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965182AbWJXUaR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 16:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbWJXUaQ
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 16:30:16 -0400
Received: from main.gmane.org ([80.91.229.2]:17827 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S965182AbWJXUaP (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 16:30:15 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GcSuP-0001Aj-VH for git@vger.kernel.org; Tue, 24 Oct 2006 22:30:02 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 24 Oct 2006 22:30:01 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 24 Oct 2006
 22:30:01 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

David Rientjes wrote:

> This is the reason why I was a fan of git long ago and used it for my own 
> needs before tons of unnecessary features and unneeded complexity was 
> added on.

But you can still use git as you used it long time ago. The plumbing
commands didn't vanish. Git got rich in porcelanish commands, true, but old
core remains. And GIT_TRACE (quite new addition) certainly helps.

I think git profit very much from being created bottom-up, from main idea of
SCM, through repository format and structure, through plumbing commands,
through porcelain done with scripts, to having many new plumbing commands,
to having many commands builtin, in the future to libification perhaps.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

