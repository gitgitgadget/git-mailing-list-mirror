From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Thu, 29 Sep 2005 23:12:37 +0100 (BST)
Message-ID: <Pine.LNX.4.60.0509292309470.17860@hermes-1.csi.cam.ac.uk>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
 <Pine.LNX.4.60.0509292106080.17860@hermes-1.csi.cam.ac.uk>
 <20050929201127.GB31516@redhat.com> <Pine.LNX.4.64.0509291413060.5362@g5.osdl.org>
 <Pine.LNX.4.64.0509291425560.5362@g5.osdl.org> <20050929213312.GD31516@redhat.com>
 <Pine.LNX.4.64.0509291451540.5362@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 30 00:13:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL6e6-0005Ui-MJ
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 00:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbVI2WMt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 18:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbVI2WMt
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 18:12:49 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:26525 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751330AbVI2WMs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 18:12:48 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:39607)
	by ppsw-1.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.151]:25)
	with esmtpa (EXTERNAL:aia21) id 1EL6dp-00031s-3Q (Exim 4.53)
	(return-path <aia21@hermes.cam.ac.uk>); Thu, 29 Sep 2005 23:12:37 +0100
Received: from aia21 (helo=localhost) by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1EL6dp-0004Fr-1C (Exim 4.53)
	(return-path <aia21@hermes.cam.ac.uk>); Thu, 29 Sep 2005 23:12:37 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0509291451540.5362@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9520>

On Thu, 29 Sep 2005, Linus Torvalds wrote:
> On Thu, 29 Sep 2005, Dave Jones wrote:
> > What I find amusing is that it was a patch rejection mail from you
> > *years* back (circa 2000 iirc), telling me my pine corrupted whitespace,
> > that made me switch MUA ;-)
> > 
> > All these years later, and it's still buggered ?
> 
> Actually, it seems better. It seems to be buggered by default, but it used 
> to be that you had to actually recompile pine to make it behave. Now you 
> can just disable "strip-whitespace-before-send" and _enable_ 
> "quell-flowed-text" and those together seem to do the trick. No extra 
> patches or recompiles necessary.

Indeed.  I use those two options like that, too.  (-:

> So there's progress. 
> 
> Of course, pico is still pico. Which I find a bit sad: my editor of choise 
> is still an improved version of uemacs, and pico actually comes from the 
> same uemacs history, but has different key-bindings for just enough keys 
> to be slightly confusing.
> 
> Still, that shared history means that I find pico a lot more to my taste 
> than just about any other emailer editor out there. It may have a few 
> differences, but it has more things in common..

Why don't you enable "enable-alternate-editor-implicitly" and set 
editor = "your-editor-of-choice" in the pine config?  It is integrated in 
a quite seamless way.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
