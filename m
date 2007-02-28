From: bob <kranki@mac.com>
Subject: Re: Centralized repository
Date: Wed, 28 Feb 2007 13:33:18 -0500
Message-ID: <C1BA1944-740D-4E2C-9E0E-971FE7553523@mac.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 19:33:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMTcb-0006aL-1c
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 19:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbXB1Sdr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 13:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbXB1Sdr
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 13:33:47 -0500
Received: from smtpout.mac.com ([17.250.248.183]:53167 "EHLO smtpout.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932231AbXB1Sdq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 13:33:46 -0500
Received: from mac.com (smtpin06-en2 [10.13.10.151])
	by smtpout.mac.com (Xserve/8.12.11/smtpout13/MantshX 4.0) with ESMTP id l1SIXhXM013895
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 10:33:44 -0800 (PST)
Received: from [192.168.2.23] (c-71-196-35-31.hsd1.fl.comcast.net [71.196.35.31])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin06/MantshX 4.0) with ESMTP id l1SIXPSO015768
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 10:33:40 -0800 (PST)
X-Mailer: Apple Mail (2.752.3)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40985>

Thank you, Andy Parkins, Jeff King and Robin Rosenberg, for your  
replies.  You have given me some ideas to look into.  I had not  
thought about linking the .git directory to somewhere else such as  
SMB, NFS, AFP or an external harddrive.  I copied a simpler .git to a  
FAT32 drive, made a soft link to it and everything seemed to work  
fine.  I will continue to play.  Thanks for the ideas. They were just  
what I was looking for.
