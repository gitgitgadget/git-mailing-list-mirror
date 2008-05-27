From: Chris Frey <cdfrey@foursquare.net>
Subject: Re: git log --grep missing entries?
Date: Tue, 27 May 2008 16:48:48 -0400
Message-ID: <20080527204848.GA13929@foursquare.net>
References: <20080527202842.GA32252@foursquare.net> <483C70E3.3060607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 22:50:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K167s-0004Cu-SO
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 22:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759116AbYE0UtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 16:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757958AbYE0UtM
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 16:49:12 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:34671 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759288AbYE0UtF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 16:49:05 -0400
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id m4RKmm6P014531;
	Tue, 27 May 2008 16:48:49 -0400
Content-Disposition: inline
In-Reply-To: <483C70E3.3060607@gmail.com>
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.8, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83048>

On Tue, May 27, 2008 at 10:36:51PM +0200, Lea Wiemann wrote:
> According to the man page of git-log, --grep only greps the log message, 
> not the author.  Does that help?

Doh.  That would certainly explain it.  Thanks!

- Chris
