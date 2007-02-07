From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Wed, 7 Feb 2007 15:26:01 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702071525270.8424@woody.linux-foundation.org>
References: <17866.20355.744025.133326@lisa.zopyra.com>
 <Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org>
 <7vd54l60gg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 08 00:26:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEwB2-00040U-ML
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 00:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161454AbXBGX0J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 18:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161472AbXBGX0J
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 18:26:09 -0500
Received: from smtp.osdl.org ([65.172.181.24]:45069 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161454AbXBGX0G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 18:26:06 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l17NQ2dD024581
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 7 Feb 2007 15:26:03 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l17NQ1b8031032;
	Wed, 7 Feb 2007 15:26:02 -0800
In-Reply-To: <7vd54l60gg.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.44 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.113__
X-MIMEDefang-Filter: osdl$Revision: 1.175 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38998>



On Wed, 7 Feb 2007, Junio C Hamano wrote:
> >
> > Of course, we should probably just have a
> >
> > 	git reflog show
> >
> > command for this to make it prettier.
> 
> 	$ git log -g?

You think that is *prettier*?

No, I think that if I want a log, I'll just do the "less", thank you very 
much ;)

		Linus
