From: Douglas Mencken <dougmencken@gmail.com>
Subject: Re: [regression] Newer gits cannot clone any remote repos
Date: Mon, 12 Nov 2012 12:13:19 -0500
Message-ID: <CACYvZ7hPAejfjqXQFEHO0DySPN9xmvGgvK7gqj=4qX-XKz0VHQ@mail.gmail.com>
References: <CACYvZ7jPd0_XD6YVdfJ2AnKRnKewmzX4uu7w3zt+_gK+qU49gQ@mail.gmail.com>
	<CAO54GHA=r8WUK3okm2imVkoB=SuZ=3o+wwdwLr_rmPXhdFzG_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Kevin <ikke@ikke.info>
X-From: git-owner@vger.kernel.org Mon Nov 12 18:13:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXxZm-0007n3-6s
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 18:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251Ab2KLRNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 12:13:21 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51234 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab2KLRNU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 12:13:20 -0500
Received: by mail-lb0-f174.google.com with SMTP id n3so4828134lbo.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 09:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wkiI0rf5nloFO53xb2jIcctfV6KTLFeY8B9oXPMAOpk=;
        b=xzv1wmWzNCf1sCSHBlrHwcZIc56MPqwRmAtB2Al3Q0e2CWz2JujcawOp7J/IiquD9d
         74pGrvZTB1av+3N2OfdpamQkWp8UXi3Q1du1jgNfX7NIGEvKlULZFD7vm3m28hcw8vnT
         YS6l+A+VCGM6F0df87WHFmAlEluvckk/9Tf9isVTVUqgnlad22mu1BP15HCTjoxvHGWe
         l8p394meXCsOVZ7bnKFkAqMi+rnJJZN8LbMwMO4OP9f2lJ3VsLZq556aLdRLcMY+Nz7+
         7q5ng6/3FaL9UylMjO+1GCi8ZaROIo3reage/JClhaH7fkaRzGNoA4jNal7JKLvm57Um
         4qcw==
Received: by 10.112.48.133 with SMTP id l5mr8199256lbn.53.1352740399284; Mon,
 12 Nov 2012 09:13:19 -0800 (PST)
Received: by 10.112.22.6 with HTTP; Mon, 12 Nov 2012 09:13:19 -0800 (PST)
In-Reply-To: <CAO54GHA=r8WUK3okm2imVkoB=SuZ=3o+wwdwLr_rmPXhdFzG_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209490>

> Maybe handy to say that you're on a Powerpc platform.

My host, build and target is: powerpc-linux-gnu
