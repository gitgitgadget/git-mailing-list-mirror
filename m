From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: clean/smudge filters for pdf files
Date: Fri, 24 Oct 2008 10:44:02 +0200
Message-ID: <49018AD2.5070105@drmicha.warpmail.net>
References: <ee2a733e0810231244u1510cdc8y7b27af9b8fdda1e0@mail.gmail.com>	 <20081023213203.GB26104@artemis.corp> <ee2a733e0810231840u1aed8455w7e4c461e2565ad08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Fri Oct 24 10:45:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtIIc-0003PI-Bt
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 10:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbYJXIoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 04:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbYJXIoH
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 04:44:07 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:43476 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752603AbYJXIoG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Oct 2008 04:44:06 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 586AB182526;
	Fri, 24 Oct 2008 04:44:05 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 24 Oct 2008 04:44:05 -0400
X-Sasl-enc: ybZHfDwluNuJ1WpcK4eVl0rNYcwxTFuGYGtPuNCfEPZd 1224837844
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A33ED1C850;
	Fri, 24 Oct 2008 04:44:04 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <ee2a733e0810231840u1aed8455w7e4c461e2565ad08@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99021>

Little addition to my previous reply:

Multivalent apparently almost get's there. After 2 iterations most of
the uncompressed file is stable, except for some binary blob at the end.
Alas, it's Java and not even completely open source.

Michael
