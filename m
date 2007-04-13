From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 0/4] Random fixes to Documentation/config.txt
Date: Fri, 13 Apr 2007 18:02:29 +0200
Message-ID: <11764801533023-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 18:03:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcOFD-0008Uk-Tg
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 18:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067AbXDMQC6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 12:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754066AbXDMQC6
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 12:02:58 -0400
Received: from mail.lenk.info ([217.160.134.107]:3264 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754064AbXDMQC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 12:02:57 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HcOEX-0008PU-Tn; Fri, 13 Apr 2007 18:02:45 +0200
Received: from p3ee3f548.dip.t-dialin.net ([62.227.245.72] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HcOEh-0000x3-9x; Fri, 13 Apr 2007 18:02:55 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HcOEL-0001nN-D0; Fri, 13 Apr 2007 18:02:33 +0200
X-Mailer: git-send-email 1.5.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44413>

Just some fixes to config.txt which I made when I wanted
to document the new gitcvs.* variables and which can go directly
to master (or maint even).

      config.txt: Document gitcvs.allbinary
      config.txt: Document core.autocrlf
      config.txt: Change pserver to server in description of gitcvs.*
      config.txt: Fix grammatical error in description of http.noEPSV
