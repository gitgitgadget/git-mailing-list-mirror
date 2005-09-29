From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Thu, 29 Sep 2005 15:25:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0509291521300.5362@g5.osdl.org>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
 <Pine.LNX.4.60.0509292106080.17860@hermes-1.csi.cam.ac.uk>
 <20050929201127.GB31516@redhat.com> <Pine.LNX.4.64.0509291413060.5362@g5.osdl.org>
 <Pine.LNX.4.64.0509291425560.5362@g5.osdl.org> <20050929213312.GD31516@redhat.com>
 <Pine.LNX.4.64.0509291451540.5362@g5.osdl.org>
 <Pine.LNX.4.60.0509292309470.17860@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 30 00:30:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL6tu-00014r-0F
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 00:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbVI2W3E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 18:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVI2W3E
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 18:29:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:898 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750776AbVI2W3C (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2005 18:29:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8TMPa4s031857
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Sep 2005 15:25:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8TMPY0B008458;
	Thu, 29 Sep 2005 15:25:35 -0700
To: Anton Altaparmakov <aia21@cam.ac.uk>
In-Reply-To: <Pine.LNX.4.60.0509292309470.17860@hermes-1.csi.cam.ac.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9522>



On Thu, 29 Sep 2005, Anton Altaparmakov wrote:
> 
> Why don't you enable "enable-alternate-editor-implicitly" and set 
> editor = "your-editor-of-choice" in the pine config?  It is integrated in 
> a quite seamless way.

You think so? I don't find it that way.

With an alternate editor you have to edit the headers separately, and 
things like postponing a message suddenly turns into a big deal, not just 
a trivial ^O. In fact, almost everything gets more involved.

And pico _is_ pretty close to uemacs.

		Linus
