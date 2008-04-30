From: edpark <edpark@gmail.com>
Subject: Files need updating following a clone?
Date: Wed, 30 Apr 2008 16:12:16 -0700 (PDT)
Message-ID: <65e5553a-a630-4b1a-9c81-f0ed7d9d7361@c19g2000prf.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 01:13:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrLUa-0005mB-CR
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 01:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758505AbYD3XMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 19:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756968AbYD3XMd
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 19:12:33 -0400
Received: from ug-out-1516.google.com ([66.249.92.167]:38162 "EHLO
	ug-out-1516.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758845AbYD3XMc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 19:12:32 -0400
Received: by ug-out-1516.google.com with SMTP id n30so23158ugc.1
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 16:12:19 -0700 (PDT)
Received: by 10.150.12.19 with SMTP id 19mr57623ybl.9.1209597136797; Wed, 30 
	Apr 2008 16:12:16 -0700 (PDT)
X-IP: 99.154.54.166
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; 
	rv:1.9b4) Gecko/2008030317 Firefox/3.0b4,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80878>

This is really strange and I'm wondering if anyone here can help me
out.

I just cloned a remote repository and when I execute a 'git status'
right after it says that some files need to be updated:

utsd.txt:   needs update

If I just cloned a remote repo how did these files get modified?  How
can I make git realize that these files aren't modified?
Further, if I clone to a different machine then the git on that
machine doesn't indicate that any files were modified (??).

Thanks in advance!
