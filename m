From: Tim Mazid <timmazid@hotmail.com>
Subject: Headless tags don't have a follows or precedes?
Date: Sun, 1 Nov 2009 01:31:38 -0800 (PST)
Message-ID: <1257067898626-3926483.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 10:32:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4Wmn-0001uV-1A
	for gcvg-git-2@lo.gmane.org; Sun, 01 Nov 2009 10:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbZKAJbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 04:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751843AbZKAJbe
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 04:31:34 -0500
Received: from kuber.nabble.com ([216.139.236.158]:55998 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbZKAJbd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 04:31:33 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1N4Wmg-00049t-KK
	for git@vger.kernel.org; Sun, 01 Nov 2009 01:31:38 -0800
X-Nabble-From: Tim Mazid <timmazid@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131868>


Hi all,

I've noticed that if I create a headless tag (one that doesn't have a
branch, right?), when I click on that commit, it doesn't have precedes or
follows information. Is this by design? Is there a work-around I can use
without creating a branch there?

Thanks,
Tim.
-- 
View this message in context: http://n2.nabble.com/Headless-tags-don-t-have-a-follows-or-precedes-tp3926483p3926483.html
Sent from the git mailing list archive at Nabble.com.
