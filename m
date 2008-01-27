From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: I'm a total push-over..
Date: Sun, 27 Jan 2008 17:48:50 +0300
Message-ID: <20080127144850.GJ26664@dpotapov.dyndns.org>
References: <e51f66da0801240519u4c8e6ddfrb7af8df34552252a@mail.gmail.com> <4798B633.8040606@op5.se> <37fcd2780801240828vac82e6ds4da5aecde56e8d2f@mail.gmail.com> <alpine.LFD.1.00.0801240839590.2803@woody.linux-foundation.org> <e51f66da0801251252r1950c2d5g12caa5e71b9a37a@mail.gmail.com> <alpine.LFD.1.00.0801251407010.5056@hp.linux-foundation.org> <e51f66da0801260416p5f5ffb98w16fe832fe62dc7c9@mail.gmail.com> <alpine.LFD.1.00.0801262247140.3222@www.l.google.com> <20080127082128.GH26664@dpotapov.dyndns.org> <alpine.LSU.1.00.0801271406130.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Marko Kreen <markokr@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 27 15:49:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJ8pO-00037H-IT
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 15:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbYA0OtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 09:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753571AbYA0OtD
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 09:49:03 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:13052 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbYA0OtB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 09:49:01 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1348225fga.17
        for <git@vger.kernel.org>; Sun, 27 Jan 2008 06:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=Mb/7JITfGjiiWqulgivGVAcNFrFEuQeoF8NJSpUTySY=;
        b=xUfoRh3QtU7txYSqbVZudS2srnExm/QzoPH1PeVz22Y5ZQ/rhD1Me8zLEDgswJb8SW5cqGxkgQyvZUQwFQnpY7y0cY0CnBW6vUUrr7Q9NyTbz5TRmTFzOTpQ61bEhp/P6IBQU6E/BlFHrbjN/f+OIM6bHCnPYrqcvJ9K4fDwtdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=omwRQH274FWuwJJgEOPe4+15m1JvHfmN/2oXlVDFjX2l6JXvBCpaAHwH9ZosuYf3DtKxncOGA/VFotEufu65jOHrEI9zJfhyhXul41eol+LqVcaKXkVExPj0cewoG1fffwQXsSKapWEQj3IP5eJNGmuxnjI6MoM+riGRhOET9TM=
Received: by 10.86.59.2 with SMTP id h2mr4133861fga.78.1201445335306;
        Sun, 27 Jan 2008 06:48:55 -0800 (PST)
Received: from localhost ( [85.141.188.123])
        by mx.google.com with ESMTPS id l19sm6630278fgb.9.2008.01.27.06.48.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Jan 2008 06:48:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801271406130.23907@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71817>

Hi,

On Sun, Jan 27, 2008 at 02:07:25PM +0000, Johannes Schindelin wrote:
> 
> 
> <irony>Oh yes, let's take this one, it is so much shorter, cleaner and 
> overall more elegant than Linus' code.</irony>

I am not sure what you meant by that, and what exactly code you meant
saying Linus' code....

Anyway, my point was that mixing both steps together does not look very
nice, and the code was intended to demonstrate why.

Dmitry
