From: Zack Brown <zbrown@tumblerings.org>
Subject: seek request
Date: Sun, 22 May 2005 00:11:06 -0700
Message-ID: <20050522071106.GA8060@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 22 09:10:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZkb3-0001gh-0W
	for gcvg-git@gmane.org; Sun, 22 May 2005 09:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVEVHLN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 03:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVEVHLN
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 03:11:13 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:26838 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S261755AbVEVHLK
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 03:11:10 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DZkc6-0002Jg-Or
	for git@vger.kernel.org; Sun, 22 May 2005 00:11:06 -0700
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi folks,

In Cogito, it would be nice to have a

cg-seek +

that would seek to the next archive state. This way, I could start off seeking
back to the beginning of an archive, and quickly step forward, looking at files
as I went, to the present.

A corresponding
cg-seek -
would go the reverse direction, back toward the beginning of a project.

I'm not sure how useful this would be for actual source code - I suspect any
benefit would be minimal - but the benefit for documentation and text files,
where the only way to test improvements is to read them by eye, would be
significant.

Be well,
Zack

-- 
Zack Brown
