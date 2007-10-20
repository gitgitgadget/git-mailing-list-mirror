From: "Ciprian Dorin Craciun" <ciprian.craciun@gmail.com>
Subject: Re: Announcement of Git wikibook
Date: Sat, 20 Oct 2007 10:40:24 +0300
Message-ID: <8e04b5820710200040q76301c58j33e5d0895956b150@mail.gmail.com>
References: <428b865e0710191321ndd08564yec6366cb10705af6@mail.gmail.com>
	 <C0D5CAE0-A152-4572-81D5-AF2A78DD89C6@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Evan Carroll" <me@evancarroll.com>, git@vger.kernel.org
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Oct 20 09:40:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij8wq-0003FA-JB
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 09:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbXJTHk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 03:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752299AbXJTHk1
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 03:40:27 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:14289 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbXJTHk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 03:40:26 -0400
Received: by wx-out-0506.google.com with SMTP id h31so740282wxd
        for <git@vger.kernel.org>; Sat, 20 Oct 2007 00:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=mslgSXK0L6G+oZcz+T7fPRyqhbUOiO4M4pK7R/cXJY4=;
        b=N4Kmsd2d0mjjE4i4oSJDHoAasH5RwoFqXxM8MNnNwSPj6yhb+1MN5/ptL2MBWj5ciKLZZqiMmBTZ5NcX+X51jxDI2clSuXnpvQxUkPoP4TQ4KrtYvL/mwncGkC4nnUrYpkLzYGU4CjmRuaItU5YFwWkWFw2/WhvSJzfLZGum+tQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tytkx71q7xs76aTql0qreOv8qEJQDegZJyruBzqINbWi/4Zb4kORzy1+/S2T0PDTFabEJxz9zLDzOdtZT12VAwK1PCowIsoK0igtKyX9fp3XHLyaovD35hj/FsmkFj1BOolH/8ULDSAu5eThZ3Uw+aDdhFcs0/h9xvmGMwczLfE=
Received: by 10.70.40.1 with SMTP id n1mr4455567wxn.1192866024876;
        Sat, 20 Oct 2007 00:40:24 -0700 (PDT)
Received: by 10.70.116.2 with HTTP; Sat, 20 Oct 2007 00:40:24 -0700 (PDT)
In-Reply-To: <C0D5CAE0-A152-4572-81D5-AF2A78DD89C6@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61807>

    There is nothing wrong with either of the two approaches. They
could both coexist but address different needs:
    -- the manual should be more oriented on technical issues and
addresses only the most recent versions;
    -- the book should be more user-oriented, and more general,
explaining how source management should be addressed by using git, and
maybe make comparisons with may other versioning systems. Also the
book could relate to many versions -- both old and new.

    Also I would note that the wiki book is more easy to edit... If
you spot errors or want to add something you just go and edit it and
the effect is immediate. But in contrast sending patches involves some
overhead...

    Ciprian.


On 10/19/07, Steffen Prohaska <prohaska@zib.de> wrote:
>
> On Oct 19, 2007, at 10:21 PM, Evan Carroll wrote:
>
> > I've create a git wikibook if anyone wants to help expand it.
> > http://en.wikibooks.org/wiki/Source_Control_Management_With_Git
>
> I'm just curious. What is the advantage of a wikibook?
>
> We already have a manual
>
> http://www.kernel.org/pub/software/scm/git/docs/user-manual.html
>
> including a todo list
>
> http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#todo
>
> So, why don't you send patches improving the manual, but instead
> started a wiki book from scratch?
>
>         Steffen
