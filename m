From: "Josh Boyer" <jwboyer@gmail.com>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Thu, 18 Jan 2007 05:52:38 -0600
Message-ID: <625fc13d0701180352m151cceb3lf9c00b6cf0ae937b@mail.gmail.com>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
	 <87ps9d7j6t.fsf@morpheus.local>
	 <7vejptsglj.fsf@assigned-by-dhcp.cox.net>
	 <625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com>
	 <7vsle9p8pg.fsf@assigned-by-dhcp.cox.net>
	 <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net>
	 <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com>
	 <7v64b4ohcj.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0701180135r505a75a5j172c70792d6569c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 12:52:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Vov-0003Op-RW
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 12:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbXARLwl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 06:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbXARLwl
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 06:52:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:3097 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185AbXARLwk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 06:52:40 -0500
Received: by ug-out-1314.google.com with SMTP id 44so157224uga
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 03:52:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GLzNZ76w+40Rtu7BgZt9Hwk3d4iQQSEtntcWrjBBkL4TIu4yGBz8tS13oB6jwSh41EG4vcrNp4QNu/EIQZMUpoMYDY7ki4INh+pB3rT3UPcqcgw3V88NSgcbHSrjcfkRPJiwZcRXJN/eqBKcKdYR3TgraQocBhlRplgGmZkAYgM=
Received: by 10.82.113.6 with SMTP id l6mr156885buc.1169121158335;
        Thu, 18 Jan 2007 03:52:38 -0800 (PST)
Received: by 10.82.107.1 with HTTP; Thu, 18 Jan 2007 03:52:38 -0800 (PST)
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701180135r505a75a5j172c70792d6569c0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37083>

On 1/18/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> I think we'd raising the entry barrier with choosing the defaults
> being so convenient for us. Well, the real-life programmers
> are less of Unix-liking kind. They are more lazy and demotivated
> kind, and Git will be _forced_ on them. It almost certainly
> will not be their choice. Not always, some'll like it (heck, I know
> people who swear by Perforce!), but most have a job, source
> of income, and not the profession (like in professional pride).

real-life programmers?  Please don't generalize.  It's insulting.

> As much as like Unix and everything related, I think it is
> not reasonable to try to change the majority. Not unless
> we have something earth-shattering. Well, git is, but
> 0001-fix....patch in email attachment probably not.

I would venture to say that the _majority_ of git users are not using
Windows.  In this enviroment, Linux is likely the dominant OS,
followed by other *nix.  So changing the extention to benefit the
majorit of _git's_ users is a good thing.

josh
