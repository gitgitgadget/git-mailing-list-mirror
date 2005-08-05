From: Jay Denebeim <denebeim@deepthot.org>
Subject: Re: [ANNOUNCE] Cogito-0.13
Date: Fri, 5 Aug 2005 10:28:12 -0700 (MST)
Message-ID: <Pine.LNX.4.63.0508051026010.7809@hotblack.deepthot.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Fri Aug 05 19:32:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E162v-0004FE-AB
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 19:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVHERa7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Aug 2005 13:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbVHER2d
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 13:28:33 -0400
Received: from deepthot.org ([68.14.232.127]:14999 "EHLO dent.deepthot.org")
	by vger.kernel.org with ESMTP id S261774AbVHER2Q (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2005 13:28:16 -0400
Received: from hotblack.deepthot.org ([192.168.12.6])
	by dent.deepthot.org with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.43)
	id 1E15zQ-0007z7-HY
	for git@vger.kernel.org; Fri, 05 Aug 2005 10:28:12 -0700
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Um, guys...

If you want to have a dependency on git-core >= 0.99.3 you need to 
actually like, you know, put it on-line as well.  Just did a yum update, 
fails with:

error: Failed dependencies:
         git-core >= 0.99.3 is needed by cogito-0.13-1

But on the git repository the git-core == 0.99.1

might wanna fix that.  (and man is google fast)

Jay

-- 
* Jay Denebeim  Moderator       rec.arts.sf.tv.babylon5.moderated *
* newsgroup submission address: b5mod@deepthot.org                *
* moderator contact address:    b5mod-request@deepthot.org        *
* personal contact address:     denebeim@deepthot.org             *
