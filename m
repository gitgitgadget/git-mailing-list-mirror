From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] deprecate core.statinfo at Git 2.0 boundary
Date: Tue, 7 May 2013 22:29:21 +0200 (CEST)
Message-ID: <335406152.35740504.1367958561946.JavaMail.root@dewire.com>
References: <20130507140904.GA3282@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, j sixt <j.sixt@viscovery.net>,
	Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 07 22:37:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZodP-0003EQ-Du
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 22:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759306Ab3EGUhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 16:37:11 -0400
Received: from zimbra.dewire.com ([83.140.172.131]:38754 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757618Ab3EGUhK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 16:37:10 -0400
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 May 2013 16:37:09 EDT
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id B2DA982B19;
	Tue,  7 May 2013 22:29:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c7POaccxPhnp; Tue,  7 May 2013 22:29:22 +0200 (CEST)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id 0CDA182B05;
	Tue,  7 May 2013 22:29:22 +0200 (CEST)
In-Reply-To: <20130507140904.GA3282@sigill.intra.peff.net>
X-Originating-IP: [78.69.107.197]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Mac)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223600>

This looks ok with me, though I can manage without backward compatibility.

-- robin
