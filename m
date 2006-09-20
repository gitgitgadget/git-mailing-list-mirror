From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Trivial Typo in hooks documentation
Date: Wed, 20 Sep 2006 07:39:48 +0100
Message-ID: <200609200739.48732.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Sep 20 08:40:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPvkO-0002Ij-IV
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 08:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWITGjt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 02:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWITGjt
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 02:39:49 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:5591
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1751226AbWITGjs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 02:39:48 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.63)
	(envelope-from <alan@chandlerfamily.org.uk>)
	id 1GPvkJ-00083u-Av
	for git@vger.kernel.org; Wed, 20 Sep 2006 07:39:47 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.9.4
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27330>

I don't have the source of git on my machine as I am just working from the 
debian packages, so I don't have a patch.  However there is a trivial type on 
the hooks.html documentation that I gues comes from the Documentation 
directory

The first sentence for both "update" and "post-update" hooks has an 
extra "is", marked in capitals below

"This hook is invoked by git-receive-pack on the remote repository, which IS 
happens when a git push is done on a local repository."



-- 
Alan Chandler
http://www.chandlerfamily.org.uk
