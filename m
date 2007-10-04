From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Question about "git commit -a"
Date: Fri, 5 Oct 2007 04:16:20 +0700
Message-ID: <fcaeb9bf0710041416n60c94922k99501d3f1e432b79@mail.gmail.com>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>
	 <545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com>
	 <fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com>
	 <Pine.LNX.4.64.0710042209410.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Wincent Colaiuta" <win@wincent.com>,
	"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:16:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdY3b-0003Oy-HE
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 23:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757504AbXJDVQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 17:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756464AbXJDVQW
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 17:16:22 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:41133 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316AbXJDVQV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 17:16:21 -0400
Received: by py-out-1112.google.com with SMTP id u77so590187pyb
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 14:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=hrruwJhPBpVqxao49ZhHtjLipf3JFRYVuT6sYC/SdOc=;
        b=TJqo0juo/orm/HEhDDSYkYvmC7cNXmhA9Dtcgk7Oqb/4OpV9Rx0Oy0djyF525jJwLin1c09JdUW6/LAa/nvOTltZrSzZQBfb8ze4pCI4llHTNu4P48ce0UrAgYxWbMqbFrtOJU1i4AN2KsjDJaJ/m5fjjq0X3h+1K7OSe5PGAqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D9L+Iv9qcymYg6jTNbtVxEChgDzXozDUZ9OXUfb/2HSV0ICr+ZMJUlu19OWKlIYQimQg6IpKsomkB36BT/g43tudJ2fqzh+CymkmnbKTRfKylo8eXxTpKnaz/N42Pdr2KWnOfc7b5lRFOubwK5VUco7kCe439I0WcJfZ2aXsOJA=
Received: by 10.65.214.2 with SMTP id r2mr16679575qbq.1191532580155;
        Thu, 04 Oct 2007 14:16:20 -0700 (PDT)
Received: by 10.64.24.18 with HTTP; Thu, 4 Oct 2007 14:16:20 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710042209410.4174@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60008>

On 10/5/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 5 Oct 2007, Nguyen Thai Ngoc Duy wrote:
>
> > On 10/4/07, Wincent Colaiuta <win@wincent.com> wrote:
> > > > Am I wrong?
> > >
> > > About it being a majority, yes, I suspect so.
> > >
> >
> > Maybe in the next survey we should include question "do you usually do
> > 'git commit' or 'git commit -a'" :-)
>
> Not meaning to discourage you, but it is a known fact that Linus does "git
> commit" without "-a" quite often.
>
> And if that were not bad enough for your plan, I myself omit "-a"
> regularly.  So you would get a veto from me, too.

I obviously forgot to mention I do use git-commit without -a. I just
wanted to know which way the real majority of git users prefers.
-- 
Duy
