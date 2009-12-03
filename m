From: Marko Kreen <markokr@gmail.com>
Subject: Re: Git documentation consistency
Date: Thu, 3 Dec 2009 18:22:27 +0200
Message-ID: <e51f66da0912030822ye1541b4gb1b8a3e07eb72484@mail.gmail.com>
References: <m1NEaLp-000kn1C@most.weird.com>
	 <20091129051427.GA6104@coredump.intra.peff.net>
	 <m1NFAji-000kn2C@most.weird.com>
	 <20091202200904.GA7631@coredump.intra.peff.net>
	 <m1NG0O6-000kmgC@most.weird.com>
	 <7vaay096ye.fsf@alter.siamese.dyndns.org>
	 <m1NG61U-000kn4C@most.weird.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: The Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 03 17:22:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGERu-0002Hm-PY
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 17:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417AbZLCQWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 11:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754390AbZLCQWX
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 11:22:23 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:28950 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbZLCQWW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 11:22:22 -0500
Received: by fg-out-1718.google.com with SMTP id e21so765916fga.1
        for <git@vger.kernel.org>; Thu, 03 Dec 2009 08:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=T3VzGMwHYYJjRK1ezgv+2hfE1dofTwfMIT3AGuJ1IMs=;
        b=mrj8j7vNTQ2QGF67FhbB7IEl9WgGMJosf4WqTrEXhIT0spEv1dteqBbR9BBajHv/no
         9uYvhFKkggTzrSyNnplkMf53oesmHSK/q6U1+dS2EYOE9Dl7k6IU4wbLwcxiHy4j6VMG
         5iGKQrNTfDPVKInResR3HF8kNE18qc7fdIIxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=ilnQJyqOB50WH+2vVDpSIOjV+Fes78Umcw1K0flyl2vflVwbrt0lUkm4gxQE4bDtaH
         fYgbbk+DcDvjioJrzIHdf5Y+RB4NmDYYlAUXOjYi6D+ynO01SQBtYTL4RvGN050jnDna
         z+DoUJoM9BlUXpPBdhrmsxPYMnNzLa/q/srq8=
Received: by 10.239.237.193 with SMTP id k1mr162768hbp.173.1259857347916; Thu, 
	03 Dec 2009 08:22:27 -0800 (PST)
In-Reply-To: <m1NG61U-000kn4C@most.weird.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134458>

On 12/3/09, Greg A. Woods <woods@planix.com> wrote:
> At Wed, 02 Dec 2009 17:34:01 -0800, Junio C Hamano <gitster@pobox.com> wrote:
>  Subject: Re: Git documentation consistency
>  > I think you are showing ignorance here, as -? is *not* even close to
>  > standard, nor even widely used practice at all.
>
>  I think I should know something about Unix command line and option
>  parsers, having used them for some 25 years or so now.  In fact I've
>  used most every kind of unix that ever was, and I've worked on the
>  source to more than a few.

'?' is what getopt(3) is supposed to return for unknown options.

-- 
marko
