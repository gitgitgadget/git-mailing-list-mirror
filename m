From: David Abrahams <dave@boostpro.com>
Subject: Re: [doc] User Manual Suggestion
Date: Thu, 23 Apr 2009 17:26:34 -0400
Message-ID: <D912CAB9-E437-4733-8A87-97EE47E3FBBB@boostpro.com>
References: <m24owgqy0j.fsf@boostpro.com> <20090423175717.GA30198@fieldses.org> <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com> <20090423201636.GD3056@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v930.4)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 23:28:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx6Sp-0002ln-57
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 23:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756692AbZDWV0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 17:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756493AbZDWV0h
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 17:26:37 -0400
Received: from boost-consulting.com ([206.71.190.141]:61328 "EHLO
	boost-consulting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755697AbZDWV0g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 17:26:36 -0400
Received: from [192.168.188.134] (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
	(Authenticated sender: dave)
	by boost-consulting.com (Postfix) with ESMTPSA id 0E7431CC23;
	Thu, 23 Apr 2009 14:24:06 -0700 (PDT)
In-Reply-To: <20090423201636.GD3056@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117388>


On Apr 23, 2009, at 4:16 PM, Jeff King wrote:

> On Thu, Apr 23, 2009 at 01:37:05PM -0500, Michael Witten wrote:
>
>> Everyone talks about "before one has the conceptual foundation
>> necessary to understand". Well, here's an idea: The git documentation
>> should start with the concepts!
>>
>> Why don't the docs start out defining blobs and trees and the object
>> database and references into that database? The reason everything is
>> so confusing is that the understanding is brushed under the tutorial
>> rug. People need to learn how to think before they can effectively
>> learn to start doing.
>
> I agree with you, but not everyone does (and you can find prior  
> debates
> in the list archives). The user-manual is pretty "top down".

And that's a problem because so many things are badly named.  It also  
leaves out lots of top

> There are
> some "bottom-up" resources available, but I haven't seen one pointed  
> to
> as "definitive".

I've been pointed at:

1. http://eagain.net/articles/git-for-computer-scientists
2. http://www.newartisans.com/2008/04/git-from-the-bottom-up.html

which, IMO, should be read in that order.  I've just sent John Wiegley  
a huge pile of editorial commentary on #2, which I think could improve  
things.

But that said, "laying conceptual foundation" doesn't imply bottom- 
up!  In fact, I don't think the first one is particularly bottom-up

--
David Abrahams
BoostPro Computing
http://boostpro.com
