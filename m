From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow any HTTP authentication scheme, not only basic
Date: Tue, 31 Mar 2009 21:04:30 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0903312104010.6676@intel-tinevez-2-302>
References: <1238520686-546-1-git-send-email-martin@martin.st> <1238525665-10776-1-git-send-email-martin@martin.st>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Martin Storsjo <martin@martin.st>
X-From: git-owner@vger.kernel.org Tue Mar 31 21:07:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LojHk-0001zf-F3
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 21:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371AbZCaTEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 15:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753369AbZCaTEf
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 15:04:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:49845 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751905AbZCaTEe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 15:04:34 -0400
Received: (qmail invoked by alias); 31 Mar 2009 19:04:31 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 31 Mar 2009 21:04:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VXSkGatXVQV93CURjhp7qJt4Fs9H3SC21bkrWEk
	K2GKBAMv7i0Jgn
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1238525665-10776-1-git-send-email-martin@martin.st>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115300>

Hi,

On Tue, 31 Mar 2009, Martin Storsjo wrote:

> Updated patch, enable only on libcurl versions new enough

Heh, you beat me to looking up from which version onward curl supports 
this...

Thanks!
Dscho
