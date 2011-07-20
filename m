From: Kacper Kornet <kornet@camk.edu.pl>
Subject: git fetch --all --depth
Date: Thu, 21 Jul 2011 00:39:02 +0200
Message-ID: <20110720223902.GA6675@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 21 01:02:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjfms-0003un-F4
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 01:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099Ab1GTXCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 19:02:36 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:48115 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531Ab1GTXCg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 19:02:36 -0400
X-Greylist: delayed 1407 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jul 2011 19:02:36 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 318475F0048
	for <git@vger.kernel.org>; Thu, 21 Jul 2011 00:39:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id jNe5XlVJVYbb for <git@vger.kernel.org>;
	Thu, 21 Jul 2011 00:39:02 +0200 (CEST)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id CB10F5F0047
	for <git@vger.kernel.org>; Thu, 21 Jul 2011 00:39:02 +0200 (CEST)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id BAD4B80953; Thu, 21 Jul 2011 00:39:02 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177559>

Hi,

I have just discovered that when I use:

git fetch --all --depth=<n> 

the history is not deepened. Is the any specific reason for it or is it
a bug?

-- 
  Kacper Kornet
