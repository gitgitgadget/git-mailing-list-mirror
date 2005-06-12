From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: git-whatchanged doesn't display date human understandable
Date: Sun, 12 Jun 2005 11:34:13 +0200
Message-ID: <20050612093413.GR20432@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jun 12 11:32:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhOoy-0004T0-Uv
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 11:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVFLJfR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Jun 2005 05:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVFLJe2
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jun 2005 05:34:28 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:4533 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261932AbVFLJeS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2005 05:34:18 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j5C9YDS8025458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 12 Jun 2005 09:34:13 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j5C9YD8Q025457
	for git@vger.kernel.org; Sun, 12 Jun 2005 11:34:13 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
what option to I have to tweak to get timestamps human understandable
again:

git-whatchanged | head -5
diff-tree 422dee18f8b39b4c14332afbdf75a5c519bdbed2 (from 16df05aa0464e5e17d4ef023b78bc7b98546cb9a)
tree 2ed70720e7103ae700a9dceac55c77d562057467
parent 16df05aa0464e5e17d4ef023b78bc7b98546cb9a
author vrsieh <vrsieh> 1082362048 +0000
committer vrsieh <vrsieh> 1082362048 +0000
                          ~~~~~~~~~~~~~~~~

This seems to happen with Linus git tree HEAD.

	Thomas
