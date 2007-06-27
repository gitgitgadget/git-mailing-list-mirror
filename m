From: "Ewald, Robert" <Robert.Ewald@nov.com>
Subject: git-svn problems with branches containing spaces
Date: Wed, 27 Jun 2007 08:53:06 +0200
Message-ID: <3F225D5F64550C4AA5F23286244275D4298C84@srvkrsexc07.nov.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 27 08:53:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3RP3-0006j6-5J
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 08:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbXF0GxX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 02:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752838AbXF0GxX
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 02:53:23 -0400
Received: from wilma.fastcom.no ([212.20.193.134]:12801 "EHLO wilma.fastcom.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718AbXF0GxW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jun 2007 02:53:22 -0400
Received: from wilma.fastcom.no (bleh [127.0.0.1])
	by bleh (Postfix) with ESMTP id C22D7233791
	for <git@vger.kernel.org>; Wed, 27 Jun 2007 08:53:21 +0200 (CEST)
Received: from srvkrsexc10.nov.com (gatekeeper-1.natoil.no [62.73.241.99])
	by wilma.fastcom.no (Postfix) with ESMTP id B3F7B23378B
	for <git@vger.kernel.org>; Wed, 27 Jun 2007 08:53:21 +0200 (CEST)
Received: from srvkrsexc07.nov.com ([172.17.0.217]) by srvkrsexc10.nov.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 27 Jun 2007 08:53:06 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git-svn problems with branches containing spaces
Thread-Index: Ace4iBIK+0MaAbUISjWRjulNV83I3g==
X-OriginalArrivalTime: 27 Jun 2007 06:53:07.0115 (UTC) FILETIME=[D11357B0:01C7B887]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51021>

Hello,

As I have reported yesterday on IRC, git-svn has problems with branches
containing spaces.
I get the following message, when I want to clone from the repository
containing a branch with a space.
Cloning until the revision the branch is created everything works fine.

fatal: refs/remotes/Modbus Error Limit Fix: cannot lock the ref
update-ref -m r1897 refs/remotes/Modbus Error Limit Fix
ff0819c8e9c97c24e9865bc868c503fd9b64f980: command returned error: 128

Thanks for your help.

Best regards

Robert Ewald

PS. Please CC me, I am not subscribed.
