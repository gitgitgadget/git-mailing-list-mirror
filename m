From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 18:31:26 -0500
Message-ID: <b4087cc50904241631t8913c47ke3b2027b466ee1e9@mail.gmail.com>
References: <m24owgqy0j.fsf@boostpro.com>
	 <200904240051.46233.johan@herland.net>
	 <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com>
	 <200904242230.13239.johan@herland.net>
	 <alpine.LNX.2.00.0904241655090.2147@iabervon.org>
	 <20090424213848.GA14493@coredump.intra.peff.net>
	 <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com>
	 <b4087cc50904241525w7de597bfq7be89796947a14cc@mail.gmail.com>
	 <alpine.LNX.2.00.0904241852500.2147@iabervon.org>
	 <20090424231436.GA15058@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 25 01:33:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxUtC-0002M2-Kw
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 01:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbZDXXb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 19:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbZDXXb2
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 19:31:28 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:9740 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbZDXXb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 19:31:27 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1147710qwd.37
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 16:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xgPyb3P8TZTsRB7Zsil+TlfSODQ7iaV4/6zsfclIbCE=;
        b=b+F1wFohvkdhJM+uuBdNaMevjJ7Ag6SC3YoC24PkvaNIE5ZH76IeyWxD1ScGTF8Jle
         XxpeOnPCL2rt335dr99jcJ9d32AmUD7Uz5owHwpltiyfFobsCf9XLCllNrBdveKM07n7
         M8vb6q8iovWtBXVPvKOYItbnq37tWKrLGNCKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Qq9AaIHYYaf8hB/guh5P/FpInndOAYmPDhNzjH3UUpve602bdm96n/9mjxS6fATO6d
         Mc7QBoEb6dpYxgdeHEmmesB7g4fuZWhrNEpAFQn1VeXgYiI1Ixsxighbpa3TxuqIor0w
         ZKmfY4+AHsMrEPJl1Gig+q+d+lVUcRphBdpOE=
Received: by 10.224.37.19 with SMTP id v19mr3660201qad.70.1240615887048; Fri, 
	24 Apr 2009 16:31:27 -0700 (PDT)
In-Reply-To: <20090424231436.GA15058@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117522>

On Fri, Apr 24, 2009 at 18:14, Jeff King <peff@peff.net> wrote:
> Junio suggested "object name" in another thread, which I think is nicely
> descriptive.

The reason I don't like "object name" is that "name" has connotations
that don't go well with the idea of referencing. Isn't "address" (or
"location") better in this sense?
