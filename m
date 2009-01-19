From: david@lang.hm
Subject: Re: how to track multiple upstreams in one repository
Date: Mon, 19 Jan 2009 13:08:35 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0901191308030.2428@asgard.lang.hm>
References: <alpine.DEB.1.10.0901181855400.20741@asgard.lang.hm> <alpine.LNX.2.00.0901191627480.4115@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Jan 19 21:06:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP0OQ-0004JN-Qj
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 21:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbZASUFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 15:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752253AbZASUFU
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 15:05:20 -0500
Received: from mail.lang.hm ([64.81.33.126]:53763 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751603AbZASUFT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 15:05:19 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n0JK5Dpk019444;
	Mon, 19 Jan 2009 12:05:13 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.LNX.2.00.0901191627480.4115@reaper.quantumfyre.co.uk>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106387>

On Mon, 19 Jan 2009, Julian Phillips wrote:

> On Sun, 18 Jan 2009, david@lang.hm wrote:
>
>> for linux I want to track both the linus tree and the -stable tree. Ideally 
>> I want to be able to do a checkout of tags from either tree from the same 
>> directory (along with diffs between items in both trees, etc)
>> 
>> I have found documentation on how to clone from each of them, but I haven't 
>> found any simple documentation on how to work with both of them.
>
> You could always just use 
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6-stable.git ? 
> It already contains both the linus tree and all the stable trees ...

I know it contains the releases, but does it contain the -rc trees?

David Lang
