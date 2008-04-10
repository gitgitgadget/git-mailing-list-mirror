From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v2] builtin-status: submodule summary support
Date: Thu, 10 Apr 2008 23:35:24 +0800
Message-ID: <1207841727-7840-1-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 10 17:39:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjyp1-0005sp-7d
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 17:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757115AbYDJPfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 11:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757008AbYDJPfd
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 11:35:33 -0400
Received: from mail.qikoo.org ([60.28.205.235]:42962 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756826AbYDJPfc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 11:35:32 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id BD171470AE; Thu, 10 Apr 2008 23:35:27 +0800 (CST)
X-Mailer: git-send-email 1.5.5.23.g2a5f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79219>

This is a resend after v1.5.5.
