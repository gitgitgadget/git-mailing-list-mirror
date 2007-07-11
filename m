From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: mtimes of working files
Date: Wed, 11 Jul 2007 21:36:25 +0300
Message-ID: <f36b08ee0707111136t198cf559vc85c561decf9707f@mail.gmail.com>
References: <f36b08ee0707110808h56ecbc7at9c92727c01cca508@mail.gmail.com>
	 <Pine.LNX.4.64.0707111902040.4516@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 11 20:36:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8h3C-0004fg-3m
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 20:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbXGKSg1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 14:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbXGKSg1
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 14:36:27 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:4446 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765540AbXGKSg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 14:36:26 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1439378nze
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 11:36:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wd5qhbUInBt9ZcghEOttESUZCOMpP/snn5p+lkUXCNObWkggWQM5arRCqV+8eZ6Y3nyDxvDh+xTAkCDaSm4ir7Bs0T7MA1qUFHEzQj8ezr6/QgXFnK6zgeRt/ivZtGlQeX0cXGYcfTDxyGtUYZAH416KLqrF83kSAXExuGsdh0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sW+zE4skBxPbGbxjxBDS78K4raulywE1V2xrRE7C/eZUoAD15Br3A0ooftoZLvhDPfLozw/dPkB2za3YEdVFm9IY7if22DfDj0rCAq/eRPc8qi0F//qJSnKokdNAo5/dlVmDmChGhg/AYCYHxS+rEtKMDsGQbYdmr53cALCBsnI=
Received: by 10.143.160.1 with SMTP id m1mr430174wfo.1184178985036;
        Wed, 11 Jul 2007 11:36:25 -0700 (PDT)
Received: by 10.142.116.4 with HTTP; Wed, 11 Jul 2007 11:36:25 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707111902040.4516@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52184>

On 7/11/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 11 Jul 2007, Yakov Lerner wrote:
>
> > How difficult is it to have script (or maybe existing git option) that
> > would make mtimes of all working files equal to time of last commit ?
>
> I wonder if there was a secret alien invasion three days ago, with an evil
> mental virus weapon?  It seems that this question has been asked three
> times in the last three days, twice on IRC, and once here.
>
> So now, I really, really, really, (repeat that 97 more times in your head,
> please) want to know why?
>
> There must be some super uber-cool application of that, that people
> _insist_ on having it.  And I do not want to be left out.

I gave you my reason on IRC, you ignored it. And you continued with
"You must defend your reason. Until you defend your reason, I do not give
you the solution, although I know it". That sounded rude. If you are *curious*,
try to speak not from position of "punishing authority", but as curious people
would normally speak.

> P.S.: I know how to do it, too.  And no, it does not help to try insulting
> me (unsuccessfully), even in a private chat.

If modifying mtimes of working file breaks the git, you should have
mentioned that.

I think  it does not break anything in git.  If this is so you should
have said so
and to give the solution (which you said you know).  I am lost in guesses
as to what makes you keep your monopolistic solution secret.
Hope I can figure it without you.

In the chat, you told me that you know the answer but won't tell me.

I have to tell you that demanding from me that I tell you why other
people asked this, and to withhold the answer on the ground that
I must mind-read them and tell you their mind ... I think this is stupid
attitude on yous part.

Yakov
