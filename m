From: John Ellson <ellson@research.att.com>
Subject: Re: Wanted - a file browser interface to git
Date: Tue, 18 Oct 2005 21:23:23 -0400
Message-ID: <4355A00B.4000806@research.att.com>
References: <dj45np$e88$1@sea.gmane.org> <Pine.LNX.4.64.0510181806250.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 03:23:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES2gF-0006Ul-GC
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 03:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVJSBXa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 21:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbVJSBXa
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 21:23:30 -0400
Received: from mail-dark.research.att.com ([192.20.225.112]:63875 "EHLO
	mail-yellow.research.att.com") by vger.kernel.org with ESMTP
	id S932430AbVJSBX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 21:23:29 -0400
Received: from [135.207.24.103] (ellson.research.att.com [135.207.24.103])
	by bigmail.research.att.com (8.13.3+Sun/8.11.6) with ESMTP id j9J1Q5MT005693;
	Tue, 18 Oct 2005 21:26:07 -0400 (EDT)
User-Agent: Mail/News 1.4.1 (X11/20051008)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510181806250.3369@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10256>

Linus Torvalds wrote:
> On Tue, 18 Oct 2005, John Ellson wrote:
>   
>> An example is:  "I know that file xxx contained algorithm yyy at some point in
>> the past and now I'd like to browse back through the history of xxx to find
>> the exact details."
>>     
>
> You are aware of "git whatchanged -p xxx", right?
>
> Yeah, it's not graphical, and I agree that it might be very cool to have a 
> graphical version of it. But I thought I'd mention it even so. A 
> surprising number of people seem to have never realized, and at least for 
> me personally, it's one of the most common things I do.
>
> 		Linus
>   
Linus,

I wasn't aware of it, no.  Looks very useful.  Thanks.

I see that you can take the tree id from the diff-tree lines and
then produce the state of the file at that time with "cg-admin-cat -r 
<id> xxx"
Is that how you would do it?

Are there any plans for cogito to support it?

John
