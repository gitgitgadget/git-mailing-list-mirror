From: david@lang.hm
Subject: Re: how to track the history of a line in a file
Date: Fri, 2 Jan 2009 16:59:36 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0901021658330.21567@asgard.lang.hm>
References: <alpine.DEB.1.10.0901021405460.21567@asgard.lang.hm> <20090102212655.GA24082@coredump.intra.peff.net> <alpine.DEB.1.10.0901021459480.21567@asgard.lang.hm> <alpine.DEB.1.10.0901021544580.21567@asgard.lang.hm>
 <7vvdsxb9oh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 03 00:59:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LItvg-0007Yz-1K
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 00:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757281AbZABX5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 18:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757066AbZABX5Y
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 18:57:24 -0500
Received: from mail.lang.hm ([64.81.33.126]:40823 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753942AbZABX5X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 18:57:23 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n02NvESJ024410;
	Fri, 2 Jan 2009 15:57:14 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <7vvdsxb9oh.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104447>

On Fri, 2 Jan 2009, Junio C Hamano wrote:

> david@lang.hm writes:
>
>> I was misunderstanding git blame
>
> You may find the --porcelain output format of git-blame useful to make
> your script safer and more robust.

where is this output defined? I can look at it and understand it, but I 
don't know what is guarenteeded to exist, what will be on a specific line, 
and what may vanish on me.

David Lang
