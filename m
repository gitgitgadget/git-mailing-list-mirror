From: Farrukh Najmi <farrukh@wellfleetsoftware.com>
Subject: Any plans to support JTA and XA in jgit?
Date: Thu, 13 Nov 2008 14:20:49 -0500
Message-ID: <491C7E11.8050005@wellfleetsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 20:22:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0hlV-0000Gu-Nm
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 20:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbYKMTUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 14:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbYKMTUt
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 14:20:49 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:51552 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbYKMTUt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 14:20:49 -0500
Received: from [192.168.1.101] ([71.184.206.167])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KAA0041ODQO4S63@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 13 Nov 2008 13:20:48 -0600 (CST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100899>


Does the gjit team have any plans to implement support for JTA in gjit 
so as to allow distributed transactions using 2 phase commit? This would 
be very powerful when git is being used in conjunction with other 
transaction resource managers such as databases.

-- 
Regards,
Farrukh Najmi

Web: http://www.wellfleetsoftware.com
