From: TamerTas <tamertas@outlook.com>
Subject: [GSOC2014] History Repair Tools
Date: Sun, 16 Mar 2014 21:09:32 +0200
Message-ID: <BLU0-SMTP2148A95FC508A984BDD3C50D5720@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain
Cc: peff@peff.net, mhagger@alum.mit.edu,
	TamerTas <tamertas@outlook.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 20:09:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPGRY-0004Bp-1x
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 20:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634AbaCPTJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 15:09:42 -0400
Received: from blu0-omc3-s4.blu0.hotmail.com ([65.55.116.79]:16119 "EHLO
	blu0-omc3-s4.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752813AbaCPTJl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Mar 2014 15:09:41 -0400
Received: from BLU0-SMTP214 ([65.55.116.74]) by blu0-omc3-s4.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Sun, 16 Mar 2014 12:09:40 -0700
X-TMN: [6+KGyjd5FyOISSpaEpWOz8eDJnHxrX/a]
X-Originating-Email: [tamertas@outlook.com]
Received: from localhost.localdomain ([24.133.189.163]) by BLU0-SMTP214.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Sun, 16 Mar 2014 12:09:39 -0700
X-Mailer: git-send-email 1.7.9.5
X-OriginalArrivalTime: 16 Mar 2014 19:09:39.0659 (UTC) FILETIME=[4798E9B0:01CF414B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244206>

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
