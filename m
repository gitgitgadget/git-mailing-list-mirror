From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [Feature Request] Download transfer rate display
Date: Wed, 25 Apr 2007 10:40:47 +0200
Message-ID: <81b0412b0704250140h773a0cf0na0e393f2ca56f0e5@mail.gmail.com>
References: <1177489402.12689.42.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Tim Ansell" <mithro@mithis.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 10:40:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgd3U-0000KS-4U
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 10:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423299AbXDYIkt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 04:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423298AbXDYIkt
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 04:40:49 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:60892 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423299AbXDYIks (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 04:40:48 -0400
Received: by wx-out-0506.google.com with SMTP id h31so163330wxd
        for <git@vger.kernel.org>; Wed, 25 Apr 2007 01:40:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o4gCGPamMIF4yM2p5GjNsZbdAgK/k4Sr+wkpqu43kL55yMN73Snlcz3rfaWzRjaGYZnUdpOJK6s9fRmLqCVZu/5pO6yKzZxvEPwFHXBjcHJ8JfCHWSQ/nGDoykFqbHe0d7c2sg8698zBxgZyuiEB2iFPF4CZHppYI/K4wlH0EZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XQwp9g0kampfoNuotg+INfJhrZGqYDlXMUmJfskVMWLcaGvEjt5BSm7BsK073bMRomTmi2AD3GagJjmSj2+4611N/xHJx8r27VURVGUbdTyIM5OtmCiCzu70vBrGNrOsJNip2VDt+fRBiX/x5YeyTztNCFa+9aN7E2u+A+dZIhU=
Received: by 10.70.75.14 with SMTP id x14mr612428wxa.1177490447369;
        Wed, 25 Apr 2007 01:40:47 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Wed, 25 Apr 2007 01:40:47 -0700 (PDT)
In-Reply-To: <1177489402.12689.42.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45512>

On 4/25/07, Tim Ansell <mithro@mithis.com> wrote:
> It would be nice if when downloading git could report the download
> progress (a kb/sec would be really cool). I can understand this probably
> isn't a high priority as most of you wouldn't have this situation, I
> just thought I would throw it out there. (I may even have a crack when I
> am a bit less busy.)

Added it to wishlist (http://git.or.cz/gitwiki/Wishlist)
