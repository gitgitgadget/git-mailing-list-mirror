From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: Challenge of setting up git server (repository). Please help!
Date: Thu, 20 Nov 2008 14:04:04 -0800 (PST)
Message-ID: <alpine.DEB.2.00.0811201400200.30495@vellum.laroia.net>
References: <829533.97868.qm@web37906.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Gary Yang <garyyang6@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 23:25:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3Hxq-0004RP-3E
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 23:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbYKTWYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 17:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbYKTWYL
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 17:24:11 -0500
Received: from rose.makesad.us ([219.105.37.19]:43563 "EHLO rose.makesad.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271AbYKTWYK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 17:24:10 -0500
X-Greylist: delayed 1200 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Nov 2008 17:24:10 EST
Received: from vellum.laroia.net (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id CACB0A012E;
	Thu, 20 Nov 2008 17:07:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by vellum.laroia.net (Postfix) with ESMTPS id A10493A6391;
	Thu, 20 Nov 2008 14:04:04 -0800 (PST)
X-X-Sender: paulproteus@vellum.laroia.net
In-Reply-To: <829533.97868.qm@web37906.mail.mud.yahoo.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101475>

On Thu, 20 Nov 2008, Gary Yang wrote:

> I am working on setting up a git server so that people can clone, pull 
> and push their code at git.mycompany.com/pub/git+project path. However, 
> I am having challenges. For people who setup their git servers, please 
> share your experneces with me and tell me what I did wrong. I greatly 
> appreciate it.

Have you tried just using gitosis?  It's very nice.

http://scie.nti.st/2007/11/14/hosting-git-repositories-the-easy-and-secure-way 
is what I read to get started.

Keep in mind you can't clone a git repository with no commits.

-- Asheesh.

-- 
You look tired.
