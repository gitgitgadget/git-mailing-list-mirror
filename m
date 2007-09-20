From: David Brown <git@davidb.org>
Subject: Re: [PATCH] [git-p4] Detect exec bit in more cases.
Date: Thu, 20 Sep 2007 08:16:37 -0700
Message-ID: <20070920151637.GA26873@old.davidb.org>
References: <119022570352-git-send-email-git@davidb.org> <200709192103.53526.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Thu Sep 20 17:17:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYNmL-0004HI-DB
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 17:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757439AbXITPQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 11:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755740AbXITPQi
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 11:16:38 -0400
Received: from mail.davidb.org ([66.93.32.219]:49316 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755781AbXITPQi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 11:16:38 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IYNld-0007zc-5G; Thu, 20 Sep 2007 08:16:37 -0700
Mail-Followup-To: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200709192103.53526.simon@lst.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58784>

On Wed, Sep 19, 2007 at 09:03:50PM +0200, Simon Hausmann wrote:
>On Wednesday 19 September 2007 20:15:03 David Brown wrote:

>> git-p4 was missing the execute bit setting if the file had other attribute
>> bits set.
>> ---

>I'm fine with this, so unless you find a better way:
>
>Acked-By: Simon Hausmann <simon@lst.de>

I sent out an improved version of this patch yesterday
<1190232768445-git-send-email-git@davidb.org> that I'd like to get
approved.  I guess I'm not quite sure what happens at this point with a
patch.

Thanks,
David
