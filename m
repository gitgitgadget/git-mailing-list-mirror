From: Chris Perkins <cperkins@medialab.com>
Subject: Re: Gitbox
Date: Wed, 13 Apr 2011 23:28:06 -0300
Message-ID: <4DA65BB6.5080909@medialab.com>
References: <BANLkTikfCDm-5Yde=2Cm-ROc1dcMwopvOg@mail.gmail.com> <4238CC86-13A5-4DB8-B8B2-BC3AA2F2DA5E@gmail.com> <4DA654D4.5040104@medialab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Joshua Juran <jjuran@gmail.com>,
	Daniel Searles <daniel.paul.searles@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Drew Northup <drew.northup@maine.edu>, oleganza@gmail.com,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Searles <dsearles@medialab.com>
To: Chris Perkins <cperkins@medialab.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 04:28:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QACI5-0002Uy-E4
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 04:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757703Ab1DNC2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 22:28:12 -0400
Received: from smtp01.frii.com ([216.17.135.167]:59288 "EHLO smtp01.frii.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753398Ab1DNC2M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 22:28:12 -0400
Received: from s-expression.local (unknown [190.195.43.191])
	by smtp01.frii.com (FRII) with ESMTP id 5414BE8318;
	Wed, 13 Apr 2011 20:28:08 -0600 (MDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4DA654D4.5040104@medialab.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171502>

On 4/13/11 11:02 PM, Randal L. Schwartz wrote:
>>>>>> "Chris" == Chris Perkins <cperkins@medialab.com> writes:
>
> Chris> Is that a violation of the GPL? I would say that it absolutely
> Chris> is.
>
> Which part, then?  Name chapter and verse.

Section 2 b). I quoted it in whole in my email:

  2 b) You must cause any work that you distribute or publish,
  that in whole or in part contains or is derived from the Program
  or any part thereof, to be licensed as a whole at no charge to
  all third parties under the terms of this License.

and the last paragraph in the "how to" section is even more frank.


> But if the GPL is to be treated as a legally enforceable document, "live
> by the sword, and die by the sword".  GPL-desk-pounders can't have it
> both ways.

I'm not a GPL-desk-pounder. I write commercial software for a living.
But I take the efforts I put into my software very seriously. If I were
to release software as free software under a license like the GPL I
would not appreciate someone attempting to profit off my hard work by
putting a bow on it and selling it as their own.

Don't get me wrong. I don't see Gitbox as just a 'bow' atop Git.
Frankly, the type of wrapping that Gitbox is doing seems perfectly
reasonable to me. Gitbox is providing real value to users, it's not
disguising or hiding Git and it's not pretending to be provide the work
of Git as its own and it isn't trying to pretend to be anything that it
isn't.

However, that said, I still think it's a violation of the GPL. That
license lays it out very clearly without much room for interpretation.
You can't make commercial works based on GPL licensed software.  Without
Git there is no Gitbox. End of story.

I'm not a lawyer, were I then perhaps I'd know solidly one way or other.
 I'm not the author nor one of the contributors to Git. Were I then
perhaps I might feel differently about Gitbox being 'perfectly reasonable'.

But I will add this, some on our team would very much like to
incorporate Git into one of our own upcoming commercial products.
Code-wise in the same manner as Gitbox has done. But we aren't going to
do this, because the GPL license for Git clearly states that we cannot.

Chris
