From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sun, 14 Oct 2007 22:10:14 +0100
Message-ID: <e1dab3980710141410k23debb25mc578eed07c714f11@mail.gmail.com>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
	 <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com>
	 <Pine.LNX.4.64.0710130130380.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 23:10:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhAjE-0003VU-Nk
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 23:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759170AbXJNVKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 17:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759428AbXJNVKS
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 17:10:18 -0400
Received: from qb-out-0506.google.com ([72.14.204.229]:30213 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703AbXJNVKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 17:10:16 -0400
Received: by qb-out-0506.google.com with SMTP id e11so1697300qbe
        for <git@vger.kernel.org>; Sun, 14 Oct 2007 14:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ebMB+ZBSyamRBBfDSpiAT5Oa20LopfXlcaqKZr+8v34=;
        b=MWSHHe597Cr8cdvCmvW4j0dAV8Tt+hFD9ulXRYReUpctzEWHTEb4XVc94R0Cila3A88C8pVZNYsHk8SrPPjOPMhqtq4LsfrwhPcIcEUA18e/d1JACPpuQd+jNcHmwS5T87V1PTugjhQ9F6FAJf5clhyRUEMyYlGqiSQ7yPby0Qg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n7Gwz3TTz8zeTrqTyBwG2dfc6kSCTRc6RsGGQcZzRDlHTc/G5sn7HH6E2b2BoYaamJtKPRziTTlH/KjVbZJiM1qx3rrx328XfPD/qV63OLT3NPVm45ODn2Zs78qJDI/EfAzJk2/EygC8FdPU6PE4Xk9jHAP4gt1fGQyfXc9G/x0=
Received: by 10.64.150.18 with SMTP id x18mr11191632qbd.1192396214251;
        Sun, 14 Oct 2007 14:10:14 -0700 (PDT)
Received: by 10.65.81.12 with HTTP; Sun, 14 Oct 2007 14:10:14 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710130130380.25221@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60906>

On 10/13/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >    Figure out why people find git hard to learn and eliminate those
> >    barriers to entry.  Make git more task-oriented rather than
> >    data-model-oriented the way it is now.
>
> Frankly, expectations like these make me want to bang somebody's head on
> the wall.  Why do people expect others to work for them for free?  Hard?

Since no-one else has mentioned it, I -- and I suspect some others --
try to use the "beer round" model with FOSS. When I go out for drinks
with people from work, I don't try and keep a precisely tally of who
has bought a drink for me and so whom I shoud buy a drink, and worry
about what how the accounting changes if me or someone goes home
early. I generally take the view that all the imbalances will roughly
balance out over the future. Sure you keep an eye out for complete
freeloaders, but you don't get overexcited about a temporary
imbalance.

Likewise, I will sometimes make suggestions -- hopefully politely --
of various projects where my skills don't fit. (Eg, I'm not going to
add non-trivial features to the git shell scripts because I just don't
know non-trivial shell.) Hopefully some minor patch I've submitted
somewhere has, possibly through helping someone else who's helped
someone else.... , helped you some minuscule amount.

I'm perfectly fine with someone politely saying "no developers are
interested in this, so it won't happen if you don't implement it
yourself", but when you accuse people who just bring up a possible
feature of being free-loaders it makes them question whether other
projects would be more productive places to spend one's time.

It's the difference between being told "I suspect you'll have to do it
yourself" and "how dare you even ask that! do it yourself!".

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
