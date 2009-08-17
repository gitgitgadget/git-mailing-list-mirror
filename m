From: "George Spelvin" <linux@horizon.com>
Subject: Re: Linus' sha1 is much faster!
Date: 17 Aug 2009 19:12:08 -0400
Message-ID: <20090817231208.32039.qmail@science.horizon.com>
References: <alpine.LFD.2.00.0908171513230.6044@xanadu.home>
Cc: art.08.09@gmail.com, bdonlan@gmail.com, git@vger.kernel.org,
	johnflux@gmail.com, P@draigBrady.com, torvalds@linux-foundation.org
To: linux@horizon.com, nico@cam.org
X-From: git-owner@vger.kernel.org Tue Aug 18 01:12:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdBNC-0000tK-CT
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 01:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbZHQXMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 19:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752441AbZHQXMI
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 19:12:08 -0400
Received: from science.horizon.com ([71.41.210.146]:13924 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752336AbZHQXMH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 19:12:07 -0400
Received: (qmail 32040 invoked by uid 1000); 17 Aug 2009 19:12:08 -0400
In-Reply-To: <alpine.LFD.2.00.0908171513230.6044@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126315>

>> The purpose of the rewrite is to avoid having to make
>> pessimistic assumptions about people who don't respond.
>> 
>> I suppose I should have made that request clearer:
>> Is there anyone who claims copyright on anything here?
>> Or would just like credit?
>> If so, are you willing to donate it to the public domain?

> I think this is much nicer to everyone involved.
>
> As far as I'm concerned, I'm OK with giving any small copyright I might 
> have in this SHA1 implementation, if any, to the public domain.  
> Credits are always nice.

My apologies.  I read a lot of people talking about wanting the code
under different licenses, and thought I'd just cut through it by
providing some PD code.

I didn't turn around and look at it from the point of view of the
people who'd put the work into developing it.  I don't mean to deny
anyone credit for their work.  In fact, providing more detail is on
the to-do list, but I haven't waded through the mail archives and
tracked down who contributed what yet.

I'll work on those polish details once I have it producing the same
assembly code as Linus'.

There are a lot of possible highly-permissive licenses if one is wanted
(zlib, MIT, CC-by), but public domain seems simpler.
