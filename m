From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] user-manual.txt: Some doc updates
Date: Thu, 19 Apr 2007 21:51:04 +0200
Message-ID: <8aa486160704191251l5232cb52qc6d476061587b361@mail.gmail.com>
References: <87hcrcjre3.fsf@gmail.com> <20070419160235.GE9101@fieldses.org>
	 <alpine.LFD.0.98.0704191205420.4504@xanadu.home>
	 <20070419170157.GF9101@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Apr 19 21:51:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Heceu-00076G-Mp
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 21:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766969AbXDSTvJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 15:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766978AbXDSTvI
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 15:51:08 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:39067 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766969AbXDSTvH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 15:51:07 -0400
Received: by wx-out-0506.google.com with SMTP id h31so728381wxd
        for <git@vger.kernel.org>; Thu, 19 Apr 2007 12:51:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=owl5yq6toec2aUxikXeX7zGI3775h9J2Xh3TWj98JiijEbC45ZgS7pAwaavJUjm+/gEeFrVeA13Qkw1NqYPMpKBf74tXmO261wZdVxbircoUU7nESlh5YpZJSnZIe3E+24p2Ej1b0DehW5salW8Bc0haTbnhHHo726Ob2xzwwDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sk6BtzKVlkgLVhihG7MCdS/Sfu4W+Zd6An3GUlavgRNuSAxzMyzAROz9e6I/bzfpWdVzUk1dbFZRXshrPX3XUeQI5GcHbqdDTS61AZCcFg14lA4xRVz/LcvqrQPl6FTcs9Rlni0+NxKnnohtnkB9suXP+hM8IA9BD1zSpRhPoxw=
Received: by 10.78.185.15 with SMTP id i15mr358131huf.1177012264553;
        Thu, 19 Apr 2007 12:51:04 -0700 (PDT)
Received: by 10.78.131.7 with HTTP; Thu, 19 Apr 2007 12:51:04 -0700 (PDT)
In-Reply-To: <20070419170157.GF9101@fieldses.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45040>

On 4/19/07, J. Bruce Fields <bfields@fieldses.org> wrote:
> On Thu, Apr 19, 2007 at 12:07:01PM -0400, Nicolas Pitre wrote:
> > On Thu, 19 Apr 2007, J. Bruce Fields wrote:
> >
> > > It was a conscious decision to use a mixture of the two techniques; see,
> > > e.g.,
> > >
> > >     http://marc.info/?l=git&m=116994435503452&w=2
> > >
> > > and followups.
> >
> > Maybe it should be said more explicitly that both are fine.
>
> Yes.  If I were to do that I'd do it by first rewriting the DESCRIPTION
> section of git-config.txt to make this point clearer, then making sure
> there's a gitlink:git-config[1] everywhere there should be in the
> manual.  But we could also add a sentence in the manual here.

At least it should not overwrite the old contents of the file, as in
the above mail, tell to edit the file instead of the cat >~/.gitconfig
<<EOF structure.

Santi
