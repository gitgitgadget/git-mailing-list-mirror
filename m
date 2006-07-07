From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 0/1] I forgot to run format-patch with the -M flag
Date: Fri, 07 Jul 2006 03:10:43 -0700
Message-ID: <11522670452824-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jul 07 12:11:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FynIV-0002Au-HQ
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 12:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWGGKKv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 06:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWGGKKv
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 06:10:51 -0400
Received: from hand.yhbt.net ([66.150.188.102]:11960 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932100AbWGGKKu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 06:10:50 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 51E297DC021;
	Fri,  7 Jul 2006 03:10:45 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri,  7 Jul 2006 03:10:45 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.1.g3dc65
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23419>

Now I can forget more often :)  Unless the similarity is too low.

I'm not too sure if I'd want to set similarity or find-copies-harder
into my config just yet, since they depend on the situation.  But I
usually want renames in my diffs.

-- 
Eric Wong
