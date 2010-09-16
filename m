From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: tig show <commit> not working anymore?
Date: Thu, 16 Sep 2010 07:53:39 -0500
Message-ID: <20100916125337.GG5785@bowser.ece.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 16 15:03:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwE7e-0001pU-JM
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 15:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699Ab0IPNDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 09:03:21 -0400
Received: from ironclad.mail.utexas.edu ([146.6.25.7]:11486 "EHLO
	ironclad.mail.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412Ab0IPNDT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 09:03:19 -0400
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Sep 2010 09:03:19 EDT
X-IronPort-MID: 54971073
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aj4FAJOvkUyAU36S/2dsb2JhbACUMI1iccEEhUEEhEs2hS4
Received: from wb7-a.mail.utexas.edu ([128.83.126.146])
  by ironclad.mail.utexas.edu with ESMTP; 16 Sep 2010 07:53:41 -0500
Received: (qmail 15865 invoked from network); 16 Sep 2010 12:53:40 -0000
Received: from bowser.ece.utexas.edu (a.kumar@146.6.33.245)
  by wb7.mail.utexas.edu with (RC4-SHA encrypted) ESMTPSSA; 16 Sep 2010 12:53:40 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156327>

Hi!

I observed that, since commit
53c089443cd9885fa677becee4bf7ffd56c3c357, tig show <commit> doesn't
seem to work the same way as I had expected it to. The documentation
update doesn't seem to indicate that this was to be expected (or I
didn't understand it properly). Could someone please confirm that
tig show <commit> should actually do something similar to git show <commit> | tig ?

Thanks!

Kumar
