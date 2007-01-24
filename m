From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to pull only a few files from one branch to another?
Date: Wed, 24 Jan 2007 10:32:33 +0100
Organization: At home
Message-ID: <ep791o$h2u$2@sea.gmane.org>
References: <17846.53626.895660.762096@lisa.zopyra.com> <Pine.LNX.4.64.0701240019250.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 24 10:35:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9eXA-0003yy-FD
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 10:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbXAXJfI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 04:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbXAXJfI
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 04:35:08 -0500
Received: from main.gmane.org ([80.91.229.2]:45228 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783AbXAXJfG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 04:35:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1H9eX0-0003kj-A3
	for git@vger.kernel.org; Wed, 24 Jan 2007 10:35:02 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 10:35:02 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 10:35:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37615>

Daniel Barkalow wrote:

> (Incidentally, I think "git diff ^ {commit}" should be made to do "git 
> diff {commit}^ {commit}"; i.e., if there is a single other revision 
> provided, interpret a modifier not applied to anything as applying to that 
> revision, in the "what else could that possibly mean?" department.)

"git diff <commit>^!" doesn't work?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
