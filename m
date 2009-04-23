From: David Abrahams <dave@boostpro.com>
Subject: Re: [doc] User Manual Suggestion
Date: Thu, 23 Apr 2009 17:31:13 -0400
Message-ID: <B873CD38-2CFE-4138-8A77-8957FA3DB81C@boostpro.com>
References: <m24owgqy0j.fsf@boostpro.com> <20090423175717.GA30198@fieldses.org> <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com> <20090423201636.GD3056@coredump.intra.peff.net> <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.4)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 23:33:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx6XK-0004Rq-Sw
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 23:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758047AbZDWVbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 17:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757066AbZDWVbP
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 17:31:15 -0400
Received: from boost-consulting.com ([206.71.190.141]:58011 "EHLO
	boost-consulting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475AbZDWVbP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 17:31:15 -0400
Received: from [192.168.188.134] (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
	(Authenticated sender: dave)
	by boost-consulting.com (Postfix) with ESMTPSA id 7CCF81CC1E;
	Thu, 23 Apr 2009 14:28:45 -0700 (PDT)
In-Reply-To: <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com>
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117389>


On Apr 23, 2009, at 4:45 PM, Michael Witten wrote:

> On Thu, Apr 23, 2009 at 15:16, Jeff King <peff@peff.net> wrote:
>> On Thu, Apr 23, 2009 at 01:37:05PM -0500, Michael Witten wrote:
>>
>>> Everyone talks about "before one has the conceptual foundation
>>> necessary to understand". Well, here's an idea: The git  
>>> documentation
>>> should start with the concepts!
>>>
>>> Why don't the docs start out defining blobs and trees and the object
>>> database and references into that database? The reason everything is
>>> so confusing is that the understanding is brushed under the tutorial
>>> rug. People need to learn how to think before they can effectively
>>> learn to start doing.
>>
>> I agree with you, but not everyone does (and you can find prior  
>> debates
>> in the list archives). The user-manual is pretty "top down". There  
>> are
>> some "bottom-up" resources available, but I haven't seen one  
>> pointed to
>> as "definitive".I think it might actually be nice for there to be a
>> parallel to the user manual that follows the bottom-up approach, and
>> people could read the one that appeals most to them (or if they  
>> have a
>> lot of time on their hands, read both and hopefully it makes sense in
>> the middle ;) ).
>
> I think the main problem, then, is that the tools have a UI that is
> somewhere in the middle.

Well, "the UI" (how many do we really have for Git?) is spread across  
the spectrum.  The git command-line alone lets you do incredibly low- 
level things that "nobody should ever do" and some really high-level  
things that are everyone's bread-and-butter.  There's no obvious  
distinction.

> However, a discussion of blobs, trees, commits, objects, and
> references isn't necessarily low-level. It seems to me that it is a
> high-level understanding of the git world. Without those
> *definitions*, people are left to their own wrong, inconsistent
> thoughts.

1000% agreed.

> The low-level stuff is HOW those concepts have been used in the
> implementation of git: Where certain files are stored, how certain
> bytes are organized in memory, what are the underlying porcelain
> tools, etc. That what's low-level.

Yep

>> But we would need somebody to volunteer to write it. I would be  
>> happy to
>> help out, but I'm too short on time at the moment to be the driving
>> force.
>
> Maybe I'll try to write something, but it won't take place quickly,
> either. I'd want to read ALL of the existing documentation first.

See you in a couple years ;-)

--
David Abrahams
BoostPro Computing
http://boostpro.com
