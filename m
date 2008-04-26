From: Andrew Morton <akpm@linux-foundation.org>
Subject: warning: too many files, skipping inexact rename detection
Date: Sat, 26 Apr 2008 06:32:09 -0700
Message-ID: <20080426063209.5615dd5e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 15:33:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpkWy-0003l8-2Z
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 15:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257AbYDZNco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 09:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753193AbYDZNco
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 09:32:44 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37481 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753232AbYDZNco (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Apr 2008 09:32:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3QDWA36010716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 26 Apr 2008 06:32:12 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m3QDW9qD024205
	for <git@vger.kernel.org>; Sat, 26 Apr 2008 06:32:09 -0700
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.806 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80374>

I get the above message all the time when pulling all the git trees.

I'm frightened!

y:/usr/src/git26> git --version
git version 1.5.5.rc1
