From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3] Minor gitweb modifications and cleanups
Date: Wed, 21 Jun 2006 11:25:51 +0200
Message-ID: <1150881954924-git-send-email-jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 21 11:26:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsyyL-0008Fb-0Z
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 11:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWFUJZ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 05:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWFUJZ6
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 05:25:58 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:61398 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S932495AbWFUJZ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 05:25:57 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k5L9PXuf013053
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 21 Jun 2006 11:25:33 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k5L9PtB7006928
	for <git@vger.kernel.org>; Wed, 21 Jun 2006 11:25:55 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k5L9PssV006927
	for git@vger.kernel.org; Wed, 21 Jun 2006 11:25:54 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22249>


This series of patches is based on git.git 'next' branch
69d830d1a3a1236036bd0f84dd9794d7c8d34b3f

My future gitweb-related batches will be based on this series.

---

 gitweb/gitweb.cgi |   53 +++++++++++++++++++++++++++++++----------------------
 gitweb/gitweb.css |    4 ++--
 2 files changed, 33 insertions(+), 24 deletions(-)

-- 
Jakub Narebski 
ShadeHawk on #git

(git-send-email 1.4.0 with setlocale patch)
