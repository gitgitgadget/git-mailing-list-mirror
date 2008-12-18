From: Indy Nagpal <indy@strakersoftware.com>
Subject: Git with Hudson
Date: Fri, 19 Dec 2008 08:23:19 +1300
Message-ID: <D2F0F023-862A-4BAB-88B9-BFEFC5592D10@strakersoftware.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 20:24:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDOUH-0005Zh-Ks
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 20:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbYLRTX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 14:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752250AbYLRTX0
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 14:23:26 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:6508 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbYLRTXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 14:23:25 -0500
Received: by wa-out-1112.google.com with SMTP id v27so299717wah.21
        for <git@vger.kernel.org>; Thu, 18 Dec 2008 11:23:25 -0800 (PST)
Received: by 10.114.167.10 with SMTP id p10mr1318982wae.198.1229628204635;
        Thu, 18 Dec 2008 11:23:24 -0800 (PST)
Received: from ?192.168.0.102? (121-72-160-74.dsl.telstraclear.net [121.72.160.74])
        by mx.google.com with ESMTPS id m28sm3125550poh.25.2008.12.18.11.23.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Dec 2008 11:23:23 -0800 (PST)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103482>

Hi

Currently we use Subversion as our VCS. This ties into our CI process  
that uses Hudson.

I've been using git svn with great success over the last few months  
and a few our developers have also started using it. We now almost  
ready to switch our repository from SVN to Git.

However, before we do that I wanted to check if anyone has had any  
experience/feedback in integrating Git with Hudson CI server?

Thanks

Indy

PS: Apologies if this is posted a couple of times to the list. Gmail  
is refusing to send the email to the mailing list address, so trying  
to send it in a couple of different ways

-- 
Indiver Nagpal
Straker Interactive
