From: Francesco Pretto <ceztkoml@gmail.com>
Subject: Re: [PATCH] Documentation: enhanced "git for CVS users" doc about
 shared repositories
Date: Wed, 07 Nov 2007 02:10:34 +0100
Message-ID: <4731108A.20603@gmail.com>
References: <472F99F8.4010904@gmail.com> <7v8x5cmern.fsf@gitster.siamese.dyndns.org> <4730E056.7080809@gmail.com> <7vd4unez2l.fsf@gitster.siamese.dyndns.org> <47310ACF.4030103@gmail.com> <Pine.LNX.4.64.0711070053320.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 02:11:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpZRZ-0005Pw-HW
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 02:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085AbXKGBKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 20:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754990AbXKGBKl
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 20:10:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:60149 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774AbXKGBKk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 20:10:40 -0500
Received: by ug-out-1314.google.com with SMTP id z38so51261ugc
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 17:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=rfkdTj3POXR5I5Jlj4dwU40+kTuBcXKbah20uBVY8Zs=;
        b=TjeoVhRre6UQwka+I5i0j9ks0TXM/2yIB/iSjUoGH8in/f85SpJ5J0LEsxGQYv5+t9HyIVdvkkBwF1/y0yByzn6t5OI1ra04LJQqSXoHdIhMANE4m8nOLDkTFgggyciIl36AFw11BThzxJ3R+QsvIWrCTV8XD8bBciNGtb3tTXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=lXQt7TXpnL7Uc7swVz8MZpubsNTZ49jbrU4Qgd107xswNIdK6qh9/WDSXHUG3YpbVvvQGF8gjMbeG7Gim9RdymW2gVVO4HsJ6O3nh95FEkZcFT7tCBZYA67wulgMrPADJMh23A1UagP3w92OeZucJA5vqjXTlp0XIPBjNgPWJKQ=
Received: by 10.66.217.6 with SMTP id p6mr267663ugg.1194397839255;
        Tue, 06 Nov 2007 17:10:39 -0800 (PST)
Received: from ?192.168.1.14? ( [87.0.185.143])
        by mx.google.com with ESMTPS id 34sm190076ugh.2007.11.06.17.10.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Nov 2007 17:10:37 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <Pine.LNX.4.64.0711070053320.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63762>

Johannes Schindelin ha scritto:
> Remember, those who read "git for CVS users" are _unwilling_ to spend the 
> time reading git documentation (at least for the most part).  If they 
> encounter something which is not useful to them, they will not just ignore 
> it, they will stop reading.
>

That's document isn't for CVS users only. It's referred on the "Git User's Manual"
speaking about shared repositories in general. I hope you agree that the time to
make your eyes jump a little below is less than the time spent googling around
if you don't find what you are looking for.
