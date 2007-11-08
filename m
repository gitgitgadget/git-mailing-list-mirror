From: Andy Whitcroft <apw@shadowen.org>
Subject: git push mirror mode V3
Date: Thu, 8 Nov 2007 16:58:01 +0000
Message-ID: <20071108165801.GM9736@shadowen.org>
References: <20071108121136.GG9736@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 17:58:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqAho-0004H4-HR
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 17:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759003AbXKHQ5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 11:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759154AbXKHQ5z
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 11:57:55 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:3052 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715AbXKHQ5z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 11:57:55 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1IqAhT-0003tX-VG
	for git@vger.kernel.org; Thu, 08 Nov 2007 16:57:52 +0000
Content-Disposition: inline
In-Reply-To: <20071108121136.GG9736@shadowen.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Received-SPF: pass
X-SPF-Guess: pass
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64053>

Ok, here is an update based on feedback from the list.  I bit the bullet
and added some basic tests.  The stack passes the test suite.  Hopefully
the attribution is ok on the first patch now.  I have kept my
modifications to it a separate patch for the time being to keep
attribution simple.

-apw
