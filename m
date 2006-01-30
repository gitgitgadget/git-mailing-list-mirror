From: Mike McCormack <mike@codeweavers.com>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 00:23:43 +0900
Organization: CodeWeavers
Message-ID: <43DE2F7F.7090006@codeweavers.com>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org> <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com> <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net> <20060129183731.GE19685@redhat.com> <Pine.LNX.4.64.0601291438251.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dave Jones <davej@redhat.com>, Junio C Hamano <junkio@cox.net>,
	Keith Packard <keithp@keithp.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 30 16:28:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3ax3-0003Bq-T6
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 16:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWA3P2T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 10:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWA3P2T
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 10:28:19 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:60336 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S932321AbWA3P2S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 10:28:18 -0500
Received: from foghorn.codeweavers.com ([216.251.189.130] helo=[127.0.0.1])
	by mail.codeweavers.com with esmtp (Exim 4.50)
	id 1F3awV-00040L-4Y; Mon, 30 Jan 2006 09:27:54 -0600
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923
X-Accept-Language: en, en-us
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0601291438251.25300@iabervon.org>
X-SA-Exim-Connect-IP: 216.251.189.130
X-SA-Exim-Mail-From: mike@codeweavers.com
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15276>


Daniel Barkalow wrote:
> I think we'll see a lot more adoption when we have a CVS daemon interface 
> (so projects can stop having a CVS repository, and support both sorts of 
> users with a git repository and have better metadata), and also if someone 
> sets up a place for putting git imports of CVS projects, so people will 
> know that other people are using git.

The Wine project is using a GIT repository which is mirrored into CVS. 
Alexandre wrote scripts to mirror GIT commits into CVS, so developers 
can use whichever they're more comfortable with, and the CVS repository 
remains up to date.

We've found that patch submitters using GIT tend to send multiple 
patches per day, and that those using CVS tend to send a patch or two 
occasionally or just keep up to date with the source.

Mike
