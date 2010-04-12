From: cdossantos <claudia.dossantos@ricoh-europe.com>
Subject: replication of shared repositories
Date: Mon, 12 Apr 2010 06:14:28 -0700 (PDT)
Message-ID: <28217574.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 12 15:14:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1JTX-00024e-MY
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 15:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354Ab0DLNOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 09:14:41 -0400
Received: from kuber.nabble.com ([216.139.236.158]:33588 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab0DLNO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 09:14:29 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1O1JTA-0002w4-TO
	for git@vger.kernel.org; Mon, 12 Apr 2010 06:14:28 -0700
X-Nabble-From: claudia.dossantos@ricoh-europe.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144727>


Hi all,

I would like to replicate the contents of my GIT shared repository, a sort
of mirror, but i don't find any references about that. I know that hook
scripts run locally. However, could i have a post commit script that after a
local commit, not only starts a push to the shared repository but as well
starts a push from the shared repository to another server ?

Thanks in advance,

Santos
-- 
View this message in context: http://old.nabble.com/replication-of-shared-repositories-tp28217574p28217574.html
Sent from the git mailing list archive at Nabble.com.
