From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [patch] color of branches in git status -sb
Date: Thu, 17 Nov 2011 04:55:30 -0600
Message-ID: <20111117105320.GA5591@elie.hsd1.il.comcast.net>
References: <CA+TMmKns-9jiedxY4FiJoBg8akkxwkPBib11EmvCD3r7mRA6vQ@mail.gmail.com>
 <7v4ny3pn4v.fsf@alter.siamese.dyndns.org>
 <CA+TMmKkM0B8Bge4Jz7KVjR=F-dK0ojuVJp-fe2vj96uq5z0DrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Dudebout <nicolas.dudebout@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 11:55:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQzdH-0004j8-6N
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 11:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594Ab1KQKzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 05:55:46 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47467 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756494Ab1KQKzp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 05:55:45 -0500
Received: by ggnb2 with SMTP id b2so864619ggn.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 02:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EHanf5m1qLzSli+0NByuHgoIH/PkJIBuK5NtOFbLgxE=;
        b=nJ6w6opqo19chkqdVn6mYdWIwcJZkydwwXL6CVyDsSFTFyQ/05tRth6ro/+8zY6om7
         J3LJp7FG5kJFzsqlC/WkqfMZAoGIST751b9lfd7VTJgVXfXl/+1oU1MUoFgwSlq0008k
         oALKhYPPLYteDlFvBa2tbXd0cbGZ8SlX+pOcE=
Received: by 10.50.180.193 with SMTP id dq1mr27258027igc.34.1321527344306;
        Thu, 17 Nov 2011 02:55:44 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id el2sm56550147ibb.10.2011.11.17.02.55.39
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 02:55:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+TMmKkM0B8Bge4Jz7KVjR=F-dK0ojuVJp-fe2vj96uq5z0DrA@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185595>

Hi,

Nicolas Dudebout wrote:

> Please disregard this as a patch. I do not have the time to understand
> how they have to be properly formatted. I just pasted the output of my
> git client.

What git client are you using?  Maybe it can be fixed to produce
patches that others can easily apply.

The 'git diff' and 'git format-patch' commands produce applicable
patches when I try, though that doesn't mean much.

Hope that helps,
Jonathan
