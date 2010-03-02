From: Jez Caudle <gitmailinglist@me.com>
Subject: Only the config file changes ...
Date: Tue, 02 Mar 2010 12:06:48 +0000
Message-ID: <70786312428882320720829319256948501508-Webmail@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 02 14:07:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmRoo-00062w-Qm
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 14:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893Ab0CBNHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 08:07:12 -0500
Received: from asmtpout016.mac.com ([17.148.16.91]:42622 "EHLO
	asmtpout016.mac.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804Ab0CBNHL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 08:07:11 -0500
X-Greylist: delayed 3621 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Mar 2010 08:07:11 EST
Received: from spool003.mac.com ([10.150.69.53])
 by asmtp016.mac.com (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec
 16 2008; 32bit)) with ESMTP id <0KYN00062LJZ17B0@asmtp016.mac.com> for
 git@vger.kernel.org; Tue, 02 Mar 2010 04:06:50 -0800 (PST)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx engine=5.0.0-0908210000 definitions=main-1003020054
Received: from webmail060 ([10.13.128.60])
 by spool003.mac.com (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec
 16 2008; 32bit)) with ESMTP id <0KYN008WVLNCER80@spool003.mac.com> for
 git@vger.kernel.org; Tue, 02 Mar 2010 04:06:49 -0800 (PST)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx engine=5.0.0-0908210000 definitions=main-1003020054
Received: from [89.241.40.67] from webmail.me.com with HTTP; Tue,
 02 Mar 2010 12:06:48 +0000
Received: from [ 92.122.210.198] from webmail.me.com with HTTP; Tue,
 02 Mar 2010 12:06:48 +0000
X-Originating-IP: 89.241.40.67, 92.122.210.198
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141393>

Hi I'm new to Git and I've read the manual and tried my best to understand it.

I have a project that is going to have many versions, all the same except for the config file, the unit/functional tests and some display information.

I have seen that I can create branches and then merge them. I wondered if I could create a branch, change the config file information and then decree that the config file in the new branch is not merged.

I read about sub modules but they didn't seam relevant.

Am I barking up the wrong tree here?

Thanks,

Jez Caudle.
