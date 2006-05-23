From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Make more commands builtin
Date: Tue, 23 May 2006 15:05:12 +0200
Organization: At home
Message-ID: <e4v1a0$u6c$1@sea.gmane.org>
References: <20060523122056.GA5777@bohr.gbar.dtu.dk> <e4uvku$o28$1@sea.gmane.org> <20060523125400.GA11128@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue May 23 15:07:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiWbe-0004ia-Dv
	for gcvg-git@gmane.org; Tue, 23 May 2006 15:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWEWNGx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 09:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWEWNGx
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 09:06:53 -0400
Received: from main.gmane.org ([80.91.229.2]:45549 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932206AbWEWNGw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 09:06:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FiWaS-0004MB-6u
	for git@vger.kernel.org; Tue, 23 May 2006 15:06:12 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 May 2006 15:06:12 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 May 2006 15:06:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20604>

Peter Eriksen wrote:

> On Tue, May 23, 2006 at 02:36:54PM +0200, Jakub Narebski wrote:
>> Peter Eriksen wrote:
>> 
>> > Btw.
>> > 
>> > I used these commands to produce the patch series:
>> > 
>> > git diff --stat -C 24b65a30015aedd..pe/builtin
>> > git-send-email --no-chain-reply-to --compose \
>> >                --from=s022018@student.dtu.dk --not-signed-off-by-cc \
>> >                --quiet \
>> >                --subject="Make more commands builtin" \
>> >                --to=git@vger.kernel.org Patches/*
>> 
>> I wonder why the patches themselves are not replies to the main/summary
>> email, i.e. "Make more commands builtin" email...
> 
> It seems thay are:
> 
> Subject: Make more commands builtin
> Message-Id: <11483865361243-git-send-email-1>
> 
> Subject: [PATCH 1/8] Builtin git-ls-files.
> Message-Id: <11483865362613-git-send-email-1>
> In-Reply-To: <11483865361243-git-send-email-1>

Ahh... I'm reading git mailing list through GMane NNTP interface.
It would be nice if git-send-email added 'References:' Usenet/news
header in addition to email one 'In-Reply-To:'.

-- 
Jakub Narebski
Warsaw, Poland
