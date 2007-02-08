From: Bill Lear <rael@zopyra.com>
Subject: Re: Git rescue mission
Date: Thu, 8 Feb 2007 16:33:12 -0600
Message-ID: <17867.42280.577214.422651@lisa.zopyra.com>
References: <17866.27739.701406.722074@lisa.zopyra.com>
	<Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org>
	<17867.40122.51865.575762@lisa.zopyra.com>
	<Pine.LNX.4.64.0702081408140.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 23:33:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFHpY-0006k4-0x
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 23:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423495AbXBHWdY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 17:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423497AbXBHWdY
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 17:33:24 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61726 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423495AbXBHWdY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 17:33:24 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l18MXFl30025;
	Thu, 8 Feb 2007 16:33:15 -0600
In-Reply-To: <Pine.LNX.4.64.0702081408140.8424@woody.linux-foundation.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39110>

On Thursday, February 8, 2007 at 14:13:47 (-0800) Linus Torvalds writes:
>On Thu, 8 Feb 2007, Bill Lear wrote:
>> 
>> However, I still have a few open issues with the other branch of this
>> discussion, i.e., why can we not have an update operation that
>> respects branches in the first place, as 'git pull' seems to do, when
>> run from the master branch?
>
>Actually, git does that all correctly for other branches too, but only in 
>git-1.5.
>
>...
>So it might be worth while trying out git-1.5.0-rc4, and seeing if that 
>solves some of the UI issues for you guys. It changes things like where 
>the default remote branches are, and makes the distinction between "my 
>local copy of branch X" and "the remote branch X" much clearer, which has 
>clearly been a UI problem.

Ok, very reasonable.  I've been our corporate guinea pig, so I'll give
this a whirl.  One thing I'm very, very happy about in git is the
ability to quickly experiment.  Believe it or not, I have solved
actual git problems in our company by doing just that.  Of necessity,
it's largely my complaints and problems that are aired here, though.


Bill
