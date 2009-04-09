From: layer <layer@known.net>
Subject: git diff after merge (with conflict)
Date: Thu, 09 Apr 2009 10:27:43 -0700
Message-ID: <324.1239298063@relay.known.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 09 19:29:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lry40-0001xU-OS
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 19:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757591AbZDIR1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 13:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757295AbZDIR1o
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 13:27:44 -0400
Received: from relay.known.net ([67.121.255.169]:36189 "HELO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757210AbZDIR1o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 13:27:44 -0400
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.17) id 000000034483; Thu, 9 Apr 2009 10:27:43 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116185>

Is there some way to get regular unified diff behavior instead of the
combined diff?  For certain files (like ChangeLog's) the combined diff
format after a merge is *very* confusing.

Thanks.

Kevin
