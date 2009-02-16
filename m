From: Pedro Melo <melo@simplicidade.org>
Subject: Perl module for Git
Date: Mon, 16 Feb 2009 15:44:45 +0000
Message-ID: <2E5115F2-7692-4E6F-B163-3DD2D3943C25@simplicidade.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 16 16:53:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ5mJ-00072s-US
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 16:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbZBPPvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 10:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbZBPPvd
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 10:51:33 -0500
Received: from speed.simplicidade.org ([81.92.204.129]:34371 "HELO
	speed.simplicidade.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750897AbZBPPvd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 10:51:33 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Feb 2009 10:51:32 EST
Received: (qmail 2107 invoked from network); 16 Feb 2009 15:44:56 -0000
Received: from bl4-150-79.dsl.telepac.pt (HELO [192.168.0.201]) (81.193.150.79)
  (smtp-auth username melo@simplicidade.org, mechanism cram-md5)
  by speed.simplicidade.org (qpsmtpd/0.43rc1) with (AES256-SHA encrypted) ESMTPSA; Mon, 16 Feb 2009 15:44:56 +0000
Jabber-Id: melo@simplicidade.org
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110195>

Hi,

I'm writting a small web-based tool for designers to manage a small  
set of HTML templates. They will use SFTP or DAV to edit the templates  
in a development server, and then use the web-based tool to commit  
their changes and push to the test server.

What is the best Perl module for this? I'm thinking on using Git.pm  
but I wonder if there isn't a better solution?

Thanks,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
