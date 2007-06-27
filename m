From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Darcs
Date: Wed, 27 Jun 2007 12:00:48 +1200
Message-ID: <46a038f90706261700g7b1791d7r5413d0b289421122@mail.gmail.com>
References: <cecbdd220706232232w77a609faxf0e6b2dc37f0d1f4@mail.gmail.com>
	 <alpine.LFD.0.98.0706241030540.3593@woody.linux-foundation.org>
	 <46a038f90706241345m4b5ecb80p9f4ec840993023e0@mail.gmail.com>
	 <7vlke9ouv8.fsf@assigned-by-dhcp.cox.net>
	 <61e816970706241638j60830741p2cd1a102a72ae226@mail.gmail.com>
	 <alpine.LFD.0.98.0706241657540.3593@woody.linux-foundation.org>
	 <61e816970706242144y5dd07464ue6b06478a5920699@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Bu Bacoo" <bubacoo@gmail.com>, git@vger.kernel.org
To: "Dan Chokola" <dan@chokola.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 02:00:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Kxp-0007q2-GK
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 02:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758805AbXF0AAu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 20:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758696AbXF0AAu
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 20:00:50 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:26810 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758668AbXF0AAs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 20:00:48 -0400
Received: by wx-out-0506.google.com with SMTP id s18so1698618wxc
        for <git@vger.kernel.org>; Tue, 26 Jun 2007 17:00:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fu2cG17qWSvnOgCuT4xvzUbaizkI8Z0KLzkIe7BGYfAbNcCmsXpxCMnqQKgmwvM8QJFfSx4flIpFnfMsuwBSF06nC9CH2+oGUmGAXqUpwnMk/I9Tsied1tOmduaB5wobBu6UrEhpxTZllMIzH2A5jELc3pHVElJMl8oaMHCdSSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VLvgQYC7CyZXbDZTxALGnkOFQvHmZOlZproIlKcSTKGz0d46ipwmolo2ZKRpSh5leK9gNs8DVLIV3VXw+7EL1KsQ9WH3qX929vnadCWRbydZ5Oc3pNohOi3kufcIo6hcQFdltmS+EVVUu+cYhSdOq4PL2sqGcgKz22DsO9lBTHw=
Received: by 10.90.34.3 with SMTP id h3mr6051704agh.1182902448421;
        Tue, 26 Jun 2007 17:00:48 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Tue, 26 Jun 2007 17:00:48 -0700 (PDT)
In-Reply-To: <61e816970706242144y5dd07464ue6b06478a5920699@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50989>

On 6/25/07, Dan Chokola <dan@chokola.com> wrote:
> So, relating back to the original post, and extending on Linus'
> 'academic' analogy, Darcs is like a thesis project from university
> that proves how DSCM can be done scientifically. Git is grown-up Darcs
> that proves how DSCM can be done practically.

I don't think it's like that. More like

 - BK showed it's done
 - Darcs picked some good bits from BK (while no other foss dscm did
until git/hg/bzr came along) but got distracted with interesting but
not-that-useful stuff - see patch algebra.

cheers,


m
