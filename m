From: Chris Frey <cdfrey@foursquare.net>
Subject: whitespace checking in git-add?
Date: Fri, 20 Feb 2009 18:04:54 -0500
Message-ID: <20090220230454.GA10112@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 00:13:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaeYz-0003Qk-SY
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 00:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbZBTXL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 18:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754525AbZBTXL4
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 18:11:56 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:39306 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516AbZBTXL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 18:11:56 -0500
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Feb 2009 18:11:55 EST
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id n1KN4sNI011756
	for <git@vger.kernel.org>; Fri, 20 Feb 2009 18:04:54 -0500
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.8, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: cdfrey@foursquare.net
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110902>

Hi,

Is it possible to somehow enable whitespace checking during git-add?
In my searches, I can only seem to find mention of it in git-diff.

Thanks,
- Chris
