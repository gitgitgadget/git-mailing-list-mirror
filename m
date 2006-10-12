From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Removes the <?xml?> declaration from gitweb.pl
Date: Thu, 12 Oct 2006 07:45:00 +0200
Organization: Dewire
Message-ID: <200610120745.00909.robin.rosenberg.lists@dewire.com>
References: <20061011172553.GA1147@linux-mips.org> <egjmri$atp$1@sea.gmane.org> <egjnk5$bpn$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 07:44:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXtMq-0005ZM-Ok
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 07:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161244AbWJLFoZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 01:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161254AbWJLFoZ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 01:44:25 -0400
Received: from [83.140.172.130] ([83.140.172.130]:30024 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1161244AbWJLFoZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 01:44:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 3898C80285B;
	Thu, 12 Oct 2006 07:41:23 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25741-04; Thu, 12 Oct 2006 07:41:22 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by torino.dewire.com (Postfix) with ESMTP id DE0D7802677;
	Thu, 12 Oct 2006 07:41:20 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KMail/1.9.4
In-Reply-To: <egjnk5$bpn$2@sea.gmane.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28773>

onsdag 11 oktober 2006 23:27 skrev Jakub Narebski:
> Pazu wrote:
> > The XML declaration forces IE6 into quirks mode, breaking our
> > nice standards compliant stylesheet.
>
> But isn't it _required_ by XML/XHTML?

For pure XML document it is required, but not for XHTML, unless the encoding 
is something other than UTF-8 or (shudder) UTF-16. W3C recommends it though.

-- robin
