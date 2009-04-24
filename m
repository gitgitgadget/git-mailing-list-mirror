From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 14:52:08 -0400
Message-ID: <20090424185208.GM17365@fieldses.org>
References: <20090423175717.GA30198@fieldses.org> <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com> <20090423201636.GD3056@coredump.intra.peff.net> <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com> <20090424141139.GC10761@coredump.intra.peff.net> <b4087cc50904240730n42e605e1od37d88d43e00f142@mail.gmail.com> <20090424150442.GA11245@coredump.intra.peff.net> <b4087cc50904240818w45bd1cfaq8bbc83e10a6e3781@mail.gmail.com> <20090424173852.GF17365@fieldses.org> <34BD51FF-0908-48A8-BBBC-E27B0EFB32E5@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 20:53:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxQWu-0003WK-UW
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 20:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbZDXSwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 14:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752276AbZDXSwL
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 14:52:11 -0400
Received: from mail.fieldses.org ([141.211.133.115]:33106 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbZDXSwK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 14:52:10 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1LxQVM-0005Gt-KC; Fri, 24 Apr 2009 14:52:08 -0400
Content-Disposition: inline
In-Reply-To: <34BD51FF-0908-48A8-BBBC-E27B0EFB32E5@boostpro.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117480>

On Fri, Apr 24, 2009 at 02:32:36PM -0400, David Abrahams wrote:
>
> On Apr 24, 2009, at 1:38 PM, J. Bruce Fields wrote:
>
>> On Fri, Apr 24, 2009 at 10:18:15AM -0500, Michael Witten wrote:
>>> I think that we've already got that tutorial-esque style covered (I
>>> haven't read it in a while):
>>>
>>>    http://www.kernel.org/pub/software/scm/git/docs/gittutorial.html
>>>
>>> However, the User Manual should make a Mathematician happy.
>>
>> I'm all for making mathematicians happy.  But, again, help?:
>>
>> 	- Specific examples?
>> 	- Patches?  Please, patches?
>> 	- Suggested text?
>> 	- Suggested outline?
>>
>> There's no shortage of high-level ideas.  What there's always a need  
>> for
>> more of is people willing to submit patches, respond to review, etc.
>
>
> I'll probably try to write something myself once I figure this stuff  
> out.

That would be great, thanks.  Several people have gone off and posted
their own tutorials someplace, and that's fine, but it would be
especially helpful if you could contribute to the actual Documentation/
directory.  That may mean arguing with people and making compromises.
But it also means the results will be distributed with git, will be
integrated with other git documentation, and will get first-class
technical review.

I'd also encourage incrementally improving existing documentation where
possible instead of starting over from scratch.  But having broken that
rule myself a couple times I'm hardly in a position to insist.  If you
must start over, at least think about how to replace or fit it in with
existing documentation.

--b.
