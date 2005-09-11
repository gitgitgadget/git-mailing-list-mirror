From: martin@catalyst.net.nz
Subject: archimport documentation updates and tidyups
Date: Sun, 11 Sep 2005 21:26:05 +1200
Message-ID: <1126430765449-git-send-email-martin@catalyst.net.nz>
Reply-To: martin@catalyst.net.nz
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Sep 11 11:26:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEO6O-0005zt-0q
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 11:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbVIKJ0P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 05:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbVIKJ0P
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 05:26:15 -0400
Received: from 202-0-36-112.cable.paradise.net.nz ([202.0.36.112]:7891 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S964831AbVIKJ0P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 05:26:15 -0400
Received: from aporo-debian (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (Postfix) with SMTP id 48D108A72A
	for <git@vger.kernel.org>; Sun, 11 Sep 2005 21:26:05 +1200 (NZST)
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8282>

This patch series covers the Documentation for the archimport 
script, plus the remaining TODOs that I consider important.

With these patches I consider archimport done, modulo bugs and 
interesting user requests.

 [PATCH 1/5] archimport documentation update
 [PATCH 2/5] archimport documentation tidyup
 [PATCH 3/5] archimport - update in-script doco, options tidyup
 [PATCH 4/5] archimport - use GIT_DIR instead of hardcoded ".git"
 [PATCH 5/5] archimport - better handling of temp dirs
