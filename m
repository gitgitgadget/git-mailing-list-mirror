From: david@lang.hm
Subject: Re: Comments on Presentation Notes Request.
Date: Wed, 7 Jan 2009 00:33:09 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0901070030320.31038@asgard.lang.hm>
References: <c115fd3c0901061433i78bf3b26v77e5981aada6728e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 08:32:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKStS-0005mT-NY
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 08:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbZAGHag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 02:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbZAGHaf
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 02:30:35 -0500
Received: from mail.lang.hm ([64.81.33.126]:56403 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132AbZAGHae (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 02:30:34 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n077UWeh023053;
	Tue, 6 Jan 2009 23:30:32 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <c115fd3c0901061433i78bf3b26v77e5981aada6728e@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104768>

On Tue, 6 Jan 2009, Tim Visher wrote:

> *** Natural Backup
>
> Because every developer has a copy of the repository, every developer
> you add adds an extra failure point.  The more developers you have,
> the more backups you have of the repository.

this needs to be re-worded. 'extra failure point' can be read to mean 
redundancy in what would otherwide be a single point of failure, but it 
can also mean another point where things can fail.

something like 'every developer adds an extra layer of redundancy' would 
be much less ambiguous.

David Lang
