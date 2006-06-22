From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Tracking CVS
Date: Thu, 22 Jun 2006 19:14:33 +0200
Organization: At home
Message-ID: <e7ej5o$1p6$1@sea.gmane.org>
References: <9e4733910606220541y15d66fa6t33ab0c80ae05f764@mail.gmail.com> <20060622135831.GB21864@pasky.or.cz> <7vveqtp1dl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Jun 22 19:15:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtSlq-0001bs-W7
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 19:15:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbWFVRPH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 13:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbWFVRPG
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 13:15:06 -0400
Received: from main.gmane.org ([80.91.229.2]:38300 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751835AbWFVRPF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 13:15:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FtSlS-0001XA-13
	for git@vger.kernel.org; Thu, 22 Jun 2006 19:14:46 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 19:14:45 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 19:14:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22349>

Junio C Hamano wrote:

> Petr Baudis <pasky@suse.cz> writes:
 
>> Perhaps we might make a special command which would sync the index set
>> with the working copy set...
> 
> I think that makes sense.  Something like what "git-commit -a"
> does before making a commit.

Isn't that what "git update-index --again" does? 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
