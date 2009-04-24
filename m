From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Thu, 23 Apr 2009 19:30:56 -0500
Message-ID: <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com>
References: <m24owgqy0j.fsf@boostpro.com>
	 <20090423201636.GD3056@coredump.intra.peff.net>
	 <D912CAB9-E437-4733-8A87-97EE47E3FBBB@boostpro.com>
	 <200904240051.46233.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Abrahams <dave@boostpro.com>,
	Jeff King <peff@peff.net>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 02:32:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx9LH-0001B2-0K
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 02:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbZDXAa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 20:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbZDXAa6
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 20:30:58 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:21785 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbZDXAa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 20:30:58 -0400
Received: by qw-out-2122.google.com with SMTP id 5so708359qwd.37
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 17:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CkKGLOEXhSndVvwGK+kess9uYlkXpBUF+Gkrr4zQLdg=;
        b=Fq9aS2daIGq7oQiMO+R+ocypN1FJ1xrLRgLYKlgUuwaaeymZVE0LIY6Ym6bS+NeITx
         wuC7da77ApfXXfiw2PHOiatyUeyPZrAUtTL4GeatCnToSNdiytpIySQB/M1xsHMtBOYY
         Ou2Al49Q23nhIp78yImOFytex6zL/Kou/+LO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qs6Ls6RZQ7L5xybv2TVbtqjW1Rv5emnJvmFT+FafLNBNHJ1J5NTjnWTP+i+/9PnDRa
         2w0z3SotJJsZOzfXJIXaFwUbO2G2khR3hSrBJNlHrKY51uVmETaFrLw4n5TwHK6rXvjv
         0RcYPzL4kHcOfkXBddZefjJcMbsliQvMxNbj4=
Received: by 10.224.67.78 with SMTP id q14mr2170492qai.162.1240533056932; Thu, 
	23 Apr 2009 17:30:56 -0700 (PDT)
In-Reply-To: <200904240051.46233.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117399>

On Thu, Apr 23, 2009 at 17:51, Johan Herland <johan@herland.net> wrote:
> On Thursday 23 April 2009, David Abrahams wrote:
>> On Apr 23, 2009, at 4:16 PM, Jeff King wrote:
>> > There are some "bottom-up" resources available, but I haven't seen one
>> > pointed to as "definitive".
>> I've been pointed at:
>>
>> 1. http://eagain.net/articles/git-for-computer-scientists
>> 2. http://www.newartisans.com/2008/04/git-from-the-bottom-up.html
>
> There's also http://www.eecs.harvard.edu/~cduan/technical/git/ which I think
> is a great bottom-up introduction:
> - not too heavy on the concepts

I really don't understand this mentality. Concepts are the only things
that are important. From concepts falls all else.
