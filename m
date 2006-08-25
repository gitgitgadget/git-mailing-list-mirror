From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 19/19] gitweb: Remove creating directory for temporary files
Date: Fri, 25 Aug 2006 23:48:21 +0200
Organization: At home
Message-ID: <ecnr6u$tu$1@sea.gmane.org>
References: <200608240015.15071.jnareb@gmail.com> <200608252135.27894.jnareb@gmail.com> <e5bfff550608251433o36713ee1na5544992320b5845@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Aug 25 23:48:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGjXY-0006g4-Qu
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 23:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWHYVsd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 17:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWHYVsd
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 17:48:33 -0400
Received: from main.gmane.org ([80.91.229.2]:27871 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751509AbWHYVsc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Aug 2006 17:48:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GGjXK-0006e3-Gm
	for git@vger.kernel.org; Fri, 25 Aug 2006 23:48:22 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 23:48:22 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 23:48:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26018>

Marco Costalba wrote:

>> You can view new gitweb in work at
>>   http://front.fuw.edu.pl/cgi-bin/jnareb/gitweb.cgi
>>
> 
> Very nice job!
> 
> Just a couple of suggestion regarding blame.

Well, blame code is not mine. 

Luben Tuikov did some work on git_blame2 (using git-blame), original work
was by Florian Forster (using git-annotate). At least it is what I found.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
