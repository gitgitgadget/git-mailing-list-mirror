From: Wolfgang Denk <wd@denx.de>
Subject: "git cvsimport" with branches?
Date: Sun, 17 Jul 2005 10:40:53 +0200
Message-ID: <20050717084053.94D603525D1@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Jul 17 10:42:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Du4jA-00058Q-Ub
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 10:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVGQImS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 04:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVGQImS
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 04:42:18 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:15280 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261187AbVGQImR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 04:42:17 -0400
Received: from fwd17.aul.t-online.de 
	by mailout10.sul.t-online.com with smtp 
	id 1Du4j0-0002X7-00; Sun, 17 Jul 2005 10:42:14 +0200
Received: from denx.de (ExExJYZXoeVak7qnCcYssJxUUfmkLpjyE1VUKsCPmSZ+MiFKk61B41@[84.150.113.51]) by fwd17.sul.t-online.de
	with esmtp id 1Du4iv-26NejI0; Sun, 17 Jul 2005 10:42:09 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP id 16A89422A7
	for <git@vger.kernel.org>; Sun, 17 Jul 2005 10:42:07 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 94D603525D1
	for <git@vger.kernel.org>; Sun, 17 Jul 2005 10:40:53 +0200 (MEST)
To: git@vger.kernel.org
X-ID: ExExJYZXoeVak7qnCcYssJxUUfmkLpjyE1VUKsCPmSZ+MiFKk61B41@t-dialin.net
X-TOI-MSGID: 4f114d2b-1457-4b9d-adf1-931f4a97e441
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Is there a way to make "git cvsimport" create branches in git for any
branches it encounters in the CVS repository?

All my imports so far show just a linear line of development, and CVS
branch information seems lost.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Little known fact about Middle Earth:   The Hobbits had a very sophi-
sticated computer network!   It was a Tolkien Ring...
