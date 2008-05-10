From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 11/22] Added the class StarPattern.
Date: Sat, 10 May 2008 22:53:12 +0200
Message-ID: <200805102253.13033.robin.rosenberg.lists@dewire.com>
References: <1210424440-13886-1-git-send-email-florianskarten@web.de> <1210424440-13886-12-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Florian Koeberle <florianskarten@web.de>
X-From: git-owner@vger.kernel.org Sat May 10 22:55:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juw5o-0001Dj-Fa
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 22:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158AbYEJUyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 16:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754998AbYEJUyG
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 16:54:06 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12918 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754922AbYEJUyG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 16:54:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9E68E1434CC0;
	Sat, 10 May 2008 22:54:03 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5xVEpoAN-TZL; Sat, 10 May 2008 22:54:03 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 2BB251434CBF;
	Sat, 10 May 2008 22:54:03 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1210424440-13886-12-git-send-email-florianskarten@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81699>


Agree with Shawn that we really should have fnmatch,  but then calling
it StarPattern at least signals it isn't the real wildcard. I'd like to see a few more lines of javadoc at the class level here (and the othere paterns) even though it is not a  public class. We must think about our reputation on Ohloh (http://www.ohloh.net/projects/6895) :)

-- robin
