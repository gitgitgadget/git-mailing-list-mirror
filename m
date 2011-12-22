From: Erik Blake <erik@icefield.yk.ca>
Subject: Warning from AV software about kill.exe
Date: Thu, 22 Dec 2011 08:47:24 +0100
Message-ID: <4EF2E08C.3050502@icefield.yk.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 09:27:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rde0E-0004KW-TW
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 09:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839Ab1LVI1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Dec 2011 03:27:47 -0500
Received: from bosmailout18.eigbox.net ([66.96.186.18]:52366 "EHLO
	bosmailout18.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab1LVI1q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2011 03:27:46 -0500
X-Greylist: delayed 2416 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Dec 2011 03:27:46 EST
Received: from bosmailscan20.eigbox.net ([10.20.15.20])
	by bosmailout18.eigbox.net with esmtp (Exim)
	id 1RddN9-0000Wa-Rj
	for git@vger.kernel.org; Thu, 22 Dec 2011 02:47:27 -0500
Received: from bosimpout02.eigbox.net ([10.20.55.2])
	by bosmailscan20.eigbox.net with esmtp (Exim)
	id 1RddN9-0007Iq-Jm
	for git@vger.kernel.org; Thu, 22 Dec 2011 02:47:27 -0500
Received: from bosauthsmtp01.eigbox.net ([10.20.18.1])
	by bosimpout02.eigbox.net with NO UCE
	id C7nT1i00Q01P9Sa017nTWF; Thu, 22 Dec 2011 02:47:27 -0500
X-EN-OrigOutIP: 10.20.18.1
X-EN-IMPSID: C7nT1i00Q01P9Sa017nTWF
Received: from [77.40.181.154] (helo=[192.168.10.131])
	by bosauthsmtp01.eigbox.net with esmtpa (Exim)
	id 1RddN9-00060t-DL
	for git@vger.kernel.org; Thu, 22 Dec 2011 02:47:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
X-EN-UserInfo: 20c972d92b49a3da013d5f179c4005f2:fb4e807829017c6d805c060c7025d0c2
X-EN-AuthUser: erik@icefield.yk.ca
X-EN-OrigIP: 77.40.181.154
X-EN-OrigHost: unknown
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187603>

I'm running git under Win7 64. As I selected "Repository|Visualize all 
branch history" in the git gui, my AV software (Trustport) trapped the 
bin\kill.exe program for "trying to modify system global settings (time, 
timezone, registry quota, etc.)"

Does anyone know the details of this process and what it's function is? 
First time I've seen it, though I'm a relatively new user.

Cheers,
e.
