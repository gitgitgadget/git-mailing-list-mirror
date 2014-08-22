From: Howard Chu <hyc@symas.com>
Subject: Wishlist: git fetch --reference
Date: Thu, 21 Aug 2014 19:57:47 -0700
Message-ID: <53F6B1AB.3030706@symas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 05:17:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKfLr-0002UH-Cc
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 05:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471AbaHVDRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 23:17:09 -0400
Received: from zill.ext.symas.net ([69.43.206.106]:58496 "EHLO
	zill.ext.symas.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984AbaHVDRI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 23:17:08 -0400
X-Greylist: delayed 1159 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Aug 2014 23:17:08 EDT
Received: from cust233-73.nwewn.com ([78.155.233.73] helo=[192.168.1.103])
	by zill.ext.symas.net with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <hyc@symas.com>)
	id 1XKf2z-0007fQ-9h
	for git@vger.kernel.org; Thu, 21 Aug 2014 19:57:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:30.0) Gecko/20100101 Firefox/30.0 SeaMonkey/2.27a1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255652>

I maintain multiple copies of the same repo because I keep each one checked 
out to different branch/rev levels. It would be nice if, similar to clone 
--reference, we could also use git fetch --reference to reference a local repo 
when doing a fetch to pull in updates.

-- 
   -- Howard Chu
   CTO, Symas Corp.           http://www.symas.com
   Director, Highland Sun     http://highlandsun.com/hyc/
   Chief Architect, OpenLDAP  http://www.openldap.org/project/
