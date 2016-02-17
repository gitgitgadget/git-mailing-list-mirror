From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Wed, 17 Feb 2016 18:24:07 +0100
Message-ID: <20160217172407.GD1831@hank>
References: <vpqoabox66p.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 17 18:23:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW5pQ-0006zB-0K
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 18:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161143AbcBQRXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 12:23:47 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34861 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965115AbcBQRXo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 12:23:44 -0500
Received: by mail-wm0-f46.google.com with SMTP id c200so225186221wme.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 09:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ukh5pgwRGDUZCjaBbOUyAgXBthk/Q9IjSwRVR4+renk=;
        b=a0o4M80ObyLarAu8JN3JhuY4nNSPzhX1U3lnjZ2j+1s/6D67on9NfnYGwOjG74UZpu
         4ZY3WVx7XBoPBQXrJYvkyMIRLw0052IqFbwvs9kYQ3JSzNUUfOuWU9kfiDsRQDFhyrYm
         1JQJrIzCqVQ35uauyF+JyI8Ilu+HaMVz9A4aIxKrODI8nS7wo9VnLumgXSj5e1Y/B9iG
         rXRzaACwLF3A7wzK6+9asJ6y5yPkYNHa66FbxtVpPogYx+Yyeav1oHanVN4y0jAmjZzR
         eAhq180Sbfpnx4xStiJiUb50uJt0py8yD6wSNb/PrYBxasMznRfV0GkhMAyJq55LUAN0
         dszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ukh5pgwRGDUZCjaBbOUyAgXBthk/Q9IjSwRVR4+renk=;
        b=DUnYunMNa0KAFg6VPkGnjehMrF7lu9hbQXEimCvmlz/ZcZV4oSGK+uTdjLBxS/O/lm
         OaC+ipPCCBgHg1atcc3bI2qZC0Owj5K+gWlehTAX0TZHH6OIKeRUp2fs+YZyM88Yp6g7
         Ed1BEmHJBXls6fi/ia2m9tLIcSH6jtjH618RmtyNFNOYvQMnZKvO0ItMxhV5/IXaoytV
         Y6JkjSUpsO01mE43D0inNjI49ipfMkHLx/BctwuoGbFbqZMSy4TWybUkTaap87DcBlQq
         koIZT6oPZl5m/Qo3lUm+yoZuDFF6SW4yKa9Jzp8PjHiv55+i3NOuyHQ44Wct3SkdMyCb
         OHkQ==
X-Gm-Message-State: AG10YOTOK1KayZIMxaX+gv4D+aQbjkqW0FFlFZ2pJK5b2GNj6adcIfxhFTM4ML+OG3bGYg==
X-Received: by 10.28.97.135 with SMTP id v129mr27202864wmb.90.1455729823519;
        Wed, 17 Feb 2016 09:23:43 -0800 (PST)
Received: from localhost (host144-107-dynamic.41-79-r.retail.telecomitalia.it. [79.41.107.144])
        by smtp.gmail.com with ESMTPSA id i2sm2502928wje.22.2016.02.17.09.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Feb 2016 09:23:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <vpqoabox66p.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286513>

On 02/10, Matthieu Moy wrote:
> Work on the application itself, and on the list of ideas.

One potential idea:

Make destructive git commands more safe for the user.

Some commands (e.g. git reset --hard, git clean -f, etc.) can
potentially destroy some of the users work.  Store the information
that we are potentially losing somewhere, where it's easily
retrievable by the user.

This should probably be hidden behind a new config variable
(core.iKnowWhatImDoingButIReallyDont or something better), as it has
the potential to really inflate the repository size (when storing
binary files that should be deleted by git clean for example).

It happened more than once that I thought I knew what I was doing, but
would have been really glad if git saved me from my mistakes.

I haven't thought this through much further than just the idea, so it
would be great to hear some opinions on it first.
