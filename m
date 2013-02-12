From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/3] Fix installation paths with "make install-doc"
Date: Tue, 12 Feb 2013 14:39:54 -0800
Message-ID: <20130212223954.GH12240@google.com>
References: <cover.1360700102.git.john@keeping.me.uk>
 <20130212222508.GG12240@google.com>
 <20130212223657.GJ2270@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Feb 12 23:40:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5OWY-00078w-4T
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 23:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755117Ab3BLWkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 17:40:00 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:41884 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab3BLWj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 17:39:59 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so347473pad.25
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 14:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=MBkVA0DUo+UOelUx/Z8eY9yHtH2GAj/C+63BtvXy/0g=;
        b=USAMDh68uMiLsdBxugWNxt82Y4084ebPBidGDOv8a95YzetkyfCXBhiwklszQ5R78f
         iO+XRFBxv2BeU6mKEzMgG4s6d+N4W8Oik1oX+XGgutMfQoeL8+yV0L9lO9CW/zx5XnfP
         o48DJOZyWO59JktPBBHAgULEvOMwMWq5fjS33wJOaSLhmezR+iUa5eJh2TED6Auqp1/f
         yVekXZ3+MMeEVbwM32XPjIQDQyuNA1xar4TzrZqBkyv7TtyL4p8ot4AgZUcpUR9pXGJF
         Fdc+2Qpomk6doNEo2suprgkoKbRziW3kY9C5maUOjwQw/rXqYL1WlVGPgK/R4dMb11x0
         owow==
X-Received: by 10.66.82.226 with SMTP id l2mr56128439pay.64.1360708799060;
        Tue, 12 Feb 2013 14:39:59 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id o5sm78224805pay.5.2013.02.12.14.39.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 14:39:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130212223657.GJ2270@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216211>

John Keeping wrote:
> On Tue, Feb 12, 2013 at 02:25:08PM -0800, Jonathan Nieder wrote:
>> John Keeping wrote:

>>>   Documentation/Makefile: fix inherited {html,info,man}dir
>>
>> This doesn't seem to have hit the list.
>
> Hmm... it made it to gmane:
>
> http://article.gmane.org/gmane.comp.version-control.git/216188

So it did.  Sorry for the noise --- I'll grab it from there.

Sincerely,
Jonathan
