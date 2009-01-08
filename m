From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Maintaining site-wide clones
Date: Thu, 8 Jan 2009 11:47:50 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901081129500.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 17:49:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKy4K-0005tJ-6m
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 17:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbZAHQrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 11:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbZAHQrw
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 11:47:52 -0500
Received: from iabervon.org ([66.92.72.58]:45603 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752003AbZAHQrv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 11:47:51 -0500
Received: (qmail 13467 invoked by uid 1000); 8 Jan 2009 16:47:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Jan 2009 16:47:50 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104933>

Is there a good way of handling a setup where the canonical repository is 
in some slow foreign system and you want a lot of git clones? I've been 
using a bare repository that I import into and clone, but then I need to 
go to the bare repository to update anything, which is vaguely annoying.

I remember people having my use case a while ago, and I was wondering if 
people have come up with improvements since.

	-Daniel
*This .sig left intentionally blank*
