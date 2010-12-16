From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: [PATCH 0/3] minor gitweb modifications
Date: Thu, 16 Dec 2010 22:43:18 +0100
Message-ID: <1292535801-7421-1-git-send-email-sylvain@abstraction.fr>
Cc: Sylvain Rabot <sylvain@abstraction.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 16 22:43:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTLbq-0005V0-9B
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 22:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757490Ab0LPVn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 16:43:28 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:51311 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756083Ab0LPVn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 16:43:28 -0500
Received: by wwi17 with SMTP id 17so818662wwi.1
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 13:43:27 -0800 (PST)
Received: by 10.216.46.19 with SMTP id q19mr3027415web.0.1292535806858;
        Thu, 16 Dec 2010 13:43:26 -0800 (PST)
Received: from localhost.localdomain (85-168-197-251.rev.numericable.fr [85.168.197.251])
        by mx.google.com with ESMTPS id n11sm297651wej.43.2010.12.16.13.43.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 13:43:26 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163815>

Hi,

here a three patch serie with minor updates for gitweb based on master.

I'm not really fond of the third patch but it solves a problem
I've encountered on several files.

Regards.

Sylvain Rabot (3):
  gitweb: add extensions to highlight feature
  gitweb: decorate a bit more remotes
  gitweb: remove test when closing file descriptor

 gitweb/gitweb.perl |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

-- 
1.7.3.2
