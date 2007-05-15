From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: newby question about merge.
Date: Tue, 15 May 2007 12:25:13 +0200
Message-ID: <20070515102513.GB2893@steel.home>
References: <20070515113820.2621c8d5@localhost.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: picca <picca@synchrotron-soleil.Fr>
X-From: git-owner@vger.kernel.org Tue May 15 12:25:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnuDb-0005Uc-5c
	for gcvg-git@gmane.org; Tue, 15 May 2007 12:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756134AbXEOKZS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 06:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757065AbXEOKZS
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 06:25:18 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:55603 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756134AbXEOKZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 06:25:16 -0400
Received: from tigra.home (Fcb17.f.strato-dslnet.de [195.4.203.23])
	by post.webmailer.de (mrclete mo53) (RZmta 6.3)
	with ESMTP id E06b4ej4FAJbYX ; Tue, 15 May 2007 12:25:13 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BA158277BD;
	Tue, 15 May 2007 12:25:13 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 228A4D171; Tue, 15 May 2007 12:25:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070515113820.2621c8d5@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg8DQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47335>

picca, Tue, May 15, 2007 11:38:20 +0200:
> So I do a merge like this
> "git merge upstream ." when I am on the master branch to work on the new
> package.

loose the dot. git-merge syntax is "git merge branch1 [branch2...]"
