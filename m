From: Greg KH <greg@kroah.com>
Subject: Re: Fw: [PATCH 31/49] PCI: PCI/Cardbus cards hidden, needs pci=assign-busses to fix
Date: Thu, 23 Mar 2006 22:17:06 -0800
Message-ID: <20060324061706.GA11248@kroah.com>
References: <20060323161521.28a874e6.akpm@osdl.org> <20060324002930.GA21184@kroah.com> <20060323163844.5fda7589.akpm@osdl.org> <20060324004654.GA19763@kroah.com> <7vbqvw3a62.fsf@assigned-by-dhcp.cox.net> <20060323175126.7ff71032.akpm@osdl.org> <7v3bh837cs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrew Morton <akpm@osdl.org>
X-From: git-owner@vger.kernel.org Fri Mar 24 07:19:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMfde-0000BE-Is
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 07:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWCXGTH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 01:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbWCXGTH
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 01:19:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:24029 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751022AbWCXGTF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 01:19:05 -0500
Received: from [192.168.0.128] (dsl093-040-174.pdx1.dsl.speakeasy.net [66.93.40.174])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id k2O6J2K08493;
	Thu, 23 Mar 2006 22:19:02 -0800
Received: from greg by press.kroah.org with local (masqmail 0.2.19) id
 1FMfbf-30L-00; Thu, 23 Mar 2006 22:17:07 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bh837cs.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17900>

On Thu, Mar 23, 2006 at 06:27:15PM -0800, Junio C Hamano wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> > We wouldn't want to attempt to mix this concept up with email envelopes or
> > email headers or anything like that.  The authorship is an attribute of the
> > patch, and has nothing to do with how it was transported, stored or
> > anything like that.
> 
> Fair enough.  This is the approach I called "the second best" in
> my message but I am inclined to agree with you.
> 
> This was tested once by sending myself two patches.

Oops, just saw this after I sent out the last set of patches.  It looks
good to me, I'll try it out next time.

And yes, I did write the original version of this perl script, but it's
been fixed up and made useful by Ryan.

thanks,

greg k-h
