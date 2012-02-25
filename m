From: greened@obbligato.org (David A. Greene)
Subject: send-email SMTP/TLS Debugging
Date: Fri, 24 Feb 2012 23:54:08 -0600
Message-ID: <874nufv4ov.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 06:56:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1Acm-0005i2-PG
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 06:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546Ab2BYF4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Feb 2012 00:56:47 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:51779 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750860Ab2BYF4r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 00:56:47 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1S1AdM-0004Jq-Vr
	for git@vger.kernel.org; Fri, 24 Feb 2012 23:57:29 -0600
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Is there some way to turn on TLS authentication debugging
   using git-send-mail? I'm trying to send a patch but git (or the mail server,
    I suppose) keeps telling me I have "Incorrect authentication data." I've
   checked the settings in .git/config multiple times and they look correct.
   How can I debug this further? [...] 
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed th 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191506>

Is there some way to turn on TLS authentication debugging using
git-send-mail?  I'm trying to send a patch but git (or the mail server,
I suppose) keeps telling me I have "Incorrect authentication data."
I've checked the settings in .git/config multiple times and they look
correct.  How can I debug this further?

Thanks!

                          -Dave
