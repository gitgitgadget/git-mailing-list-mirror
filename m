From: ab_lists@mac.com
Subject: Using email between 2 developers to keep git repositories in sync
Date: Tue, 22 Jan 2008 13:47:44 +0100
Message-ID: <7A02F7D1-9EB0-43AB-96F9-DDD71D4EF5FE@mac.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 22 13:54:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHIde-0000uP-Qv
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 13:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbYAVMxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 07:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbYAVMxd
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 07:53:33 -0500
Received: from smtpoutm.mac.com ([17.148.16.69]:60348 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbYAVMxc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 07:53:32 -0500
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jan 2008 07:53:32 EST
Received: from mac.com (asmtp009-s [10.150.69.72])
	by smtpoutm.mac.com (Xserve/smtpout006/MantshX 4.0) with ESMTP id m0MCls3o010159
	for <git@vger.kernel.org>; Tue, 22 Jan 2008 04:47:54 -0800 (PST)
Received: from [192.168.42.85] ([80.71.54.130])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp009/MantshX 4.0) with ESMTP id m0MClk1J025818
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Tue, 22 Jan 2008 04:47:52 -0800 (PST)
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71447>

Hello there,

I have been converted to git after reading good things about it. I  
have been using it with a personal project and so I'm familiar with  
the basics.
However I need to share code with a co-developer. He also has a code  
base that I need access to. For several reasons, a shared server will  
not work so I was thinking of using email to send patches back and  
forth.
My question is related to the initial setup and sharing of our  
repositories. Would it be necessary for each of us to make a clone and  
make a tarball of that clone to send to one another before we can send  
patches? The documentation is all based on using a git or ssh server  
to set this up.

Thank you for any insights you can provide me!
Annard
