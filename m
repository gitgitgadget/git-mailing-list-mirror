From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Cogito asciidoc failure
Date: 24 Mar 2006 08:17:43 -0800
Message-ID: <86u09n4y1k.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Mar 24 17:18:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMoz7-0002Xh-OE
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 17:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWCXQRu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 11:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWCXQRu
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 11:17:50 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:27441 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932461AbWCXQRt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 11:17:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id DC13F8F826
	for <git@vger.kernel.org>; Fri, 24 Mar 2006 08:17:44 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 20469-01-2 for <git@vger.kernel.org>;
 Fri, 24 Mar 2006 08:17:44 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 083098F913; Fri, 24 Mar 2006 08:17:44 -0800 (PST)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.13.2.16; tzolkin = 10 Cib; haab = 14 Cumku
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17924>


asciidoc -b xhtml11 -d manpage -f asciidoc.conf cg-admin-rewritehist.1.txt
ERROR: cg-admin-rewritehist.1.txt: line 54: title not allowed in list item continuation
make[1]: *** [cg-admin-rewritehist.1.html] Error 1
make: *** [doc] Error 2


-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
