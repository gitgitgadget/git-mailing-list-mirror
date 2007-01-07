From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Date: Sat, 6 Jan 2007 20:29:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701062029170.3661@woody.osdl.org>
References: <20061214223718.GA3816@elf.ucw.cz>  <20061216094421.416a271e.randy.dunlap@oracle.com>
  <20061216095702.3e6f1d1f.akpm@osdl.org>  <458434B0.4090506@oracle.com> 
 <1166297434.26330.34.camel@localhost.localdomain>  <1166304080.13548.8.camel@nigel.suspend2.net>
  <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net>
 <45A07587.3080503@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: nigel@nigel.suspend2.net, "H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
	"J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 07 05:30:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3Pfr-0003uB-Eo
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 05:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbXAGEaT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 23:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbXAGEaT
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 23:30:19 -0500
Received: from smtp.osdl.org ([65.172.181.24]:58673 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932387AbXAGEaR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 23:30:17 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l074TRWi027089
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 6 Jan 2007 20:29:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l074TQH9010098;
	Sat, 6 Jan 2007 20:29:26 -0800
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <45A07587.3080503@garzik.org>
X-Spam-Status: No, hits=-1.169 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36125>



On Sat, 6 Jan 2007, Jeff Garzik wrote:
> 
> Also, I wonder if "git push" will push only the non-linux-2.6.git objects, if
> both local and remote sides have the proper alternatives set up?

Yes.

		Linus
