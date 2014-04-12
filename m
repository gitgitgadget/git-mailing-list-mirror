From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: Clear an invalid password out of the credential-cache?
Date: Sat, 12 Apr 2014 09:12:57 -0400
Organization: PD Inc
Message-ID: <2D1883E9414E4E1E99559A6A2163BE87@black>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'Git List'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 12 15:53:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYyNP-0004Ct-I5
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 15:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbaDLNxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 09:53:43 -0400
Received: from mail.pdinc.us ([67.90.184.27]:33623 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176AbaDLNxm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 09:53:42 -0400
X-Greylist: delayed 2441 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Apr 2014 09:53:42 EDT
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s3CDCw4Z016902
	for <git@vger.kernel.org>; Sat, 12 Apr 2014 09:12:59 -0400
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Ac9WUOwyajQDsBgTTR+5P0MYZxtUwA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246171>

Is it me or is the only way to clear a single invalid password out of the
credential-cache is by "git credential-cache exit"?

-Jason

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
