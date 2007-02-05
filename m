From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Deprecation/Removal schedule
Date: Mon, 05 Feb 2007 11:11:39 +0100
Organization: At home
Message-ID: <eq6vq5$r7v$1@sea.gmane.org>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net> <eq6tj6$80m$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 05 11:11:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE0oP-00048Q-Us
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 11:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbXBEKK6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 05:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbXBEKK6
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 05:10:58 -0500
Received: from main.gmane.org ([80.91.229.2]:45793 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146AbXBEKK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 05:10:58 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HE0nv-0002vH-12
	for git@vger.kernel.org; Mon, 05 Feb 2007 11:10:31 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 11:10:31 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 11:10:31 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38738>

Jakub Narebski wrote:

> Junio C Hamano wrote:

>> * git-p4import, git-quiltimport and contrib/gitview
>> 
>>   These have seen almost no activity since their appearance.  It
>>   could be that they are already perfect and many people are
>>   using them happily, but I find it a bit hard to believe.
> 
> I agree with removal of gitview; I'd rather leave importers, even
> if they haven's seen any activity. If they import correctly, what
> is to work on more?

An alternative for importers would be to move them into contrib area
(I think unmaintained but not obsolete programs can be there in contrib).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
