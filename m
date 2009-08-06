From: "lists@mgreg.com" <lists@mgreg.com>
Subject: Re: Merging to and from non-current branches.
Date: Wed, 5 Aug 2009 21:48:34 -0400
Message-ID: <C766A4F9-C12B-4F94-8B24-9BD3665B70E8@mgreg.com>
References: <D5200130-C7D7-4010-BF62-3A3374F2E3B0@mgreg.com> <alpine.LNX.2.00.0908042236240.2147@iabervon.org> <518952FC-626C-43FB-BD53-98DE849C9751@mgreg.com> <81b0412b0908051428g40b7678ewc549f079abbd03ee@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 03:55:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYsCY-0007iN-TI
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 03:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbZHFBzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 21:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753090AbZHFBzT
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 21:55:19 -0400
Received: from p3plsmtpa01-07.prod.phx3.secureserver.net ([72.167.82.87]:57071
	"HELO p3plsmtpa01-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751247AbZHFBzS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 21:55:18 -0400
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Aug 2009 21:55:18 EDT
Received: (qmail 31688 invoked from network); 6 Aug 2009 01:48:35 -0000
Received: from unknown (76.177.133.127)
  by p3plsmtpa01-07.prod.phx3.secureserver.net (72.167.82.87) with ESMTP; 06 Aug 2009 01:48:35 -0000
In-Reply-To: <81b0412b0908051428g40b7678ewc549f079abbd03ee@mail.gmail.com>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125018>


On Aug 5, 2009, at 5:28 PM, Alex Riesen wrote:

> On Wed, Aug 5, 2009 at 04:48, lists@mgreg.com<lists@mgreg.com> wrote:
>> I appreciate your post.  I understand what you're saying, and I'm  
>> not so
>> much concerned about the logistics of what need to occur so much as  
>> a single
>> command to intuitively handle it.  I've been doing a great deal of
>> incremental development lately and it becomes rather tedious to  
>> have to
>> checkout master, merge dev, re-checkout dev and proceed.  I'm not  
>> sure why
>> this isn't currently possible with a single command.
>
> Because no one needed this sequence of commands for long enough.

As I said, I understand what is being said, but in IMHO it would seem  
that a merge of that nature would be immediately desirable.  Think of  
it more as a local "push".  I'm never a fan of "because it hasn't be  
done means it shouldn't be".  I realize that's not exactly what you're  
saying though.  Anyway, I absolutely appreciate the post, and may very  
well post the script.

Best,

Michael
