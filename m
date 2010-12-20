From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: [PATCH 0/3 v2] minor gitweb modifications
Date: Mon, 20 Dec 2010 20:01:18 +0100
Message-ID: <1292871681-4818-1-git-send-email-sylvain@abstraction.fr>
Cc: Sylvain Rabot <sylvain@abstraction.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 20 20:01:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUkzJ-0007Tv-NQ
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 20:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932733Ab0LTTBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 14:01:30 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64723 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932694Ab0LTTBa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 14:01:30 -0500
Received: by wwa36 with SMTP id 36so3283515wwa.1
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 11:01:29 -0800 (PST)
Received: by 10.216.179.140 with SMTP id h12mr5218326wem.40.1292871688944;
        Mon, 20 Dec 2010 11:01:28 -0800 (PST)
Received: from localhost.localdomain (85-168-197-251.rev.numericable.fr [85.168.197.251])
        by mx.google.com with ESMTPS id n1sm2038948weq.31.2010.12.20.11.01.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Dec 2010 11:01:27 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4.523.g72f0d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164004>

here a three patch serie with minor updates for gitweb based on master.

This serie has been improved regarding the comments of Jakub Narebski <jnareb@gmail.com>

Regards.

Sylvain Rabot (3):
  gitweb: add extensions to highlight feature
  gitweb: decorate a bit more remotes
  gitweb: remove test when closing file descriptor

 gitweb/gitweb.perl       |   18 +++++++++---------
 gitweb/static/gitweb.css |    4 ++++
 2 files changed, 13 insertions(+), 9 deletions(-)

-- 
1.7.3.4.523.g72f0d.dirty
