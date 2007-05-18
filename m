From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: merge summaries
Date: Fri, 18 May 2007 16:12:26 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705181611520.3890@woody.linux-foundation.org>
References: <25A3C618-8D12-42A8-9478-D3A4E7633CE7@zib.de>
 <alpine.LFD.0.98.0705181130580.3890@woody.linux-foundation.org>
 <7vodki55px.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0705181206051.3890@woody.linux-foundation.org>
 <20070518215603.GS15393@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sat May 19 01:15:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpBfE-0003ZV-LT
	for gcvg-git@gmane.org; Sat, 19 May 2007 01:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888AbXERXPH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 19:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755911AbXERXPH
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 19:15:07 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37842 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755888AbXERXPG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2007 19:15:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4INCXQw015878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 18 May 2007 16:13:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4INCRap025559;
	Fri, 18 May 2007 16:12:27 -0700
In-Reply-To: <20070518215603.GS15393@fieldses.org>
X-Spam-Status: No, hits=-2.812 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.180 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47681>



On Fri, 18 May 2007, J. Bruce Fields wrote:
> 
> I never quite understood what they're for--do they add any information
> not already available in the history?  If not, and if people still find
> them helpful anyway, then I dunno, it looks like a sign of some sort of
> failure of our history display tools.

I don't think they add much in the case of a graphical viewer, but for 
"git log", it does make it look nicer..

		Linus
