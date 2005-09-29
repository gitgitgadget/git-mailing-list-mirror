From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Thu, 29 Sep 2005 23:32:57 +0100 (BST)
Message-ID: <Pine.LNX.4.60.0509292330130.17860@hermes-1.csi.cam.ac.uk>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
 <Pine.LNX.4.60.0509292106080.17860@hermes-1.csi.cam.ac.uk>
 <20050929201127.GB31516@redhat.com> <Pine.LNX.4.64.0509291413060.5362@g5.osdl.org>
 <Pine.LNX.4.64.0509291425560.5362@g5.osdl.org> <20050929213312.GD31516@redhat.com>
 <Pine.LNX.4.64.0509291451540.5362@g5.osdl.org>
 <Pine.LNX.4.60.0509292309470.17860@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.64.0509291521300.5362@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932309AbVI2WdI@vger.kernel.org Fri Sep 30 00:34:43 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932309AbVI2WdI@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL6yJ-00020F-CF
	for glk-linux-kernel-3@gmane.org; Fri, 30 Sep 2005 00:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVI2WdI (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 29 Sep 2005 18:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVI2WdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 18:33:08 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:41386 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932300AbVI2WdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 18:33:05 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:41302)
	by ppsw-1.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.151]:25)
	with esmtpa (EXTERNAL:aia21) id 1EL6xV-0006lH-6L (Exim 4.53)
	(return-path <aia21@hermes.cam.ac.uk>); Thu, 29 Sep 2005 23:32:57 +0100
Received: from aia21 (helo=localhost) by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1EL6xV-0006ND-US (Exim 4.53)
	(return-path <aia21@hermes.cam.ac.uk>); Thu, 29 Sep 2005 23:32:57 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0509291521300.5362@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9523>

On Thu, 29 Sep 2005, Linus Torvalds wrote:
> On Thu, 29 Sep 2005, Anton Altaparmakov wrote:
> > Why don't you enable "enable-alternate-editor-implicitly" and set 
> > editor = "your-editor-of-choice" in the pine config?  It is integrated in 
> > a quite seamless way.
> 
> You think so? I don't find it that way.
> 
> With an alternate editor you have to edit the headers separately, and 
> things like postponing a message suddenly turns into a big deal, not just 
> a trivial ^O. In fact, almost everything gets more involved.

Well using vim as alternate editor a postpone turns into a "ZZ" followed 
by ^O which I don't think is such a big deal but in general I agree that 
it adds hassle.  It is a shame that the text based headers do not appear 
as part of the message in the editor in particular...
 
> And pico _is_ pretty close to uemacs.

I wouldn't know about that.  Never used uemacs.  I am a vim addict myself.  
(-;

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
