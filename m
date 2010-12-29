From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: [PATCH 0/3 v3] minor gitweb modifications
Date: Wed, 29 Dec 2010 20:33:32 +0100
Message-ID: <1293651215-4924-1-git-send-email-sylvain@abstraction.fr>
Cc: Sylvain Rabot <sylvain@abstraction.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 29 20:33:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY1mN-0007QP-25
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 20:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804Ab0L2Tdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 14:33:42 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61504 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656Ab0L2Tdl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 14:33:41 -0500
Received: by wwa36 with SMTP id 36so11003142wwa.1
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 11:33:40 -0800 (PST)
Received: by 10.227.98.94 with SMTP id p30mr761003wbn.152.1293651220515;
        Wed, 29 Dec 2010 11:33:40 -0800 (PST)
Received: from localhost.localdomain (85-168-197-251.rev.numericable.fr [85.168.197.251])
        by mx.google.com with ESMTPS id p4sm7300204wer.5.2010.12.29.11.33.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Dec 2010 11:33:39 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4.523.g72f0d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164325>

here a three patch serie with minor updates for gitweb based on master.

This serie has been improved regarding the comments of :

 - Jakub Narebski <jnareb@gmail.com>
 - Jonathan Nieder <jrnieder@gmail.com>

Regards.

Sylvain Rabot (3):
  gitweb: add extensions to highlight feature
  gitweb: remove test when closing file descriptor
  gitweb: add css class to remote url titles

 gitweb/gitweb.perl       |   18 +++++++++---------
 gitweb/static/gitweb.css |    5 +++++
 2 files changed, 14 insertions(+), 9 deletions(-)

-- 
1.7.3.4.523.g72f0d.dirty
