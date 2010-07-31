From: Benson Margulies <bimargulies@gmail.com>
Subject: Re: On MacOS, 1.7.2, git svn clone seems to fail silently
Date: Fri, 30 Jul 2010 21:40:01 -0400
Message-ID: <AANLkTik02SXQNi8+-rrkT+Az8h=oP9MAVNCTbZJ1ksDK@mail.gmail.com>
References: <AANLkTimxqC3oax=Q0EppAb-Q7AzHshRkV=H=6dJDNhqY@mail.gmail.com>
	<20100731013509.GG5817@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 03:40:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of13a-0008LI-CB
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 03:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377Ab0GaBkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 21:40:04 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50532 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360Ab0GaBkD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 21:40:03 -0400
Received: by wyb39 with SMTP id 39so1742067wyb.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 18:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=039nm67c931UfMw42F64NmdvGMAF3uNSml/p0Sv/YjY=;
        b=Q2TEhwFs+3d5V8ekkCYO3iBwVjZwCQ35/2aObJviWPK7jmDeCT3JdVTcAraJWnhu0I
         YlFzGJeYIKisC+yfK0PqiGsI9QMyURsabY0p26j37RnLWzHKOYqoNJIaZHktA780odBs
         AtVVwjQelTWzaYPFftNssbYBgV3voM0++/YzY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=AMBA5+PQEkD1r3PpsMCvdBZzt4ulfKir+ugm7ZOh5eSh1mt3thO5R9WYSxEceOeMNb
         Os5Thx8zhAzuNancMFgtpOKJd05LJKKtclvEwHch7GxBRnnGXQMydAYyOOrKb9WBwnUR
         b5ZX5qeGCmA1XiFGmfr9aehIbKZctJH1cAe7Y=
Received: by 10.216.178.146 with SMTP id f18mr2313919wem.101.1280540401429; 
	Fri, 30 Jul 2010 18:40:01 -0700 (PDT)
Received: by 10.216.155.17 with HTTP; Fri, 30 Jul 2010 18:40:01 -0700 (PDT)
In-Reply-To: <20100731013509.GG5817@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152284>

I didn't realize that this email was the same as the gmane group and I
thus made an unhelpful reply to the other thread you pointed me at. I
apologize for the noise.
