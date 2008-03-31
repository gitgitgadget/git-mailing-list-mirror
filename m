From: Asheesh Laroia <asheesh@asheesh.org>
Subject: git submodule remove?
Date: Mon, 31 Mar 2008 11:58:19 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0803311145250.5920@sf.creativecommons.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 31 20:59:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgPDn-0003eU-95
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 20:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699AbYCaS6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 14:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754359AbYCaS6Y
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 14:58:24 -0400
Received: from wide-rose.makesad.us ([203.178.130.147]:57712 "EHLO
	rose.makesad.us" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754126AbYCaS6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 14:58:24 -0400
Received: from sf.creativecommons.org (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id 9657CA0096
	for <git@vger.kernel.org>; Mon, 31 Mar 2008 14:58:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by sf.creativecommons.org (Postfix) with ESMTPS id 11454144C435
	for <git@vger.kernel.org>; Mon, 31 Mar 2008 11:58:20 -0700 (PDT)
X-X-Sender: paulproteus@sf.creativecommons.org
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78599>

I notice that in git-submodule, there is an "add", a "status", an 
"init", and an "update" command, but no "remove" command.

I have "git version 1.5.4.4", and man git-submodule provides no mention of 
the right way to remove a submodule.  I imagine that removing it from 
.gitmodules and rm -rf'ing the tree that git-submodule cloned should do 
the trick. Is this documented somewhere?

-- Asheesh.

-- 
Editing is a rewording activity.
