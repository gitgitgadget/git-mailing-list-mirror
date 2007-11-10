From: bob <kranki@mac.com>
Subject: git packs
Date: Fri, 9 Nov 2007 23:47:40 -0500
Message-ID: <F6DD8DCD-416B-4DDF-B384-7213C9ED5565@mac.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 05:48:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqiGO-0002ZD-DP
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 05:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbXKJErt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 23:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbXKJErt
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 23:47:49 -0500
Received: from smtpoutm.mac.com ([17.148.16.67]:59841 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751229AbXKJErt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 23:47:49 -0500
Received: from mac.com (asmtp003-s [10.150.69.66])
	by smtpoutm.mac.com (Xserve/smtpout004/MantshX 4.0) with ESMTP id lAA4lmVY023850
	for <git@vger.kernel.org>; Fri, 9 Nov 2007 20:47:48 -0800 (PST)
Received: from [192.168.2.23] (c-66-176-54-4.hsd1.fl.comcast.net [66.176.54.4])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp003/MantshX 4.0) with ESMTP id lAA4lkjo004205
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Fri, 9 Nov 2007 20:47:47 -0800 (PST)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64302>

When a repository is packed such as for a clone or fetch, is there  
just one pack file created that is used for the transfer?
