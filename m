From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 0/2] Add tests for submodule with empty directory
Date: Wed, 30 Apr 2008 00:07:18 +0800
Message-ID: <1209485240-9003-1-git-send-email-pkufranky@gmail.com>
References: <46dff0320804290831u7ef1a78ag2988d5d12f782bdb@mail.gmail.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 29 18:08:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqsNP-0005bR-Ko
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 18:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765938AbYD2QHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 12:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765711AbYD2QHa
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 12:07:30 -0400
Received: from mail.qikoo.org ([60.28.205.235]:51647 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1764778AbYD2QH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 12:07:26 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id BFDFC470AE; Wed, 30 Apr 2008 00:07:20 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.96.gef4a.dirty
In-Reply-To: <46dff0320804290831u7ef1a78ag2988d5d12f782bdb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80697>

For regression about empty submodule directory

* "git status -a" reports modified
* "git diff" generates diff
