From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual: mention git gui citool (commit, amend)
Date: Fri, 3 Aug 2007 08:56:34 -0400
Message-ID: <20070803125634.GB28323@fieldses.org>
References: <11858118802945-git-send-email-prohaska@zib.de> <20070802181853.GB31885@fieldses.org> <107BD473-E055-47D0-9720-9D878BDAB954@zib.de> <20070802223132.GA15212@fieldses.org> <B14C42A6-F4BD-40D7-AEAF-66FFF492AB9B@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Aug 03 14:56:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGwhr-0007fK-Bx
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 14:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757795AbXHCM4g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 08:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757584AbXHCM4g
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 08:56:36 -0400
Received: from mail.fieldses.org ([66.93.2.214]:44695 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757286AbXHCM4f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 08:56:35 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IGwhm-0007eQ-Pq; Fri, 03 Aug 2007 08:56:34 -0400
Content-Disposition: inline
In-Reply-To: <B14C42A6-F4BD-40D7-AEAF-66FFF492AB9B@zib.de>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54718>

On Fri, Aug 03, 2007 at 07:08:44AM +0200, Steffen Prohaska wrote:
>
> On Aug 3, 2007, at 12:31 AM, J. Bruce Fields wrote:
>
>>>> Also, I like the verb "stage" as a way to explain the part of the index
>>>> file in creating commits, but I've been consistently using the word
>>>> "index" throughout the user manual, and I think that's consistent with
>>>> the rest of the documentation--so don't avoid it here.
>>>
>>> "staging/unstaging" is how git gui calls adding/removing files to and
>>> from the index.
>>
>> I understand what you meant, but a reader of the user manual at this
>> point might not, since it's been consistently saying things like "to add
>> the contents of a new file to the index, use git add".  So we should use
>> the same language here.  Unless we want to update the whole thing to use
>> "stage" and "unstage".  I'd rather not.
>
> Agree. But we could briefly introduce git gui's dialect, something like
>
> "git gui lets you select files (use menu 'Commit > Stage to Commit') or
> individually diff hunks (use 'Stage Hunk For Commit' in context menu of
> diff view) for inclusion in the index."

Sounds good to me.  Somebody do that!

--b.
