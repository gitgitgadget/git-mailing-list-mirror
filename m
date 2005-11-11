From: Alexander Litvinov <lan@ac-sw.com>
Subject: Something looks like CVS modules
Date: Fri, 11 Nov 2005 13:13:26 +0600
Organization: AcademSoft Ltd.
Message-ID: <200511111313.27273.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 11 08:13:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaT5Z-0006kw-6A
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 08:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVKKHMa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 02:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVKKHM3
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 02:12:29 -0500
Received: from gw.ac-sw.com ([81.1.223.2]:46491 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S1751234AbVKKHM3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 02:12:29 -0500
Received: from lan.ac-sw.lcl (unknown [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP id 00376BD30
	for <git@vger.kernel.org>; Fri, 11 Nov 2005 13:12:21 +0600 (NOVT)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id 49B38CE807; Fri, 11 Nov 2005 13:13:28 +0600 (NOVT)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id B1055C5937
	for <git@vger.kernel.org>; Fri, 11 Nov 2005 13:13:27 +0600 (NOVT)
To: git@vger.kernel.org
User-Agent: KMail/1.8
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on lan.ac-sw.lcl
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11567>

Does anybody can guide me how to replace CVS modules in the git enviroment ?

Currently we have few (~5) projects that can be used by others. At cvs world 
we have modules and everything works fine. There are external links in the 
svn word - almost the same except tags and branches.

What can I do to make similar functionality with git ?
