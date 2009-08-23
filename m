From: Sanjiv Gupta <sanjiv.gupta@microchip.com>
Subject: Pulling one commit at a time.
Date: Sun, 23 Aug 2009 22:18:16 +0530
Message-ID: <4A9172D0.6030507@microchip.com>
References: <F536B7C316F9474E9F7091239725AC9A02FA7F44@CHN-CL-MAIL01.mchp-main.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 23 18:48:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfGF2-0001XE-U9
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 18:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933943AbZHWQsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 12:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933938AbZHWQsR
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 12:48:17 -0400
Received: from smtp01.microchip.com ([198.175.253.47]:18802 "EHLO
	smtp01.microchip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933934AbZHWQsR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 12:48:17 -0400
Received: from CHN-CL-MAIL01.mchp-main.com ([10.10.76.21]) by smtp01.microchip.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 23 Aug 2009 09:48:19 -0700
Received: from [10.41.200.168] ([10.41.200.168]) by CHN-CL-MAIL01.mchp-main.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 23 Aug 2009 09:48:18 -0700
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <F536B7C316F9474E9F7091239725AC9A02FA7F44@CHN-CL-MAIL01.mchp-main.com>
X-OriginalArrivalTime: 23 Aug 2009 16:48:18.0493 (UTC) FILETIME=[843A2ED0:01CA2411]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126860>

Hi,
This is my first post here.
I just wanted to know how can I pull one commit at a time from public 
repository.
e.g.
when I first cloned from the public repo, it was at X. now it 
has reached Y. I just want to pull x+1.
 
how to do that?
 
In SVN, we can just do $ svn update -r next_rev_num
 
thanks
- Sanjiv
