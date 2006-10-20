From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Remove git-send-email references from documentation
Date: Fri, 20 Oct 2006 16:46:32 +0200
Organization: At home
Message-ID: <ehang2$ujc$1@sea.gmane.org>
References: <E1GavIN-0007Vi-00@dvr.360vision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Oct 20 16:47:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gavec-0002xd-25
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 16:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946274AbWJTOrT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 10:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWJTOrT
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 10:47:19 -0400
Received: from main.gmane.org ([80.91.229.2]:12440 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932260AbWJTOrS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 10:47:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GaveD-0002su-Tb
	for git@vger.kernel.org; Fri, 20 Oct 2006 16:46:58 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 16:46:57 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 16:46:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29481>

Please configure your mailer to _not_ send emails in Multipart/Mixed form!
For example it screws up GMane news<->email interface.

andyparkins@gmail.com wrote:

> git-send-email doesn't exist; so don't refer to it in the documentation.
> 
> Perhaps git-send-email.perl is meant to do this job?  It runs with an
> error. 

Which git version do you use?

 1063:jnareb@roke:~/git> which git-send-email
 /usr/bin/git-send-email
 1064:jnareb@roke:~/git> rpm -qf /usr/bin/git-send-email
 git-email-1.4.2.1-1
 1065:jnareb@roke:~/git> git --version
 git version 1.4.2.1

git-send-email is created from git-send-email.perl during instalation
(by make install). And it works.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
