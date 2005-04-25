From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: keyword expansion
Date: Mon, 25 Apr 2005 02:23:43 +0200
Message-ID: <20050425002343.GF10806@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Apr 25 02:18:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPrJN-0007W2-VT
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 02:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVDYAXt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 20:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVDYAXt
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 20:23:49 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:62679 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262378AbVDYAXs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 20:23:48 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j3P0NjS8022490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 25 Apr 2005 00:23:46 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j3P0Ni38022489
	for git@vger.kernel.org; Mon, 25 Apr 2005 02:23:44 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
I am aware that keyword expansion is at the moment at the very bottom of
the todo list. However I need it. Has someone something ready to use? I
am looking for the following informations:

	- Time stamp of the last modification of a file
	- last Committer/Author of the file

What I want is a script which runs after an export that checks for
keywords in files and expands them using informations extracted out of
the tree.  I would be gratefull for any pointers/shell snippsets.

I just migrated my mutt vendor tracking tree to git and it works quiet
well. Thanks for all the effort!

Greetings,
	Thomas
