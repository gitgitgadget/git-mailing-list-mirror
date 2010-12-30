From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: [PATCH 0/4 v4] minor gitweb modifications
Date: Thu, 30 Dec 2010 22:20:27 +0100
Message-ID: <1293744031-17790-1-git-send-email-sylvain@abstraction.fr>
Cc: Sylvain Rabot <sylvain@abstraction.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 30 22:20:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYPvR-0007rf-9b
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 22:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab0L3VUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Dec 2010 16:20:39 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55433 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab0L3VUj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Dec 2010 16:20:39 -0500
Received: by wwa36 with SMTP id 36so11945274wwa.1
        for <git@vger.kernel.org>; Thu, 30 Dec 2010 13:20:38 -0800 (PST)
Received: by 10.227.195.79 with SMTP id eb15mr9589874wbb.192.1293744038075;
        Thu, 30 Dec 2010 13:20:38 -0800 (PST)
Received: from localhost.localdomain (85-168-197-251.rev.numericable.fr [85.168.197.251])
        by mx.google.com with ESMTPS id m10sm11283348wbc.16.2010.12.30.13.20.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Dec 2010 13:20:37 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4.523.g72f0d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164365>

Here the v4 and hopefully final version of minor modifications done to gitweb.

I added a fourth commit on top of v3 which adds a modeline header.

This serie has been improved regarding the comments of :

 - Jakub Narebski <jnareb@gmail.com>
 - Jonathan Nieder <jrnieder@gmail.com>

Regards.

Sylvain Rabot (4):
  gitweb: add extensions to highlight feature map
  gitweb: remove unnecessary test when closing file descriptor
  gitweb: add css class to remote url titles
  gitweb: add vim modeline header which describes gitweb coding rule

 gitweb/gitweb.perl       |   28 +++++++++++++++++-----------
 gitweb/static/gitweb.css |    5 +++++
 2 files changed, 22 insertions(+), 11 deletions(-)

-- 
1.7.3.4.523.g72f0d.dirty
