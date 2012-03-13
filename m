From: "Jones, Brian P CTR SPAWARSYSCEN-PACIFIC, 63600" 
	<brian.p.jones4.ctr@navy.mil>
Subject: CAC enabled authentication with git transfer protocols
Date: Mon, 12 Mar 2012 17:54:41 -0700
Message-ID: <B1ECBDB2E23847488F70D870CBE563F70198D579@nawespscez06v.nadsuswe.nads.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 13 02:10:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7GGH-0000pC-Ub
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 02:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757730Ab2CMBKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 21:10:45 -0400
Received: from NAWESDNIAX06O.nmci.navy.mil ([138.163.1.82]:60126 "EHLO
	NAWESDNIAX06O.nmci.navy.mil" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757171Ab2CMBKn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 21:10:43 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Mar 2012 21:10:43 EDT
X-AuditID: 8aa30151-b7c35ae000000ee9-2e-4f5e89d86224
Received: from nawesdnieg06v.nadsuswe.nads.navy.mil (Gate1-Sandiego.nmci.navy.mil [138.163.0.41])
	by  (Symantec Mail Security) with SMTP id 53.33.03817.8D98E5F4; Mon, 12 Mar 2012 23:42:16 +0000 (GMT)
Received: from nawesdnieb05v.nadsuswe.nads.navy.mil ([10.0.10.145]) by nawesdnieg06v.nadsuswe.nads.navy.mil with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 12 Mar 2012 17:54:42 -0700
Received: from nawespsceb01v.nadsuswe.nads.navy.mil ([10.1.120.15]) by nawesdnieb05v.nadsuswe.nads.navy.mil with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 12 Mar 2012 17:54:42 -0700
Received: from nawespscez06v.nadsuswe.nads.navy.mil ([10.1.120.25]) by nawespsceb01v.nadsuswe.nads.navy.mil with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 12 Mar 2012 17:54:42 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CAC enabled authentication with git transfer protocols
Thread-Index: Ac0AsrSstg/7ltFpT9iPbAUfXw8wog==
X-OriginalArrivalTime: 13 Mar 2012 00:54:42.0207 (UTC) FILETIME=[E0128AF0:01CD00B3]
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192966>

Does anyone know if git is being used in a military CAC enabled environment? This means that the DoD CAC card is required to authenticate when hitting the git transfer protocol. This is a requirement before I can propose using git. I understand that git is able to use https as well as ssh or over port 9418. Is there any documentation on setting up CAC enabled git protocols?
 
Brian P. Jones
Senior Software Engineer
 
