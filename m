From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cvsserver: suppress warnings
Date: Tue, 25 Jul 2006 23:50:03 +1200
Message-ID: <46a038f90607250450l643f97e4sbece300fa5b2d509@mail.gmail.com>
References: <Pine.LNX.4.63.0607251247040.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <44C5FB3E.9020301@catalyst.net.nz>
	 <Pine.LNX.4.63.0607251308380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>,
	git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jul 25 13:50:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5LQP-0007ry-Od
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 13:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWGYLuF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 07:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWGYLuF
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 07:50:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:39772 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932333AbWGYLuE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jul 2006 07:50:04 -0400
Received: by ug-out-1314.google.com with SMTP id m3so2638055ugc
        for <git@vger.kernel.org>; Tue, 25 Jul 2006 04:50:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I9hptFNryx8TlUyin9yjbrIxSvdd570dsFenmDJJ858tDKOthVuud9jg1qv/TozgXBSalQwzoxWq6oKyHMujY7MUftjhXGs5rwdLe+snk1Ckxyy/eFIdx1854C5mBXtJgKjAXEqPsvplNmCzaIpTPdtQS4AgkF9H7kAHSfYmqUM=
Received: by 10.78.151.3 with SMTP id y3mr2240405hud;
        Tue, 25 Jul 2006 04:50:03 -0700 (PDT)
Received: by 10.78.120.18 with HTTP; Tue, 25 Jul 2006 04:50:03 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607251308380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24168>

On 7/25/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> > Ack to that too. Perhaps an END block would help?
>
> Since my BASIC days on a VC-20 (no, not the airplane), I hardly used an
> END statement ;-) Well, maybe in that Pascal course, but not in Perl,
> anyway. So, I do not understand...

Oh, it's a code block you can declare that gets called when the
program is exiting. More info at
http://search.cpan.org/dist/perl/pod/perlmod.pod#BEGIN%2C_CHECK%2C_INIT_and_END____

No relation to BASIC's END ;-)


martin
