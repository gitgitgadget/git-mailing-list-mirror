From: Hanspeter Kunz <hp@edelkunz.ch>
Subject: Re: git-send-email is omitting author and date lines
Date: Mon, 24 Sep 2007 01:35:38 +0200
Message-ID: <1190590538.12557.1.camel@localhost>
References: <1190585633.29937.44.camel@localhost>
	 <7v4phlc668.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 01:35:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZazP-0002rV-Ny
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 01:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785AbXIWXfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 19:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754754AbXIWXfq
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 19:35:46 -0400
Received: from seamus.madduck.net ([213.203.238.82]:53401 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754251AbXIWXfp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 19:35:45 -0400
Received: from [192.168.2.102] (84-72-80-233.dclient.hispeed.ch [84.72.80.233])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: hp@edelkunz.ch)
	by seamus.madduck.net (postfix) with ESMTP id 89FA6401C39;
	Mon, 24 Sep 2007 01:35:44 +0200 (CEST)
In-Reply-To: <7v4phlc668.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.10.3 
X-Virus-Scanned: ClamAV 0.91.2/4372/Sun Sep 23 23:35:33 2007 on seamus.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59002>

On Sun, 2007-09-23 at 16:29 -0700, Junio C Hamano wrote:
> Hanspeter Kunz <hp@edelkunz.ch> writes:
> 
> > When sending a patch to myself using `git-send-email` I realized that
> > the lines containing the author and the date (lines 5 and 6 in the patch
> > file) were not in the sent email.
> 
> Was the commit authored by yourself?

yes. does this make a difference?
