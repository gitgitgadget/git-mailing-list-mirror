From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: clone from url with email address as username?(escaping @ symbol)
Date: Tue, 29 Sep 2009 16:25:58 +0200
Message-ID: <fabb9a1e0909290725w616c3ea9vcb1d2c53950f7788@mail.gmail.com>
References: <970bc7c80909290720i1c5566fer1c1a3db744edc609@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ben Bennett <benbennett@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 16:26:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Msdeq-0001A3-Nb
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 16:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbZI2O0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 10:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbZI2O0P
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 10:26:15 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:40510 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbZI2O0P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 10:26:15 -0400
Received: by ewy7 with SMTP id 7so5460695ewy.17
        for <git@vger.kernel.org>; Tue, 29 Sep 2009 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=ZDafqFEHpoJRqM2f7wvO5CpynsmHjoNtQbwYmzcKp/Q=;
        b=OA3cUMVj+mBZj5ar+jmHvpigWy4DT1kn6m2yDxGPtFwD828E6M6De+JGfbLBgS9IW1
         yqMpuQYy4KcvqVz6VpdDT7p0xteRnJ3Ndd8D2uUeKufsvT3mqoFuE5LdmbdJi05VIOQz
         LXTAFeeedUbjXb4lv7Kg4PkRGCoxGgoO99I4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=YfU7L8GCzUUaMzCiLOZ3A+2nZq7E21zerxebn+hgCE+HeWuC/E93Z/y51nLmtBujok
         0k5PpP66IVP3fXhLYLMyU1IxQrmFU3k+ruGhw9E8Twytbu+sETXvgDEj34SRNbUxSK9E
         kGGRYO84BciF531WpMJ3VAYxDYafhTpVCdYrM=
Received: by 10.216.86.213 with SMTP id w63mr1029476wee.71.1254234378106; Tue, 
	29 Sep 2009 07:26:18 -0700 (PDT)
In-Reply-To: <970bc7c80909290720i1c5566fer1c1a3db744edc609@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129305>

Heya,

On Tue, Sep 29, 2009 at 16:20, Ben Bennett <benbennett@gmail.com> wrote:
> Is there any escape sequence for the @ symbol when cloning?

I thought @ is not allowed to be in an url? What do you need to escape it for?

-- 
Cheers,

Sverre Rabbelier
