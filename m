From: Gaurav Negi <gaurav.negi@gmail.com>
Subject: gitweb not running as expected
Date: Wed, 21 Oct 2015 15:02:54 -0700 (MST)
Message-ID: <1445464974057-7641718.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 00:03:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zp1TH-0001cK-9g
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 00:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602AbbJUWCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 18:02:54 -0400
Received: from mwork.nabble.com ([162.253.133.43]:56110 "EHLO mwork.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754915AbbJUWCy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 18:02:54 -0400
Received: from mjim.nabble.com (unknown [162.253.133.84])
	by mwork.nabble.com (Postfix) with ESMTP id 73DAF2BB82D5
	for <git@vger.kernel.org>; Wed, 21 Oct 2015 15:03:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280025>

Dear All,
   I am trying to install GIT on web.
Running "git instaweb" gives me this?

$ git instaweb --httpd=lighttpd
Instance already running. Restarting...
No known browser available.
http://127.0.0.1:1234


Any idea? What I need to do on my GIT server?

Thanks
-Gaurav



--
View this message in context: http://git.661346.n2.nabble.com/gitweb-not-running-as-expected-tp7641718.html
Sent from the git mailing list archive at Nabble.com.
