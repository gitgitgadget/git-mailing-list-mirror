From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git tree for old kernels from before the current tree
Date: Mon, 23 Jul 2007 12:44:57 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707231242090.3607@woody.linux-foundation.org>
References: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com>
 <Pine.LNX.4.64.0707222257540.32367@fbirervta.pbzchgretzou.qr>
 <20070722211314.GA13850@linux-sh.org> <Pine.LNX.4.64.0707222344540.32367@fbirervta.pbzchgretzou.qr>
 <Pine.LNX.4.64.0707230000170.32367@fbirervta.pbzchgretzou.qr>
 <46A3D5EA.2050600@zytor.com> <alpine.LFD.0.999.0707230950340.3607@woody.linux-foundation.org>
 <20070723185732.GB30165@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Jan Engelhardt <jengelh@computergmbh.de>,
	Paul Mundt <lethal@linux-sh.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 23 21:45:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID3qR-00063w-CR
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 21:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933416AbXGWTpY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 15:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765989AbXGWTpX
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 15:45:23 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36956 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765379AbXGWTpV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 15:45:21 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6NJj3Qj019757
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jul 2007 12:45:04 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6NJivoE008420;
	Mon, 23 Jul 2007 12:44:57 -0700
In-Reply-To: <20070723185732.GB30165@thunk.org>
X-Spam-Status: No, hits=-2.722 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.14__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53467>



On Mon, 23 Jul 2007, Theodore Tso wrote:
> 
> Um, *I* never had the bad taste to import Linux kernels into CVS.  :-)

Ahh. I just checked. 

RCS.

There are old linux archive of yours that has some RCS files in it (0.10 
and 0.12 at least)

		Linus
