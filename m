From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Fix path-limited "rev-list --bisect" termination condition.
Date: Fri, 23 Mar 2007 15:25:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703231524520.6730@woody.linux-foundation.org>
References: <7vtzwboc6v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 23:25:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUsCU-0004wQ-UG
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 23:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992592AbXCWWZO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 18:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992593AbXCWWZO
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 18:25:14 -0400
Received: from smtp.osdl.org ([65.172.181.24]:42077 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992592AbXCWWZM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 18:25:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2NMP91o002268
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 23 Mar 2007 15:25:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2NMP8OV026028;
	Fri, 23 Mar 2007 15:25:09 -0700
In-Reply-To: <7vtzwboc6v.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.468 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42967>



On Fri, 23 Mar 2007, Junio C Hamano wrote:
> 
> How many lines did I spend to describe this one-liner?

Heh. Looks good to me.

		Linus
