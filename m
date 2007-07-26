From: bdowning@lavos.net (Brian Downing)
Subject: Re: git archive ignores .gitignored files?
Date: Thu, 26 Jul 2007 12:36:35 -0500
Message-ID: <20070726173635.GS21692@lavos.net>
References: <20070726173206.GR21692@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 19:36:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE7Ga-0004g6-Od
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 19:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763275AbXGZRgp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 13:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763189AbXGZRgp
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 13:36:45 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:14056 "EHLO
	asav08.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbXGZRgp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 13:36:45 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav08.insightbb.com with ESMTP; 26 Jul 2007 13:36:44 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah5FAJ13qEZKhvbzRmdsb2JhbACBTYVpiCgBAQE1AQ
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 8A240309F31; Thu, 26 Jul 2007 12:36:35 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070726173206.GR21692@lavos.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53848>

On Thu, Jul 26, 2007 at 12:32:06PM -0500, Brian Downing wrote:
> git archive seems to not output files marked in .gitignore.

Never mind; it is "git add" that ignored the file.  Oops.

-bcd
