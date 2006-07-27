From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Licensing and the library version of git
Date: Thu, 27 Jul 2006 13:47:24 -0400
Message-ID: <9e4733910607271047r57fe0aa3hf29b4b9244c02f2c@mail.gmail.com>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com>
	 <20060727114105.GZ13776@pasky.or.cz>
	 <Pine.LNX.4.63.0607271400160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com>
	 <20060727131127.GA13776@pasky.or.cz>
	 <9e4733910607270911p50d25d97w1a898fc7a9119e7d@mail.gmail.com>
	 <Pine.LNX.4.64.0607270936200.4168@g5.osdl.org>
	 <Pine.LNX.4.64.0607270941400.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 19:47:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G69xQ-0000Gj-Fi
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 19:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbWG0Rr1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 13:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbWG0Rr1
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 13:47:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:18205 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751895AbWG0Rr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jul 2006 13:47:26 -0400
Received: by ug-out-1314.google.com with SMTP id m3so395660ugc
        for <git@vger.kernel.org>; Thu, 27 Jul 2006 10:47:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C+m2xL2JA+6ifS3o35DyZnxMAcHRF685E/Rf3MzCLS0eA13uPIA1faoyp9Ov5u3JmnSuzEAbHE8NOKXG5dt5yTjNe+19MosKtU2VzRFiGZkTaDnwRz8eAlhnMIZkV7U+wVxpXrDKpcwTUr2A4OzuhtJ4wDdPE9nVxmOXzDRNLOI=
Received: by 10.78.165.16 with SMTP id n16mr4393973hue;
        Thu, 27 Jul 2006 10:47:25 -0700 (PDT)
Received: by 10.78.149.8 with HTTP; Thu, 27 Jul 2006 10:47:24 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607270941400.4168@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24324>

On 7/27/06, Linus Torvalds <torvalds@osdl.org> wrote:
> I seriously doubt that Eclipse or Visual Stupido could ever actually
> _understand_ what git does, so the only parts you actually would want to
> use for those is literally the trivial stuff - the "look up objects" and
> "generate commits" part.

Typically an integrated IDE can move, delete, rename directories and
files. Get a log. Push, pull and commit. Revert a change. Generate
diffs to previous versions.

-- 
Jon Smirl
jonsmirl@gmail.com
