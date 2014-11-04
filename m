From: "Dr. George E. Moore" <gem@x-ctr-l.com>
Subject: Using git clone
Date: Tue, 04 Nov 2014 11:59:59 -0500
Organization: Extreme Computing Group
Message-ID: <1415120399.4259.5.camel@precision690.xccg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 13:58:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn5bS-0003h6-Kh
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 13:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708AbaKHM6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 07:58:48 -0500
Received: from ecbiz55.inmotionhosting.com ([173.205.124.107]:48964 "EHLO
	ecbiz55.inmotionhosting.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753662AbaKHM6s (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Nov 2014 07:58:48 -0500
X-Greylist: delayed 95480 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Nov 2014 07:58:48 EST
Received: from c-98-223-104-188.hsd1.in.comcast.net ([98.223.104.188]:58417 helo=[192.168.1.110])
	by ecbiz55.inmotionhosting.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.82)
	(envelope-from <gem@x-ctr-l.com>)
	id 1XlhTr-0006Il-Ne
	for git@vger.kernel.org; Tue, 04 Nov 2014 12:01:22 -0500
X-Mailer: Evolution 3.4.4-3 
X-OutGoing-Spam-Status: No, score=-1.5
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ecbiz55.inmotionhosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - x-ctr-l.com
X-Get-Message-Sender-Via: ecbiz55.inmotionhosting.com: authenticated_id: gem@x-ctr-l.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is it appropriate to use "git clone" to update the master branch of an
existing repository? The current master branch is for a much earlier
release candidate.
