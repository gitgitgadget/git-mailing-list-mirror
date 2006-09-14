From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: open(2) vs fopen(3)
Date: Thu, 14 Sep 2006 09:15:13 +0000 (GMT)
Message-ID: <20060914091513.19826.qmail@web25812.mail.ukl.yahoo.com>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Sep 14 11:15:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNnJZ-00080O-JU
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 11:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWINJPP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 05:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWINJPP
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 05:15:15 -0400
Received: from web25812.mail.ukl.yahoo.com ([217.146.176.245]:34970 "HELO
	web25812.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751484AbWINJPO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 05:15:14 -0400
Received: (qmail 19828 invoked by uid 60001); 14 Sep 2006 09:15:13 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
  b=a+Nb+jqOIYAjW56JcpLnJpYwDhFYyNcvPj99mx9eHgGrpx2Yp0Ugv1ZYXOQuN5bTnLPUAhMK5tJcxC7b0VriBVWop07VRuS6JgDxgUhIse1M1QPSME1t3Fevmds2R9VQC7fGrHY8MPnRFgD6AvSjFBPaoaExYwpf34Z5NAkmIvM=  ;
Received: from [81.252.61.1] by web25812.mail.ukl.yahoo.com via HTTP; Thu, 14 Sep 2006 09:15:13 GMT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26993>

Hi GIT folks,

I'm reading git source code and falling on this stupid question:
Why sometime open(2) is used and other time fopen(3) is
prefered. I'm sorry for this dump question but I have no clue.

thanks

Francis
