From: Martijn Kuipers <martijn.kuipers@lx.it.pt>
Subject: Strange date format in git-send-email
Date: Wed, 5 Jul 2006 08:17:37 +0100
Organization: Instituto Superior Tecnico / Instituto =?utf-8?q?Telecomunica=C3=A7=C3=B5es?=
Message-ID: <200607050817.37366.martijn.kuipers@lx.it.pt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jul 05 09:18:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fy1eC-0006be-77
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 09:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWGEHSA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 03:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWGEHSA
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 03:18:00 -0400
Received: from [193.136.221.1] ([193.136.221.1]:6029 "EHLO cascais.lx.it.pt")
	by vger.kernel.org with ESMTP id S932172AbWGEHSA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jul 2006 03:18:00 -0400
Received: from amsterdam.lx.it.pt (amsterdam.lx.it.pt [193.136.222.181])
	by cascais.lx.it.pt (8.12.5/8.12.5) with ESMTP id k657E96A003502
	for <git@vger.kernel.org>; Wed, 5 Jul 2006 08:14:10 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23337>

Dear list,

My email is sorted by date and a number of email-patches list the date format 
as unknown (in kmail, that is).

When checking the headers of these mails I see the following pattern:

Date: mer, 05 jui 2006 00:36:08 +0200
X-Mailer: git-send-email 1.4.1

Date: wto, 20 cze 2006 17:59:19 +0200
X-Mailer: git-send-email 1.3.0

Date: Tue, Mar 14 12:12:35 2006 -0500
User-Agent: send_patch 0.1

Date: Tue Feb 7 18:21:02 2006 +0100


Some of these are quite old, and it has been sometime since I last noticed it 
(I actually thought it was fixed). But today I received another patch-email 
from the list ([PATCH] Beautifulise git-show output), which showed the same 
problem.

Is this my problem (or kmail), or is there something funny with 
git-send-email? I just don't git it.

If you need more info, just holler.

Kind regards,
Martijn
----------------------------------------------------------------------------------------------
Actually, did actually notice actually how many times non-native English 
speaker actually use actually?
