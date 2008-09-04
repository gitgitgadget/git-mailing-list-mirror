From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [GSoC] Git projects for Google Summer of Code 2008 final evaluation
Date: Fri, 5 Sep 2008 00:44:59 +0200
Message-ID: <bd6139dc0809041544o427356c9i40a28b1c182817eb@mail.gmail.com>
References: <200809042315.58898.jnareb@gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Sam Vilain" <sam@vilain.net>,
	"Joshua Roys" <roysjosh@gmail.com>,
	"David Symonds" <dsymonds@gmail.com>,
	"Lea Wiemann" <LeWiemann@gmail.com>,
	"John Hawley" <warthog19@eaglescrag.net>,
	"Marek Zawirski" <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Stephan Beyer" <s-beyer@gmx.net>,
	"Christian Couder" <chriscool@tuxfamily.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Junio Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 00:46:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbNah-0002ls-Ar
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 00:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034AbYIDWpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 18:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755143AbYIDWpJ
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 18:45:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:27675 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755034AbYIDWpA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 18:45:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so560022fgg.17
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 15:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mMvtub7CWVfz9wlOhW00cN+GOKDgY0ZUEbFTR4sG4Fw=;
        b=p8HrkJwhEDc/sBfrF1y7vloDXSAey5I6qS0qQp9905imYVTMS8sYOC0WnMD2jVmSVS
         tH8M3BOBdZz2MMF/FBWlCpwCcT8Ap3//OMLzdP+cgYSdIJVnK4TUzID+IAOZk8PhmVjp
         sn1YHbrwqN4nAOvUQU+32MI2D0j3Up25aTt1o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=Ryj4PksLChvz7hMQjBhikzljTwdVvXF8FpdjhecYFFs6vLpUIz2umDZYjNKDG01BHD
         Ry/7axMTD/vtLHKGAgsvI8M735lXJYyzZWgnd3+Z7Jo5ZiA0FGv29ke8cG+9jQ8wiynT
         zXLZIwrBBaPnP8tK4YF9EyKfWTbJPzJdD5eB8=
Received: by 10.187.168.2 with SMTP id v2mr2495405fao.23.1220568299091;
        Thu, 04 Sep 2008 15:44:59 -0700 (PDT)
Received: by 10.187.213.8 with HTTP; Thu, 4 Sep 2008 15:44:59 -0700 (PDT)
In-Reply-To: <200809042315.58898.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94969>

Heya,

Replying to:
> 2. git-statistics
>
> Student: Sverre Rabbelier
> Mentor: David Symonds

On Thu, Sep 4, 2008 at 23:15, Jakub Narebski <jnareb@gmail.com> wrote:
> So students and mentors, please write what do you think current status
> of project is: is it done, is it ready, is it perhaps already merged
> in, or can be merged in at any time.  Please write also what wasn't
> done, or what should be done different way (hindsight and all that).

I consider it a successfull project, although it might not be what
some hoped it would be, I am happy with it. I plan to submit it for
inclusion in /contrib in the near future. I hope to work on improving
move detection in git log when time allows.

> Students, could you please tell us if you plan to work on git further,
> and in what range (how much time can you get to work on git). What do
> you think about git development community? What have you learned from
> participating in GSoC?

I very much plan to continue development, now that my day-to-day life
seems to have stabilized (after being on vacaction to the USA for a
month). I enjoyed working with the git community, especially the 'real
time' help on #git has been very usefull!

-- 
Cheers,

Sverre Rabbelier
