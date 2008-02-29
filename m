From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v2 0/3] git-submodule: New subcommand 'summary'
Date: Sat,  1 Mar 2008 01:34:44 +0800
Message-ID: <1204306487-15849-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 29 19:06:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV9cH-0005g1-GU
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 19:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757004AbYB2SEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 13:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757095AbYB2SEx
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 13:04:53 -0500
Received: from mail.qikoo.org ([60.28.205.235]:54460 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756311AbYB2SEu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 13:04:50 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id C1E2B470B0; Sat,  1 Mar 2008 01:34:47 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75545>

This patch series introduces summary support for submodule.

