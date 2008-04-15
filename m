From: "Steve Hoelzer" <shoelzer@gmail.com>
Subject: Re: Git Homepge Update
Date: Tue, 15 Apr 2008 12:57:59 -0500
Message-ID: <588192970804151057pc87b73fvee9eb8a47b1d4e78@mail.gmail.com>
References: <2c6b72b30804140656g14c24d8cwae016d62fe12f4a7@mail.gmail.com>
	 <96F7571C-1D9D-4F0A-99F1-A2307DAB0374@wincent.com>
	 <bd6139dc0804141129h25c829e2i320f227594763d71@mail.gmail.com>
	 <pan.2008.04.14.20.39.10@progsoc.org>
	 <20080414213339.GB10300@dpotapov.dyndns.org>
	 <pan.2008.04.15.03.25.00@progsoc.org>
	 <8607f754-92c8-49ca-9bc9-11e58b66ef40@q1g2000prf.googlegroups.com>
	 <acfbfe5b-f3a1-4c22-a873-ed329552d1bb@b5g2000pri.googlegroups.com>
	 <20080415115741.GB26302@machine.or.cz>
	 <20080415162008.GD26302@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Petr Baudis" <pasky@suse.cz>, Dill <sarpulhu@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 15 20:12:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlpQf-000412-DR
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 19:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbYDOR6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 13:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbYDOR6D
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 13:58:03 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:7429 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbYDOR6B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 13:58:01 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2079803fgb.17
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=r3H9Qwk97yKNBIsdCDfrhuiPXx7ggGbOz1JqaE/Lnuk=;
        b=pXXcfOrH1n3PBfEHbUhgJB9gS8OqVxKZ36CUgIkhI2+5IUiWJ/tQ8tLpA1jktLbgY6PI/pgLmDmkROawk1GPN3AwRicYLds7r5xsN4nGkWGDdsXUXrolOpQLes6fS/W6Ojhieqow8S9GVHDj7shOCtMa23X17tPDySt+8eAl4YI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X/ynhv+yirUgul6taIbYMpGdI4CdxOjVlLyRkGZeuw8jXAMDboFM8QSgh50RHnva3tFCh/aj51asdIMG7DhHyMY7wDvw6s0eVq25J4GuBFGmpQ9M+I97yoeNr8FpgedmMGbgXYdID+C/kWDi+w1EhFPYfKiI+DOYIZOtD5nCo2c=
Received: by 10.86.59.2 with SMTP id h2mr16516406fga.63.1208282279612;
        Tue, 15 Apr 2008 10:57:59 -0700 (PDT)
Received: by 10.86.62.15 with HTTP; Tue, 15 Apr 2008 10:57:59 -0700 (PDT)
In-Reply-To: <20080415162008.GD26302@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79611>

On Tue, Apr 15, 2008 at 11:20 AM, Petr Baudis <pasky@suse.cz> wrote:
>   I'm wondering whether perhaps the page is still too wide now - one
>  idea would be to move the header, the two link boxes and possibly some
>  of the contact information to a sidebar - the link boxes always looked a
>  bit strange to me. I'm not sure how much would it help, though.

Yes, a bit wide, I think. A sidebar is one option, or just keep the
page as-is and limit width via CSS.

    body { max-width: 50em; margin: 0.4em auto; }

Steve
