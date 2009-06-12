From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [bug] git cannot find "git pull"?
Date: Fri, 12 Jun 2009 15:10:12 -0400
Message-ID: <4A32A814.5050802@garzik.org>
References: <4A319CE1.6040201@garzik.org> <20090612011737.GB5076@inocybe.localdomain> <4A323C56.1090703@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 21:10:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFC8y-0002aR-JM
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 21:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760141AbZFLTKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 15:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757520AbZFLTKO
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 15:10:14 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:43611 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757167AbZFLTKN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 15:10:13 -0400
Received: from cpe-069-134-158-197.nc.res.rr.com ([69.134.158.197] helo=bd.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1MFC8k-00053h-Vd; Fri, 12 Jun 2009 19:10:15 +0000
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <4A323C56.1090703@garzik.org>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.5 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121441>

Jeff Garzik wrote:
> No strange PATH settings, and this was a completely fresh 
> Fedora-11/x86-64 reformat and reinstall...
> 
> Adding "--exec-path=/usr/libexec/git-core" seems to work.
> 
> I wonder if it is looking for /usr/libexec64/git-core or something?

Same failure (with same workaround) on Fedora 11/i386, fresh install.

	Jeff
