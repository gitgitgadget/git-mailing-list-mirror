From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Importing Mozilla CVS into git
Date: Thu, 1 Jun 2006 22:36:25 -0400
Message-ID: <9e4733910606011936i725e8eb2h8c2357f3688da43e@mail.gmail.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <1149204044.27695.38.camel@neko.keithp.com>
	 <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com>
	 <1149214075.5521.31.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 04:36:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlzWa-0006gX-2w
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 04:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWFBCg1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 22:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWFBCg1
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 22:36:27 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:15676 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751151AbWFBCg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jun 2006 22:36:26 -0400
Received: by nz-out-0102.google.com with SMTP id s18so429996nze
        for <git@vger.kernel.org>; Thu, 01 Jun 2006 19:36:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lUEK31PyB2EGhJp6J4Q60zGRbR/Uhyf590j4rSwFr2dCNwHaxvdD9jfJbDX47eO8NZzDPgXf318KZdWsOrKzqjmmJHy83oOtXPIgudjoEGl8YDLmKPWnvyj3SS2ciSJ/4f5+rITNOstcAhSil7wufXciWWc/tu15/M8NblBHyFQ=
Received: by 10.37.20.12 with SMTP id x12mr1782198nzi;
        Thu, 01 Jun 2006 19:36:25 -0700 (PDT)
Received: by 10.36.39.3 with HTTP; Thu, 1 Jun 2006 19:36:25 -0700 (PDT)
To: "Keith Packard" <keithp@keithp.com>
In-Reply-To: <1149214075.5521.31.camel@neko.keithp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21136>

On 6/1/06, Keith Packard <keithp@keithp.com> wrote:
> yeah, these happen when vendor branches go awry. I'll pull the
> repository and take a look. X.org had similar 'issues' as the current
> CVS repo was built by merging mesa, XFree86 and X.org together in a
> rather haphazard fashion.

Let me know what you find. Converting this without rewriting parsecvs
looks to be beyond the capacity of my home machine. I'm sure you have
access to giant machines at Intel.

Did I see that you can use CVS client tools to manipulate a git
repository? Mozilla has a lot of users on other OSes besides Linux. It
would be nice to change the core server over to git and leave these
other users running their existing tools.

-- 
Jon Smirl
jonsmirl@gmail.com
