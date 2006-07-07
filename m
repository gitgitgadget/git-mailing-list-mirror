From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Does Git run on Windows ?
Date: Fri, 07 Jul 2006 21:05:16 +0200
Organization: At home
Message-ID: <e8mb8r$t1u$2@sea.gmane.org>
References: <01c001c6a0a7$a2783f90$0200a8c0@AMD2500> <Pine.LNX.4.63.0607060830060.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jul 07 21:15:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyvnL-0007Hy-0M
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 21:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWGGTPP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 15:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWGGTPP
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 15:15:15 -0400
Received: from main.gmane.org ([80.91.229.2]:16564 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932267AbWGGTPN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 15:15:13 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Fyvn4-0007Er-Hq
	for git@vger.kernel.org; Fri, 07 Jul 2006 21:15:02 +0200
Received: from host-81-190-22-25.torun.mm.pl ([81.190.22.25])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Jul 2006 21:15:02 +0200
Received: from jnareb by host-81-190-22-25.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Jul 2006 21:15:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-22-25.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23459>

Johannes Schindelin wrote:
 
> On Thu, 6 Jul 2006, Aaron Gray wrote:
>
>> Its got lots of C code, and Bash scripts, with a couple of Perl scripts.
> 
> And you completely forgot Python.

If I remember correctly the only Python dependency was recursive merge
strategy, currently being reworked in C.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
