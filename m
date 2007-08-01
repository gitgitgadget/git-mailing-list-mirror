From: "Steve Hoelzer" <shoelzer@gmail.com>
Subject: Re: [PATCH] Try to be consistent with capitalization in the documentation
Date: Wed, 1 Aug 2007 12:17:52 -0500
Message-ID: <588192970708011017q12c7a6d9s532c8aed086d3032@mail.gmail.com>
References: <514D28CB-25F8-49B2-921E-8EFA60BE864C@gmail.com>
	 <7vir7z5gx7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 19:18:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGHpm-0003Ch-Ga
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 19:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756262AbXHARRy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 13:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756724AbXHARRy
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 13:17:54 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:8705 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265AbXHARRy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 13:17:54 -0400
Received: by an-out-0708.google.com with SMTP id d31so49439and
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 10:17:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QfRdNCoxdjjoy/s7wIjgeO2pOmiLAt4Oril24TtQxZJ7P2+YJxj9cx4oGkzVx7vofdXcuxaBKAroyzGTI2Swn7ADWiavZayQ98BNTM0FP/ACu5hP96VhMmX2sW5tZemB7FIom6bp4Gw/cbpP58JlDjyFFDqnh9nsncmLymfgRPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MY2PDHTpgHwyK8S1dZ3hEjf5OEOp4OipvNNwkGc55e2K++xXKqtotNzsWLGNBMo+bF+FuP5rtLNjAHfLd+eQDWiy5vbcU45wpoBzLzl8+d+ptN9jHrszMLLtbzRC41GNfVytnjXSf1RZ920cJWIVH2RkuFAK8206zN/Gp+cK+xg=
Received: by 10.100.13.12 with SMTP id 12mr557434anm.1185988672628;
        Wed, 01 Aug 2007 10:17:52 -0700 (PDT)
Received: by 10.100.105.9 with HTTP; Wed, 1 Aug 2007 10:17:52 -0700 (PDT)
In-Reply-To: <7vir7z5gx7.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54455>

On 8/1/07, Junio C Hamano <gitster@pobox.com> wrote:
> Steve Hoelzer <shoelzer@gmail.com> writes:
>
> > Signed-off-by: Steve Hoelzer <shoelzer@gmail.com>
> > ---
> >
> > Try to be consistent with capitalization in the documentation.
>
> It looks like that all the originals are trying to consistently
> start with lowercase in an explanatory list.  Is this really
> needed?

The lists I changed were indeed all lowercase, but other lists in
those files are all uppercase. I was aiming for consistency across all
list items and all lists.

Steve
