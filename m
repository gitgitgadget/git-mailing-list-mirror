From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sat, 13 Jan 2007 10:36:16 +0100
Message-ID: <slrneqha0g.5sa.Peter.B.Baumann@xp.machine.xx>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com> <7virfct737.fsf@assigned-by-dhcp.cox.net> <slrneqfnb8.a6s.Peter.B.Baumann@xp.machine.xx> <7vejq0t4ij.fsf@assigned-by-dhcp.cox.net> <B641F998-7DC1-404E-BDB8-7377F8516AB9@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sat Jan 13 10:35:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5fIg-00060v-5i
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 10:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030179AbXAMJfm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 04:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbXAMJfm
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 04:35:42 -0500
Received: from main.gmane.org ([80.91.229.2]:38497 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197AbXAMJfm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 04:35:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H5fIX-0003Uu-5v
	for git@vger.kernel.org; Sat, 13 Jan 2007 10:35:37 +0100
Received: from p54aaa36b.dip0.t-ipconnect.de ([84.170.163.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Jan 2007 10:35:37 +0100
Received: from Peter.B.Baumann by p54aaa36b.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Jan 2007 10:35:37 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p54aaa36b.dip0.t-ipconnect.de
User-Agent: slrn/0.9.8.0 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36743>

On 2007-01-13, Brian Gernhardt <benji@silverinsanity.com> wrote:
>
> On Jan 12, 2007, at 2:43 PM, Junio C Hamano wrote:
>
>> Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
>> writes:
>>
>>> Me doesn't really like the new semantics of "git-add", because it  
>>> does
>>> two seperate things - it adds new files and it refreshes the  
>>> content of
>>> previously known files.
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/32452/ 
>> focus=32792
>
> Should this be added to Documentation/rants/filename- 
> braindamage.txt?  ;-)
>
> ~~ Brian

Ok. Obviously I should't have said that it add "files" (gr, silly me).
What I meant was it adds the content of files. But there is a difference
in adding and replacing content.

-Peter
