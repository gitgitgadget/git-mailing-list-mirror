From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: type in cg-merge?
Date: Fri, 11 Nov 2005 07:52:53 +0000
Message-ID: <200511110752.53249.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 08:53:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaTj2-0007lr-49
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 08:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVKKHwq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 02:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbVKKHwq
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 02:52:46 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:49033
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S932192AbVKKHwp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 02:52:45 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EaTiG-0008Iw-Ql; Fri, 11 Nov 2005 07:52:44 +0000
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.8.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11570>

I am just reading the code in cg-merge to see how it works (taking your advice 
to see how to re-write my history properly - see early threads about this 
subject)

At line there is an echo 0 that looks suspiciously like it should be an exit 
0.

Of course I may just have egg on my face - its my first attempt at looking at 
the code.
-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
