From: Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] GIT 1.2.1
Date: Thu, 16 Feb 2006 13:41:57 -0800
Message-ID: <20060216214157.GA16047@kroah.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B300614210F@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 22:42:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9qtH-0005cn-G5
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 22:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWBPVmQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 16:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWBPVmQ
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 16:42:16 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:10938
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932261AbWBPVmP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 16:42:15 -0500
Received: from [192.168.0.138] (helo=localhost)
	by aria.kroah.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1F9qtC-0002rD-Gd; Thu, 16 Feb 2006 13:42:14 -0800
To: "Brown, Len" <len.brown@intel.com>
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300614210F@hdsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16313>

On Thu, Feb 16, 2006 at 01:47:28AM -0500, Brown, Len wrote:
> Happy to notice Documentation/git-send-email
> to standardize greg's scripts, but don't see it in the release.
> 
> anybody using it?

I used it to send out my last 2 round of git patches (usb and i2c).  I
like it a lot better than my original script, Ryan's done a great job of
cleaning up my horrible perl code.

thanks,

greg k-h
