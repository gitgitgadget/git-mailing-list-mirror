From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git: relicensing test-lib.sh from GPLv2 to GPLv2+
Date: Fri, 2 Apr 2010 02:43:26 -0500
Message-ID: <20100402074326.GA4112@progeny.tock>
References: <87r5oqe7mi.fsf@yoom.home.cworth.org>
 <871vgmki4f.fsf@steelpick.localdomain>
 <7vaav8hpfo.fsf@alter.siamese.dyndns.org>
 <87tytdiqob.fsf@steelpick.localdomain>
 <alpine.DEB.1.00.1002191138280.20986@pacific.mpi-cbg.de>
 <873a0xhwxs.fsf@yoom.home.cworth.org>
 <alpine.DEB.1.00.1002192204050.20986@pacific.mpi-cbg.de>
 <87eikfhec1.fsf@yoom.home.cworth.org>
 <alpine.DEB.1.00.1002202321430.20986@pacific.mpi-cbg.de>
 <87pr2i8g8o.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Fri Apr 02 09:43:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxbXa-00047e-Qz
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 09:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759313Ab0DBHnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 03:43:32 -0400
Received: from mail-gx0-f209.google.com ([209.85.217.209]:33923 "EHLO
	mail-gx0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759297Ab0DBHna (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 03:43:30 -0400
X-Greylist: delayed 104907 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Apr 2010 03:43:30 EDT
Received: by gxk1 with SMTP id 1so1498850gxk.16
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 00:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=z8FNr6Dz7vufmKo+AD22ar0R1H/gCmwm8pJEoYZMmL0=;
        b=KY4nKCSpmpdFmeeMvXFOdAu11Pc8QbvRdJN0483XMh3D2D2GJO1vUmpfWQ9O+Mw02K
         pOtLzSEJeMUSo4GKrYndB21n8rHRvK54BnEOJYq+IBFxdynWIC4x8ZhdaXHhfbgvCMQf
         2aEHAahmrG1z3OJ9LqBMH4242kfIsBPvi7aBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=n17ou/f5TcrOjzbkD/LjaffLIZtCJRgRFir62OPdh8rnPvTS1lUAC2iGvBV9DvBP19
         cvHxxUZ/vVn4e6jOWaJ0b5ZGJgX1ZxNBq4XL6UIuv+ou68+ixiB+zwwCcqXlooNypOrS
         GdTaFiVdsSOGP8Rr0UfL0PjbXkpX9EJM+yN6Q=
Received: by 10.90.39.6 with SMTP id m6mr2143523agm.49.1270194209344;
        Fri, 02 Apr 2010 00:43:29 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm7929492iwn.0.2010.04.02.00.43.28
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 02 Apr 2010 00:43:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87pr2i8g8o.fsf@steelpick.2x.cz>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143789>

Hi Michal,

I am happy for anyone to use, modify, distribute, and relicense my
meagre contribution to t/test-lib.sh in any way they please.

In particular: yes, I agree to relicense all my contributions to
test-lib.sh to GPLv2+ with the addition of the "or any later version"
clause.

Thanks,
Jonathan
