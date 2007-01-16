From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [RFC] Replace rebase with filtering
Date: Tue, 16 Jan 2007 11:20:08 -0800
Message-ID: <45AD2568.4040408@midwinter.com>
References: <45AC3B5D.6080700@midwinter.com> <Pine.LNX.4.63.0701161216440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 20:20:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6tqz-0007Ij-2Q
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 20:20:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbXAPTUL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 14:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbXAPTUL
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 14:20:11 -0500
Received: from tater.midwinter.com ([216.32.86.90]:42432 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751286AbXAPTUK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 14:20:10 -0500
Received: (qmail 25383 invoked from network); 16 Jan 2007 19:20:09 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.131?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 16 Jan 2007 19:20:09 -0000
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701161216440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36954>

Johannes Schindelin wrote:
> I had the impression that the use of "--ignore-if-in-upstream" in 
> git-rebase avoids exactly this case: re-applying changes which are already 
> in upstream.
>
> Doesn't it work that way?
>   

Where's that option documented? The manpage makes no mention of it at all.

-Steve
