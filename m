From: TamerTas <tamertas@outlook.com>
Subject: [GSOC2014] Invent a New Conflict Style
Date: Sat, 15 Mar 2014 23:27:11 +0200
Message-ID: <BLU0-SMTP17018320D43D99BF7CCD053D5730@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain
Cc: TamerTas <tamertas@outlook.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 22:27:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOw7O-00061b-Th
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 22:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756566AbaCOV13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 17:27:29 -0400
Received: from blu0-omc3-s29.blu0.hotmail.com ([65.55.116.104]:4543 "EHLO
	blu0-omc3-s29.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756552AbaCOV10 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Mar 2014 17:27:26 -0400
Received: from BLU0-SMTP170 ([65.55.116.73]) by blu0-omc3-s29.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Sat, 15 Mar 2014 14:27:26 -0700
X-TMN: [2zL/VKnUA14iV2NbXUXgA2rytd8pxD7y]
X-Originating-Email: [tamertas@outlook.com]
Received: from localhost.localdomain ([24.133.189.163]) by BLU0-SMTP170.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Sat, 15 Mar 2014 14:27:24 -0700
X-Mailer: git-send-email 1.7.9.5
X-OriginalArrivalTime: 15 Mar 2014 21:27:24.0300 (UTC) FILETIME=[5B4B4CC0:01CF4095]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244166>

Hello everyone,

I'm Tamer Tas. I am studying computer engineering in Turkey.
I'm about to complete my junior year in Middle East Technical University.

After setting up my git development environment,
I've submitted patches to a microproject [1][2][3]. I'm still getting feedbacks on
the microproject. Feedback cycle has been very informative. 

I am interested in developing history repair tools for git. For the past days 
I've been learning about how git manages history, inspecting git fsck, replace, hash-object.
Also I've learned how git filter-branch is used to rewrite history and the drawbacks of this approach.
I've submitted the first draft of my proposal and I would love to get a feedback from
Jeff King or Michael Haggarty (Mentors of the project) or the community so I can improve my proposal.

If you have any questions please feel free to ask. 
Thanks in advance.

Tamer Tas

[1]http://git.661346.n2.nabble.com/PATCH-GSOC2014-changed-logical-chain-in-branch-c-to-lookup-tables-tt7605343.html
[2]http://git.661346.n2.nabble.com/PATCH-GSOC2014-install-branch-config-change-logical-chain-to-lookup-table-tt7605550.html
[3]http://git.661346.n2.nabble.com/PATCH-GSOC2014-install-branch-config-change-logical-chain-to-lookup-table-tt7605550.html#a7605663
