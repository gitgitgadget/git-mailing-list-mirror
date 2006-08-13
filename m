From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Sun, 13 Aug 2006 11:29:00 +0200
Organization: At home
Message-ID: <ebmrbm$umk$1@sea.gmane.org>
References: <200608071626.52655.jnareb@gmail.com> <ebln1v$s6j$1@sea.gmane.org> <7v7j1dnzo5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Aug 13 11:28:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCCGo-0000dN-8a
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 11:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWHMJ2a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 05:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWHMJ2a
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 05:28:30 -0400
Received: from main.gmane.org ([80.91.229.2]:36748 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750858AbWHMJ2a (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Aug 2006 05:28:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GCCGg-0000cU-Jt
	for git@vger.kernel.org; Sun, 13 Aug 2006 11:28:26 +0200
Received: from host-81-190-24-83.torun.mm.pl ([81.190.24.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Aug 2006 11:28:26 +0200
Received: from jnareb by host-81-190-24-83.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Aug 2006 11:28:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-83.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25279>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> I have series of gitweb patches to send: should I make them pre-rename,
or
>> post-rename?
> 
> Do people happy with the general naming guidelines (I am)?
> 
> I'll be pushing out 1.4.2 this weekend, and then moving all the
> gitweb stuff pending in "next" to "master" after that.
> 
> Let's have the rename immediately on top of it first, then
> continue cleaning up after that.

So after 1.4.2 gitweb patches should be based on next, or on master?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
