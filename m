From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: RFC: Website redesign
Date: Mon, 14 Apr 2008 20:29:00 +0200
Message-ID: <bd6139dc0804141129h25c829e2i320f227594763d71@mail.gmail.com>
References: <3175605f-ff32-4fd6-bed3-7ae596ecbcde@q1g2000prf.googlegroups.com>
	 <2c6b72b30804140656g14c24d8cwae016d62fe12f4a7@mail.gmail.com>
	 <56e37551-4b8f-4164-a71d-79dba8635b7d@l28g2000prd.googlegroups.com>
	 <96F7571C-1D9D-4F0A-99F1-A2307DAB0374@wincent.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Dill <sarpulhu@gmail.com>, "Git Mailing List" <git@vger.kernel.org>
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 20:35:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlTRG-0004n0-M3
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 20:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762363AbYDNS3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 14:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761040AbYDNS3D
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 14:29:03 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:43340 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760136AbYDNS3B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 14:29:01 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1623708wff.4
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Ir1fHzITx1I5S2NDAqgiQt49Nb3IyF3H8e7UXqf4FDw=;
        b=tvMI6wWWSkFcUukSk6F5eQJWPe6JfCwuzMNcUFNF7v7MdpV5BI6QROkVja/Kc6rJwzkNuZeHvCcbrCssxSaRrVceiDGNQYNqP/6718gcnd3VFNpkIp60ey3Ldo/YF4We/K+F9zrrP/iAYtF2AGtyWLrUvK/+YmbNZqiya6yQxn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o4fGv8XNETN4qvvh5y+HqM4qoEQAMl7NjqBay8jCPzLT9pHuOsc8ILuLNMFG3d13GpDavUyDQdiE94qL+vHoZhs+QzFKsBAotHuQvgFB6qordpVCq4O1s5SSi86ltcc8iQkKt2KG3b3F+rVB02OdleHWFgev23tq1bpepEeBXIQ=
Received: by 10.142.87.7 with SMTP id k7mr1920647wfb.167.1208197740603;
        Mon, 14 Apr 2008 11:29:00 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Mon, 14 Apr 2008 11:29:00 -0700 (PDT)
In-Reply-To: <96F7571C-1D9D-4F0A-99F1-A2307DAB0374@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79523>

On Mon, Apr 14, 2008 at 7:03 PM, Wincent Colaiuta <win@wincent.com> wrote:
>  With all due respect, all of the designs you've posted look like _weblog_
> templates, and that doesn't seem appropriate to me for a software website.
> One of the things I most dislike about the weblog format is the fixed-width
> centre column and the large tracks of wasted space down the sides; although
> the official site is certainly "bare bones" (some would say "ugly") at the
> moment, at least the information density is high and there isn't any wasted
> space.

That is most probably due to that the templates googlepages offer are
mostly aimed at such weblogs. I think the suggestions are not just for
layout but also for color (which is very important, to me at least,
when deciding whether a webpage is 'damn ugly' or 'quite nice').

Also I think that the main page should not contain more information
than fits in one 'screen'. That is, there should be no scrollbar on
'sensible' (say, above 1024*768) resolutions. To me a site feels
'overfull' if it's mainpage has a scrolbarr. Instead, I think the
mainpage should be a portal to other parts of the website, instead
of... well... everything-crammed-on-one-page-so that.... so that what?
What purpose does it serve to put all information, ungrouped, not easy
to find, and as such chaotic, on one page?

Anyway... </rant>

Cheers,

Sverre Rabbelier
