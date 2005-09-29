From: Junio C Hamano <junkio@cox.net>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Thu, 29 Sep 2005 16:19:23 -0700
Message-ID: <7vek77ea2s.fsf@assigned-by-dhcp.cox.net>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
	<Pine.LNX.4.60.0509292106080.17860@hermes-1.csi.cam.ac.uk>
	<20050929201127.GB31516@redhat.com>
	<Pine.LNX.4.64.0509291413060.5362@g5.osdl.org>
	<Pine.LNX.4.64.0509291425560.5362@g5.osdl.org>
	<20050929213312.GD31516@redhat.com>
	<Pine.LNX.4.64.0509291451540.5362@g5.osdl.org>
	<Pine.LNX.4.60.0509292309470.17860@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 01:22:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL7gn-0003CT-JK
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 01:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbVI2XT0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 19:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVI2XT0
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 19:19:26 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:41615 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751274AbVI2XTY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 19:19:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050929231921.IKLL4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Sep 2005 19:19:21 -0400
To: Anton Altaparmakov <aia21@cam.ac.uk>
In-Reply-To: <Pine.LNX.4.60.0509292309470.17860@hermes-1.csi.cam.ac.uk> (Anton
	Altaparmakov's message of "Thu, 29 Sep 2005 23:12:37 +0100 (BST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9524>

Anton Altaparmakov <aia21@cam.ac.uk> writes:

> On Thu, 29 Sep 2005, Linus Torvalds wrote:
>> On Thu, 29 Sep 2005, Dave Jones wrote:
>> > What I find amusing is that it was a patch rejection mail from you
>> > *years* back (circa 2000 iirc), telling me my pine corrupted whitespace,
>> > that made me switch MUA ;-)
>> > 
>> > All these years later, and it's still buggered ?
>> 
>> Actually, it seems better. It seems to be buggered by default, but it used 
>> to be that you had to actually recompile pine to make it behave. Now you 
>> can just disable "strip-whitespace-before-send" and _enable_ 
>> "quell-flowed-text" and those together seem to do the trick. No extra 
>> patches or recompiles necessary.
>
> Indeed.  I use those two options like that, too.  (-:

Anybody interested in adding entry to SubmittingPatches MUA
Specific Help section?
