From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Prepend the history of one git tree to another
Date: Mon, 20 Feb 2006 10:09:09 +0100
Message-ID: <20060220090909.GT6558@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Feb 20 10:09:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FB72h-0003QX-TB
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 10:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWBTJJM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 04:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWBTJJM
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 04:09:12 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:25256 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S932402AbWBTJJK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 04:09:10 -0500
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 1EDAB305C5; Mon, 20 Feb 2006 10:09:09 +0100 (CET)
To: GIT <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16472>

Hello,
I have two trees: blastwave and blastwave.old. blastwave.old is the
BitKeeper -> CVS -> GIT Tree of the project and blastwave is the newer
one that I started when I stoped using bitkeeper. What I want is to 
append the history of blastwave to blastwave.old. The problem is that I
need to create new commit objects for every commit I want to append to
the old history. Is there a script which does that for me? Or do I have
to write this script myself?

        Thomas
