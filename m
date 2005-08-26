From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] gitweb - XMMS2 project customisations
Date: Fri, 26 Aug 2005 13:32:05 +0200
Message-ID: <20050826113205.GI14875MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <430EF9F5.70003@xmms.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 13:25:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8cJD-0003Lt-Iu
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 13:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVHZLXl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 07:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbVHZLXl
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 07:23:41 -0400
Received: from nibbel.kulnet.kuleuven.ac.be ([134.58.240.41]:56197 "EHLO
	nibbel.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S964835AbVHZLXk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 07:23:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by nibbel.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 3213D4C062
	for <git@vger.kernel.org>; Fri, 26 Aug 2005 13:23:39 +0200 (CEST)
Received: from smtp03.kuleuven.be (antonius.kulnet.kuleuven.ac.be [134.58.240.73])
	by nibbel.kulnet.kuleuven.ac.be (Postfix) with ESMTP id A2DB34C00A
	for <git@vger.kernel.org>; Fri, 26 Aug 2005 13:23:37 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by smtp03.kuleuven.be (Postfix) with ESMTP id 94754332742
	for <git@vger.kernel.org>; Fri, 26 Aug 2005 13:23:37 +0200 (CEST)
Received: (qmail 2919 invoked by uid 500); 26 Aug 2005 11:32:05 -0000
To: Sham Chukoury <eleusis@xmms.org>
Mail-Followup-To: Sham Chukoury <eleusis@xmms.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <430EF9F5.70003@xmms.org>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7810>

On Fri, Aug 26, 2005 at 07:16:05PM +0800, Sham Chukoury wrote:
> G'day.
> 
> I figured you folks might be interested in a number of modifications the 
> XMMS2 team have made to gitweb. All the changes can be seen at 
> http://git.xmms.se
> 
> 1) Navbar refactoring (gitweb-xmms2navbar.diff)
> 3) Snapshot integration (gitweb-xmms2snapshots.diff & snapshot.cgi)

I've sent similar patches to the git mailing list almost two
months ago, but Kay didn't take them.
Maybe you could compare with my version

http://www.liacs.nl/~sverdool/gitweb.cgi?p=gitweb.git;a=summary

(I'll be mostly offline for the next couple of days.)

skimo
