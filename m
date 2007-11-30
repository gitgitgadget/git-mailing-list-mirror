From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC] git-gui USer's Survey 2007 (was: If you would write git from scratch now, what would you change?)
Date: Fri, 30 Nov 2007 19:25:27 +0100
Message-ID: <e5bfff550711301025y21e7149bga39fa61ceef854cf@mail.gmail.com>
References: <20071127012013.GG14735@spearce.org>
	 <20071127015833.GL14735@spearce.org>
	 <Pine.LNX.4.64.0711271136050.27959@racer.site>
	 <fiib19$dj6$1@ger.gmane.org>
	 <Pine.LNX.4.64.0711281225150.27959@racer.site>
	 <20071128232523.GE9174@efreet.light.src>
	 <Pine.LNX.4.64.0711282345500.27959@racer.site>
	 <20071129065706.GA24070@efreet.light.src>
	 <Pine.LNX.4.64.0711291200000.27959@racer.site>
	 <20071130175018.GB30048@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Nov 30 19:25:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyAYf-00022z-Ac
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 19:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758270AbXK3SZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 13:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758162AbXK3SZ3
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 13:25:29 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:56610 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757587AbXK3SZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 13:25:28 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2002864rvb
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 10:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ShPQlHFi1O3OHNaQgn3L+Q4rqAKG58COZcVpiRes8cw=;
        b=G0mnO9VHRGWVxYxzCVqlzI72mmNjY8TS1Qj985vBoQhOXNJlOe0W4bT2ieOBWh3L5C6GPBNw9+ur1A5WDdF2zI72ChdzjDmlik5io6gm7IRFTNij6U+SYkXlAegSpkQoqJZhQuw+6AQ14I4RO8CzH4PP7K8jSZlkNZDEYemaNGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FMPZ2OKNsz5y0vS31EM11Farw0kDdevzVyiBVSSrj++HqXggB78QcRL6X9sOm/OgOtcnzCJcOotsM5hnrtehx7tTkM4bWKfLw7xtCTxZ59ixpL1rwLHcLBALAe9MxXSoJXiwME9Jpec3Zbep3NA6SP+WHFeJ73cKEosZES/2Vis=
Received: by 10.141.98.13 with SMTP id a13mr997753rvm.1196447127957;
        Fri, 30 Nov 2007 10:25:27 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Fri, 30 Nov 2007 10:25:27 -0800 (PST)
In-Reply-To: <20071130175018.GB30048@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66653>

On Nov 30, 2007 6:50 PM, Jan Hudec <bulb@ucw.cz> wrote:
>
> Nevertheless, I actually think git-gui is quite well in Tcl/Tk and rewriting
> it in python nor any other language would probably help it in any way.
>

A little provocation: I've never seen in open source a discussion on
what language to use for an application and then the development of
the application from scratch.

What I see daily instead is the effort of one (or a very little number
of people) to develop something in the language he choose and then ,
_after_ some code has been produced, the effort embraced by other
people that join the project.

Some near examples? gitk, gitweb, stgit, git itself especially for
shell parts (why shell should be a better prototyping language then
other prototyping languages? portability? easy to learn? performance?
library support? syntax? probably no one of the above in general
terms).

I would say this thread, although very interesting from a learning
point of view, it's a a little bit academic.


Marco
