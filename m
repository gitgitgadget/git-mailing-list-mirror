From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: git-scm.com
Date: Fri, 25 Jul 2008 21:55:50 -0700
Message-ID: <d411cc4a0807252155o18083ca0yeae6ac43a5e83bec@mail.gmail.com>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
	 <alpine.DEB.1.00.0807260422250.11976@eeepc-johanness>
	 <20080726025402.GF13539@leksak.fem-net>
	 <alpine.DEB.1.00.0807260506020.26810@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Stephan Beyer" <s-beyer@gmx.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 26 06:57:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMbq9-0002XH-9y
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 06:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbYGZEzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 00:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbYGZEzw
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 00:55:52 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:21894 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbYGZEzw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 00:55:52 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2280483waf.23
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 21:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Y2sClvM2hsLr2rGMoVCwaL6XeLUMaOWWa0p0BSSuAxA=;
        b=H60Pma4TtZXkdCb9Sum+b1hfBgdm9qyByUgIg7ZpDZJNtRmLdAh6ReRC0IUkkr+hLy
         u2V/MThtZL27L7vPmB35OF20mGnzQpgTbgyNew0rMRxk5Q7dZ8/7V/rzfYsNy7gY2FhW
         DqxmQl5YDfbogK3MTFURE6Vx689TXrvQUTNJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FN8GkAecPHFNLJ4d8FubjKUgbRkZhBNic/c4ACutBmHJV6KnFan57weu18PM3rIxA9
         3T4ED++2jl5BDG5gT1zwHZhAb/HBIT0DY7xeFKZlMH28C5mVflM5CcEMJZZJvcxL/XCr
         /c+PJZsGp8JxEKAyvRoOoGSkkXDqTcdyoU2SE=
Received: by 10.114.73.14 with SMTP id v14mr2871161waa.163.1217048150602;
        Fri, 25 Jul 2008 21:55:50 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Fri, 25 Jul 2008 21:55:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807260506020.26810@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90174>

On Fri, Jul 25, 2008 at 8:07 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 26 Jul 2008, Stephan Beyer wrote:
>
>> Johannes Schindelin wrote:
>> > I do not like the implication that Git eats trees.
>>
>> I still like the picture, though it can hurt environmentalists.
>
> It's not just environmentalists.  If I put myself in the shoes of a Git
> newbie, I would get the impression that Git eats my trees, i.e. destroys
> them.
>
> Very good first impression.
>
> Not,
> Dscho
>
>

I was a bit concerned about using the little guy too, but I've gotten
overall very good feedback about him - people seem to like him.  I
think it's good to have a little bit of illustration on a page.
However, as for your concerns, I think a) it's really hard to argue
that environmentalists would actually care what that thing is doing
and b) a newbie to Git will have no idea what a 'tree' is - that is
really only a sort of inside joke.  You would have to have been using
git for a good amount of time to know that 'eating a tree' would be a
bad thing.  That's why I've been telling people that he's _storing_
trees and that you don't want to be around when he 'gc --prune's :)

Scott "not top-posting" Chacon
