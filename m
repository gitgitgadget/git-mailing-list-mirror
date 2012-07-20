From: Darek Bridges <darek.bridges@me.com>
Subject: git with large files...
Date: Fri, 20 Jul 2012 12:27:05 -0400
Message-ID: <A18A933F-5627-4844-A4A6-B3AF244FD211@me.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 20 19:27:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsGyx-0001YS-HW
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 19:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269Ab2GTR1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 13:27:10 -0400
Received: from nk11p03mm-asmtpout003.mac.com ([17.158.232.38]:49430 "EHLO
	nk11p03mm-asmtpout003.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752997Ab2GTR1J (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2012 13:27:09 -0400
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Jul 2012 13:27:09 EDT
Received: from [12.202.42.134] by nk11p03mm-asmtp003.mac.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Jan
  3 2012)) with ESMTPSA id <0M7G00HRSWD6UQ40@nk11p03mm-asmtp003.mac.com> for
 git@vger.kernel.org; Fri, 20 Jul 2012 16:27:08 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.7.7855,1.0.260,0.0.0000
 definitions=2012-07-20_03:2012-07-19,2012-07-20,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 ipscore=0 suspectscore=13 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=6.0.2-1203120001
 definitions=main-1207200156
X-Mailer: Apple Mail (2.1278)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201789>

I use git for many things, but I am trying to work out the workflow to use git for deployment. I have a wordpress site that i need to track multiple branches of and it has many many resource files, images, video, etc... how can i streamline the performance. ive read about git-annex and also something about git-bigfiles being merged in but i dont know how any of that has progressed, and I am just trying to work out the best way to handle this large site.

Happy Cake Oven -->  -[__]-
