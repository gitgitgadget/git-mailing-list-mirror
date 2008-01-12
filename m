From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 0/5] submodule summary support
Date: Sat, 12 Jan 2008 15:37:10 +0800
Message-ID: <1200123435-16722-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 08:53:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDbBE-00043k-M4
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 08:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758929AbYALHws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 02:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757352AbYALHws
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 02:52:48 -0500
Received: from mail.qikoo.org ([60.28.205.235]:51680 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756552AbYALHwr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 02:52:47 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 555C647095; Sat, 12 Jan 2008 15:37:15 +0800 (CST)
X-Mailer: git-send-email 1.5.4.rc2.9.gf5146-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70290>

This patch series introduces summary support for submodule.

The first three patches teach git-submodule subcommand  'summary', and the last two patches teach git-status/git-commit 'status.submodulesummary' configuration to enable/disable submodule summary.
