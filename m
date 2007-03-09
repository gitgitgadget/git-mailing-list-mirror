From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Problems with autoCRLF?
Date: Fri, 9 Mar 2007 20:51:47 +0100
Organization: Dewire
Message-ID: <200703092051.47441.robin.rosenberg.lists@dewire.com>
References: <1173464102.6102.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Raimund Bauer <ray007@gmx.net>
X-From: git-owner@vger.kernel.org Fri Mar 09 22:11:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPmMN-0006N8-9i
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 22:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965817AbXCIVKg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 16:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965819AbXCIVKf
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 16:10:35 -0500
Received: from [83.140.172.130] ([83.140.172.130]:19353 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S965817AbXCIVKd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 16:10:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id AB7AF803396;
	Fri,  9 Mar 2007 22:05:19 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05005-08; Fri,  9 Mar 2007 22:05:19 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 55398802848;
	Fri,  9 Mar 2007 22:05:19 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <1173464102.6102.18.camel@localhost>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41810>

fredag 09 mars 2007 19:15 skrev Raimund Bauer:
> Is it really intended that with a setting core.autoCRLF=true textfiles
> are checked out with crlf-lineendings on linux-boxes?
> 
> I found out because the git-compilation broke ...
> 
> Now using core.autocrlf=input ;-)

My guess is it's good for testing without having to compromise your 
computer (or with cygwin).

-- robin
