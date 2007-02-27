From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Worrisome bug trend
Date: Tue, 27 Feb 2007 22:07:10 +0100
Organization: Dewire
Message-ID: <200702272207.10453.robin.rosenberg.lists@dewire.com>
References: <7vodnfg4sy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 22:05:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM9W2-0001eX-A2
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 22:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbXB0VFi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 16:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbXB0VFi
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 16:05:38 -0500
Received: from [83.140.172.130] ([83.140.172.130]:21608 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752623AbXB0VFh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 16:05:37 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 7B1DF80339E;
	Tue, 27 Feb 2007 22:00:32 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04385-06; Tue, 27 Feb 2007 22:00:32 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 27EF8802809;
	Tue, 27 Feb 2007 22:00:30 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <7vodnfg4sy.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40805>

tisdag 27 februari 2007 13:31 skrev Junio C Hamano:
> I was reviewing the bugs we fixed since v1.5.0 and noticed
> almost all of them are ancient ones.  We do have small number of
> bugs introduced by recently added commands and options, but I
> see quite a few that are from 2005.
> 
> I take that as a sign that git hasn't been exercised well and
> yet more ancient bugs are sleeping, waiting to be triggered, not
> as a sign that we are very careful and adding only small number
> of risky new code in the releases.
> 
> Which is kind of depressing...

When bugs gets fixed and reappear, that's the time to start worry. That old 
bugs gets fixed is a very good sign. It means Git is being tested by users 
that care. Git is very feature rich and considering that, it's amazing that 
is isn't completly bugridden with a 10K known unfixed bugs. That would be 
depressing, the current state isn't.

-- robin
