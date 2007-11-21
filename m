From: Dan Zwell <dzwell@gmail.com>
Subject: Re: [PATCH] Highlight keyboard shortcuts in git-add--interactive
Date: Wed, 21 Nov 2007 17:00:50 -0600
Message-ID: <4744B8A2.6020503@zwell.net>
References: <1195655278-19535-1-git-send-email-win@wincent.com> <20071121152817.GA27144@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>, Dan Zwell <dzwell@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 00:01:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuyZS-0006u8-V6
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 00:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbXKUXBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 18:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753685AbXKUXBI
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 18:01:08 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:32156 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444AbXKUXBG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 18:01:06 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2957030wah
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 15:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=Ex/1zwBuSxK+qEwK7vGtja1Bh7DtMzkY7cEcYyInsbA=;
        b=i8c7dXQ45fbp6Zru43CGY/0/yZI1W14pv/RxTen/zlG/G+nXQna8ZMvAd9dm3/rDwXv0KATh1RNSEOiz2Rlr819D7pxc7A8NqJJ0tyvcn5NnEJ8fy6QQPSntaFluW6sK/UVFZ6NHySEsdFPgm+d1a8oZhNEOUB+R+kaQzXZVSsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=hk66M3AnbwGL75h/5sNXfER2rNFs27cNoZzw2XB698TVex8XmD+QULcvqIM0HjFtGUnbGEBzFPUAPiq+wvmP9TGg/5NkpWD5gDafZfnZbo0/3G7xaT8OWVm/UA6AwS+aWclszhyjaFtcS6MZOzEYZ979KBuGNjpSq9XdxgRc+Vw=
Received: by 10.115.107.1 with SMTP id j1mr494697wam.1195686065715;
        Wed, 21 Nov 2007 15:01:05 -0800 (PST)
Received: from ?143.44.70.185? ( [143.44.70.185])
        by mx.google.com with ESMTPS id f78sm638673pyh.2007.11.21.15.01.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Nov 2007 15:01:04 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071031)
In-Reply-To: <20071121152817.GA27144@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65711>

Jeff King wrote:
 > Dan, any progress on the next revision of the patch
 > series?
 >

Yeah, I've been busy with school work, but Thanksgiving break has just 
started. I hope to have something to send tonight, though it probably 
will not be the final draft, as it has quite a bit of changes from the 
last version.

Dan
