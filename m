From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git
Date: Fri, 04 Aug 2006 20:55:08 +0200
Organization: At home
Message-ID: <eb0554$1pu$1@sea.gmane.org>
References: <7v7j1on71n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Aug 04 20:55:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G94pO-00038t-9X
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 20:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWHDSzS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 14:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWHDSzS
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 14:55:18 -0400
Received: from main.gmane.org ([80.91.229.2]:33971 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751449AbWHDSzR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 14:55:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G94or-00031y-Th
	for git@vger.kernel.org; Fri, 04 Aug 2006 20:54:51 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 20:54:49 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 20:54:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24818>

Junio C Hamano wrote:

>   - Ramsay Allan Jones has introduced "NO_C99_FORMAT" Makefile
>     variable to help running things with a C library that does
>     not support %zu and %td format.  This would be a good target
>     for autoconf work by Jakub (hint hint).

See [PATCH 2/4] in this thread (introductory message somehow got lost).
Testing on system which doesn't have C99 format specifiers would be
appreciated.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
