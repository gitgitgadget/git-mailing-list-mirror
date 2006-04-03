From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Add git-clean command
Date: Mon, 03 Apr 2006 17:59:29 -0400
Message-ID: <20060403215929.24359.54509.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Apr 03 23:59:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQX5D-0007L6-BL
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 23:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWDCV7c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 17:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWDCV7c
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 17:59:32 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:33698 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964775AbWDCV7b
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 17:59:31 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FQX58-0001qS-Fd
	for git@vger.kernel.org; Mon, 03 Apr 2006 17:59:30 -0400
Received: from localhost.roinet.com ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1FQX57-0006L0-Iv
	for git@vger.kernel.org; Mon, 03 Apr 2006 17:59:29 -0400
To: git@vger.kernel.org
User-Agent: StGIT/0.8-git
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18351>

This command removes untracked files from the working tree.  This
implementation is based on cg-clean with some simplifications.  The
documentation is included.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 0 files changed, 0 insertions(+), 0 deletions(-)
