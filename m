From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Introduction and Wikipedia and Git Blame
Date: Fri, 16 Oct 2009 13:38:20 +0200
Message-ID: <46a038f90910160438y4acbab9fy1bfb579bd9a067d6@mail.gmail.com>
References: <ee9cc730910160207x49feb40ej692188abb0a57473@mail.gmail.com>
	 <alpine.DEB.1.00.0910161321550.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "jamesmikedupont@googlemail.com" <jamesmikedupont@googlemail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 16 13:39:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myl9j-0006lq-6s
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 13:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758831AbZJPLi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 07:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758812AbZJPLi6
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 07:38:58 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:50111 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758799AbZJPLi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 07:38:57 -0400
Received: by ewy4 with SMTP id 4so1477825ewy.37
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 04:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=TE75crkrbUl81jPaFjwPN0wvh1pLNo4r0V7OJ8107zc=;
        b=J2kmRsCVQx4zRHFMgnH7hLSaqJu9JLUswY+NEM0pM8KnnNf986ir+fe4MTXEMEA68v
         qasdz6GX0WOHWDemS9AkpwoxdVPmk/5Vv5gRhBo+/KSBF9P/ThPzdki5ZkvgJ0Zv3PhN
         WnVZB4KrbRxEYw8Y7/ALk7Bu/UFifEPzZURuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=GxwyxcAzGNPJnMX/vBLZb/yj7tSpI7z+9yItLX3NPy642jEqrzW+PXvyV2XS+n+803
         DZ7LMoL334HAdhEKFppB8hX8mNGRiotFccH7nh7+1/l5yzV6BTRksRziXUnH95reSZpB
         +KQeohpm25UQAamHqH7bPC9+MiBfK3TvTOZT8=
Received: by 10.211.158.8 with SMTP id k8mr775692ebo.98.1255693100587; Fri, 16 
	Oct 2009 04:38:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0910161321550.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130479>

On Fri, Oct 16, 2009 at 1:26 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> I am not quite sure what you want to do horizontally there... Can you
> explain what you want to see?

Highlight the changed bits on the line. Example - the red-bold highlight in:

http://en.wikipedia.org/w/index.php?title=David_Letterman&action=historysubmit&diff=320061135&oldid=320060840


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
