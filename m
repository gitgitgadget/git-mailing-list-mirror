From: cdossantos <claudia.dossantos@ricoh-europe.com>
Subject: Replication of shared repositories
Date: Mon, 12 Apr 2010 23:45:20 -0800 (PST)
Message-ID: <1271144720027-4894649.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 13 09:45:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1aoJ-0006Io-23
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 09:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336Ab0DMHpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 03:45:21 -0400
Received: from kuber.nabble.com ([216.139.236.158]:37944 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab0DMHpU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 03:45:20 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <claudia.dossantos@ricoh-europe.com>)
	id 1O1aoC-0003JS-15
	for git@vger.kernel.org; Tue, 13 Apr 2010 00:45:20 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144794>


Hello,


I would like to replicate the contents of my GIT shared repository to
another server, a sort of mirror, but i didn't find any references about
that. I know that hook scripts run locally. However, could i have a post
commit script that after a local commit, not only starts a push to the
shared repository but starts as well a push from the shared repository to
another server ? 

Thanks in advance, 

Santos 
-- 
View this message in context: http://n2.nabble.com/Replication-of-shared-repositories-tp4894649p4894649.html
Sent from the git mailing list archive at Nabble.com.
