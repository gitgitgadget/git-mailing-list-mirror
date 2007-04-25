From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH 0/5]: Minor fixes
Date: Wed, 25 Apr 2007 11:17:43 -0300
Organization: Mandriva
Message-ID: <20070425111743.47dfb1fb@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Apr 25 16:17:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgiJi-0003lA-1h
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 16:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbXDYORy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 10:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754617AbXDYORy
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 10:17:54 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:46387 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601AbXDYORx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 10:17:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id B9B3117AD3;
	Wed, 25 Apr 2007 11:17:51 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id WZ2Z5tr7tkiw; Wed, 25 Apr 2007 11:17:46 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 6CBBB17AE2;
	Wed, 25 Apr 2007 11:17:44 -0300 (BRT)
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45526>


 Hi,

 Some random things I've fixed while reading the code, they're
unrelated changes, but I think it's better to send in one shot.

Diff stat:

 Documentation/core-tutorial.txt |    9 ++++-----
 builtin-commit-tree.c           |    3 +--
 cache.h                         |    2 +-
 entry.c                         |   14 +++++++-------
 read-cache.c                    |   16 ++++++++--------
 5 files changed, 21 insertions(+), 23 deletions(-)

-- 
Luiz Fernando N. Capitulino
