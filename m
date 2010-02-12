From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: Git under Windows should warn or fail on entities differning
 only in case
Date: Fri, 12 Feb 2010 09:31:58 -0800
Message-ID: <4B75908E.3060407@pcharlan.com>
References: <1265978433.7519.6.camel@chumley> <alpine.DEB.1.00.1002121412300.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: David Hagood <david.hagood@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 12 18:32:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfzNE-0001in-8E
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 18:32:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757436Ab0BLRcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 12:32:06 -0500
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:58615 "EHLO
	swarthymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757319Ab0BLRcF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2010 12:32:05 -0500
Received: from [192.168.1.174] (adsl-71-148-55-8.dsl.chi2ca.sbcglobal.net [71.148.55.8])
	by swarthymail-a1.g.dreamhost.com (Postfix) with ESMTP id BAD6B8F17E;
	Fri, 12 Feb 2010 09:31:58 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <alpine.DEB.1.00.1002121412300.20986@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139729>

On 02/12/2010 05:14 AM, Johannes Schindelin wrote:
> Hi,
> 
> Disclaimer: I am not uninterested in the subject you talk about, but my 
> reply could come over as harsh, due to lack of time. If you are likely to 
> be annoyed by direct criticism, delete this mail and do not reply. Thank 
> you very much.
> 
> On Fri, 12 Feb 2010, David Hagood wrote:
> 
>> I would suggest that git should check for this case, and generate a big 
>> warning about it when it happens. (Yes, it sucks burdening Git with 
>> Windows' problems....)
> 
> Git is burdened with Windows' problems already. That does not suck. What 
> sucks is that you only suggest that Git should check the case, in effect 
> asking the few Git for Windows contributors to do it, instead of 
> just going ahead and scratching your own itch.

I didn't read David's patch as anything other than floating an idea.

Posting a wish item to the list without a patch seems useful to me:

1. Someone might be able to explain why the wished-for item is a bad
idea, or why it's unfeasible to implement.

2. Someone might have a flash of insight for how to implement the idea
in a few lines of code and post the patch, improving Git.

3. Someone might say, "Good idea, go ahead and make the change," and the
person with the itch now knows that the idea will be accepted.

It sounds like this is a (3), which is doing pretty well for an idea
about how to change Git :)

--Pete
