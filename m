From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: filter-branch fix and tests
Date: Mon, 25 Jan 2010 14:06:23 +0100
Message-ID: <1264424786-26231-1-git-send-email-sojkam1@fel.cvut.cz>
Cc: Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 25 14:07:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZOeu-00066U-6g
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 14:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079Ab0AYNGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 08:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900Ab0AYNGo
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 08:06:44 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:58831 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753535Ab0AYNGm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 08:06:42 -0500
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id 3F7CD19F3381;
	Mon, 25 Jan 2010 14:06:41 +0100 (CET)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id tGnUydScit0n; Mon, 25 Jan 2010 14:06:37 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 2673019F3333;
	Mon, 25 Jan 2010 14:06:37 +0100 (CET)
Received: from localhost.localdomain (k335-30.felk.cvut.cz [147.32.86.30])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 0A87315C052;
	Mon, 25 Jan 2010 14:06:36 +0100 (CET)
X-Mailer: git-send-email 1.6.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137961>

Hi,

this is resend of the patch I sent two weeks ago. I've extended the commit
message to address Johannes' question and in the second patch I've added tests
for the fix.

Michal
