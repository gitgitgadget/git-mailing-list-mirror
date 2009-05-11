From: Chris Frey <cdfrey@foursquare.net>
Subject: Supporting hashes other than SHA-1
Date: Mon, 11 May 2009 15:52:42 -0400
Message-ID: <20090511195242.GA14756@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 22:15:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3buU-0007pB-OL
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 22:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953AbZEKUP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 16:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721AbZEKUP3
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 16:15:29 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:34132 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbZEKUP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 16:15:29 -0400
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 May 2009 16:15:28 EDT
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id n4BJqhq6015307
	for <git@vger.kernel.org>; Mon, 11 May 2009 15:52:43 -0400
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-4.399, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -2.60)
X-Net-Direct-Inc-MailScanner-From: cdfrey@foursquare.net
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118841>

Hi,

Considering the recent news regarding SHA-1's newly found weaknesses,
is there any general interest in making git flexible enough to support
other hashes in the future?

- Chris
