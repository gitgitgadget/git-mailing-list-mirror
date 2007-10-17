From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Use exit 1 instead of die when req_Root fails.
Date: Wed, 17 Oct 2007 15:15:26 -0400
Message-ID: <98FA3712-B4E5-499A-B3E5-818FC33833DA@silverinsanity.com>
References: <20071017140547.GA21691@Hermes.cust.hotspot.t-mobile.com> <20071017190646.GC9041@planck.djpig.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Wed Oct 17 21:15:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiEMW-00029w-Fq
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 21:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760090AbXJQTPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 15:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759974AbXJQTPM
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 15:15:12 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:43835 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759241AbXJQTPK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 15:15:10 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id DA9A91FFC22D;
	Wed, 17 Oct 2007 19:15:08 +0000 (UTC)
In-Reply-To: <20071017190646.GC9041@planck.djpig.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61412>


On Oct 17, 2007, at 3:06 PM, Frank Lichtenheld wrote:

> I have this in my repo and will submit this with the other git- 
> cvsserver
> changes. I was just waiting for either Junio to return or someone else
> stepping up.

Ah.  I had missed that.  I just dug up the patch when switching to  
Shawn's repo gave me those old testing errors.  Had thought it had  
gotten lost in the shuffle.

Never mind me then,
~~ Brian
