From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 10:10:37 -0400
Message-ID: <20090424141037.GD15038@fieldses.org>
References: <m24owgqy0j.fsf@boostpro.com> <20090423175717.GA30198@fieldses.org> <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com> <20090424022900.GB6321@fieldses.org> <C30426B2-CF6F-48D0-A7D3-F96D4D153057@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 16:18:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxM8S-0004m0-QY
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 16:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757849AbZDXOKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 10:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754769AbZDXOKk
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 10:10:40 -0400
Received: from mail.fieldses.org ([141.211.133.115]:57778 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755323AbZDXOKi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 10:10:38 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1LxM6v-000465-2x; Fri, 24 Apr 2009 10:10:37 -0400
Content-Disposition: inline
In-Reply-To: <C30426B2-CF6F-48D0-A7D3-F96D4D153057@boostpro.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117440>

On Fri, Apr 24, 2009 at 12:06:12AM -0400, David Abrahams wrote:
>
> On Apr 23, 2009, at 10:29 PM, J. Bruce Fields wrote:
>
>> On Thu, Apr 23, 2009 at 01:37:05PM -0500, Michael Witten wrote:
>>> On Thu, Apr 23, 2009 at 12:57, J. Bruce Fields  
>>> <bfields@fieldses.org> wrote:
>>> Why don't the docs start out defining blobs and trees and the object
>>> database and references into that database? The reason everything is
>>> so confusing is that the understanding is brushed under the tutorial
>>> rug. People need to learn how to think before they can effectively
>>> learn to start doing.
>>
>> OK, but let's not over-generalize: the person that just wants to  
>> figure
>> out whether the driver for their network card was fixed in today's
>> network devel tree shouldn't have to sit through a discussion of the
>> object database.
>
> Those people don't need a VCS.  They should download a snapshot or use a 
> web interface.  Seriously.  There's no way you can make even the  
> best-designed VCS simple enough to justify the time it takes to learn  
> enough just to use it for that.
>
>> And even among readers that are in it for the long
>> haul, I think many people will react better to something that gives  
>> them
>> at least a little concrete how-to information up front.
>
> People (well, people like me) should get a brief "hello, world" demo up 
> front, to give them a feel for the flavor of the system, but  
> [important:] it shouldn't attempt to be instructive.  Fundamental  
> concepts are next.  How-to information can come after that, or after the 
> reference information.
>
>> So the goal was always to find a tutorial route through the material
>> that would allow us to introduce the concepts as we go along.
>
> Maybe that will work for some people, but it *really* won't work for me.  
> You can't start throwing around terms of art without defining them unless 
> you want to raise more questions than you're answering.  I would be 
> surprised if it wasn't the same for many tech people.

I agree that (with rare exceptions) terms shouldn't be used before
they're defined.  I don't agree with all of the above, but I think we
could come to a satisfactory compromise.  I'll see if I can find a few
hours this weekend to at least sketch a new organization.  But, as I've
said, I'm short on time and could really use some help.

--b.
