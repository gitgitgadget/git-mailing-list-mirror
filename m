From: Jesper Eskilson <jesper.eskilson@iar.se>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 19:50:36 +0200
Message-ID: <487E34EC.40708@iar.se>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 16 22:38:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJDlc-0001ml-S2
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 22:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbYGPUha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 16:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753157AbYGPUh3
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 16:37:29 -0400
Received: from mail1.iar.com ([193.58.238.150]:4717 "EHLO mail1.iar.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752807AbYGPUh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 16:37:29 -0400
Received: from exchange.iar.se ([10.200.10.15])
	by mail1.iar.com (mail1.iar.com)
	(MDaemon PRO v9.6.5)
	with ESMTP id md50001359993.msg
	for <git@vger.kernel.org>; Wed, 16 Jul 2008 19:50:37 +0200
X-Spam-Processed: mail1.iar.com, Wed, 16 Jul 2008 19:50:37 +0200
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 10.200.10.15
X-Return-Path: Jesper.Eskilson@iar.se
X-Envelope-From: Jesper.Eskilson@iar.se
X-MDaemon-Deliver-To: git@vger.kernel.org
Received: from seupp-jesper.ad.iar.com ([10.200.22.3]) by exchange.iar.se with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 16 Jul 2008 19:50:36 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <alpine.DEB.1.00.0807161804400.8950@racer>
X-OriginalArrivalTime: 16 Jul 2008 17:50:36.0440 (UTC) FILETIME=[73BE6180:01C8E76C]
X-MDAV-Processed: mail1.iar.com, Wed, 16 Jul 2008 19:50:38 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88746>

Johannes Schindelin wrote:

> Now, it makes me really, really sad that Git has a reputation of being 
> complicated, but I regularly hear from _my_ users that they do not 
> understand how that came about.

Well, Git is not the easiest tool on the market to learn. For people 
used to centralized systems such as RCS/CVS/Subversion, many concepts 
are truly alien. I've recently experienced a transition at our company 
from MKS/SI (a RCS derivative) to Subversion, and the mental gap was for 
many users HUGE. Had we done the transition from MKS/SI to Git, I'm sure 
  several user's brains would have exploded.

 From my perspective, the concept I found most difficult to grasp at the 
very beginning was how the index worked, and many of the introductory 
texts on Git that I looked through only very brielfy explained the 
purpose of the index: Why is it there? Why is it called "index"? How 
does it fit into a typical workflow? Having a CVS/Subversion background, 
it took a while for me to really assimilate the concept.

-- 
/Jesper
