From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] Make gc a builtin.
Date: Tue, 13 Mar 2007 01:48:09 +0100
Organization: At home
Message-ID: <et4s76$9u3$1@sea.gmane.org>
References: <11736508181273-git-send-email-jbowes@dangerouslyinc.com> <20070312025736.GA28505@thunk.org> <Pine.LNX.4.63.0703121222350.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070312133612.GD4372@thunk.org> <Pine.LNX.4.64.0703121202560.9690@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 01:46:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQv9j-0005h3-24
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 01:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbXCMAqT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 20:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752546AbXCMAqT
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 20:46:19 -0400
Received: from main.gmane.org ([80.91.229.2]:48801 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535AbXCMAqS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 20:46:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HQv9A-00060E-In
	for git@vger.kernel.org; Tue, 13 Mar 2007 01:45:49 +0100
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Mar 2007 01:45:48 +0100
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Mar 2007 01:45:48 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42099>

Linus Torvalds wrote:

> Another thing I find annoying (even as a UNIX user) is that whenever I do 
> any tracing for performance data, shell is absolutely horrid. It's *so* 
> much nicer to do 'strace' on built-in programs that it's not even funny.

Isn't that what GIT_TRACE was made for?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
