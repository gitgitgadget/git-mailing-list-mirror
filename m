From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: sort entries numerically
Date: Sat, 07 Jun 2014 08:05:34 +0200
Message-ID: <5392ABAE.6030208@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 07 08:05:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt9lA-0005AY-HN
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 08:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbaFGGFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2014 02:05:37 -0400
Received: from mout.gmx.net ([212.227.15.19]:63029 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbaFGGFg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2014 02:05:36 -0400
Received: from [192.168.178.21] ([80.171.230.1]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0M4o41-1Wafw33bxN-00z1mp for <git@vger.kernel.org>;
 Sat, 07 Jun 2014 08:05:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:7LDvwVTVd0YbJ4ixoIhp7X66B4DsIzerKeEFSfPFMIVNTupKOru
 /BVNPqM0lrtLPwt5i9kGmhsYAxdv/9Pt2PH+QfdiIntRYtigKyYuKnmbVHHCegzMOu4/tKM
 gggUt1ecu0LGz27NZYbdpOz0i8SeWbYG3GO4aq68bY7O/iVHyAjz5C1I0Zqju+uR0kuwHce
 BvjmMwNMUHycuJCysNmBw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251020>

Hi,

is there any chance to have "1.8" before "1.10" in an output like the following :

...
From https://code.wireshark.org/review/wireshark
   52fe0aa..b69642d  master     -> origin/master
   460db8a..540f061  master-1.10 -> origin/master-1.10
   25bb29a..5741a40  master-1.12 -> origin/master-1.12
   4ee4fc11..97898a2 master-1.8 -> origin/master-1.8


-- 
Toralf
