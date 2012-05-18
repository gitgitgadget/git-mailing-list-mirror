From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: msysgit with git protocol to linux server
Date: Fri, 18 May 2012 14:55:13 -0500
Message-ID: <jp69f2$gir$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 21:55:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVTGt-00076D-Pq
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 21:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967190Ab2ERTz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 15:55:27 -0400
Received: from plane.gmane.org ([80.91.229.3]:60741 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967137Ab2ERTz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 15:55:26 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SVTGm-0006un-E4
	for git@vger.kernel.org; Fri, 18 May 2012 21:55:24 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 May 2012 21:55:24 +0200
Received: from nkreitzinger by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 May 2012 21:55:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197968>

If my pc is on the same vpn as the linux server can I use git protocol 
instead of ssh for better speed?

I have instructions on how to setup msysgit with ssh.  (I'm new to 
msysgit and ssh.)  On the linux servers we've been using git protocol 
since they are on the same vpn.  My understanding is that git protocol 
is faster than ssh.

v/r,
neal
