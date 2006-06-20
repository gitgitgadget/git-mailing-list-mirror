From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/2] gitweb: Enhance page title
Date: Tue, 20 Jun 2006 06:17:03 +0000 (UTC)
Message-ID: <11507842053885-git-send-email-jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 20 08:17:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsZXo-0005s8-C6
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 08:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbWFTGQv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 02:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965082AbWFTGQv
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 02:16:51 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:50305 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S965075AbWFTGQu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 02:16:50 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k5K6GQwt018466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 20 Jun 2006 08:16:27 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k5K6Gkti001823
	for <git@vger.kernel.org>; Tue, 20 Jun 2006 08:16:46 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k5K6GjOu001822
	for git@vger.kernel.org; Tue, 20 Jun 2006 08:16:45 +0200
To: git@vger.kernel.org
Date: wto, 20 cze 2006 08:16:43 +0200
X-Mailer: git-send-email 1.3.0
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22170>


This series of patches adds filename (with '/' at the end added for 
trees, i.e. directories) to the page title, for easier bookmarking and 
viewing browser history.

On top of 'next', but should apply cleanly for 'master' too.
