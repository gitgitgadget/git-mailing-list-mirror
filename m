From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Never mind (Re: [KORG] gitweb down?)
Date: Sun, 22 Jul 2007 13:21:04 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707221320130.3607@woody.linux-foundation.org>
References: <20070722174915.GI26471@cip.informatik.uni-erlangen.de>
 <46A39CEA.7020703@zytor.com>
 <alpine.LFD.0.999.0707221316050.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: webmaster@kernel.org, Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 22:21:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IChve-0000ei-9l
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 22:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762810AbXGVUVT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 16:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762780AbXGVUVS
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 16:21:18 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50695 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762745AbXGVUVR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 16:21:17 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6MKLAkp022347
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Jul 2007 13:21:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6MKL4ID021492;
	Sun, 22 Jul 2007 13:21:04 -0700
In-Reply-To: <alpine.LFD.0.999.0707221316050.3607@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.725 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53312>



On Sun, 22 Jul 2007, Linus Torvalds wrote:
> 
> The main git.kernel.org page loads about half-way (without any stated 
> errors, but it's definitely broken and not complete), but the summary 
> pages don't seem to load at all (some projects do, but git and kernel 
> don't - it looks like the *cache* may still be working, but anything new 
> gets a "500 Internal Server Error").

Ok, retried immediately after sending the email, and it's ok now. So never 
mind - I probably tested just when some update was in progress..

		Linus
