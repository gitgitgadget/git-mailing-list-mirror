From: Brian Hetro <whee@smaertness.net>
Subject: Re: [PATCH] Documentation: For consistency, use CVS instead of cvs.
Date: Fri, 24 Aug 2007 09:16:30 -0400
Message-ID: <20070824131630.GA5409@ruiner>
References: <20070824004008.GA21778@ruiner> <7vhcmps9a2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 15:16:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOZ1x-0005ex-0b
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 15:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757393AbXHXNQl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 09:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758194AbXHXNQl
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 09:16:41 -0400
Received: from ag-out-0708.google.com ([72.14.246.251]:25246 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757355AbXHXNQk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 09:16:40 -0400
Received: by ag-out-0708.google.com with SMTP id 35so1706188aga
        for <git@vger.kernel.org>; Fri, 24 Aug 2007 06:16:39 -0700 (PDT)
Received: by 10.90.90.3 with SMTP id n3mr3793229agb.1187961399154;
        Fri, 24 Aug 2007 06:16:39 -0700 (PDT)
Received: from smaertness.net ( [66.67.48.108])
        by mx.google.com with ESMTPS id 7sm8886771agc.2007.08.24.06.16.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 24 Aug 2007 06:16:32 -0700 (PDT)
Received: by smaertness.net (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	whee@smaertness.net; Fri, 24 Aug 2007 09:16:31 -0400 (EDT)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vhcmps9a2.fsf@gitster.siamese.dyndns.org>
X-PGP-Key: http://whee.smaertness.net/pubkey.asc
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56574>

On Fri, Aug 24, 2007 at 00:04:37 -0700, Junio C Hamano wrote:
> Brian Hetro <whee@smaertness.net> writes:
> 
> > When not referring to the cvs command, CVS makes more sense.
> 
> I wonder if you would also want to upcase this one:
> 
> diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
> index 60d0bcf..258a62f 100644
> --- a/Documentation/git-cvsserver.txt
> +++ b/Documentation/git-cvsserver.txt
> @@ -102,7 +102,7 @@ No special setup is needed for SSH access, other than having GIT tools
>  in the PATH. If you have clients that do not accept the CVS_SERVER
>  environment variable, you can rename git-cvsserver to cvs.
>  
> -Note: Newer cvs versions (>= 1.12.11) also support specifying
> +Note: Newer CVS versions (>= 1.12.11) also support specifying
>  CVS_SERVER directly in CVSROOT like
>  
>  ------

This one probably should also be uppercase.  (I think I debated
whether or not it referred to the GNU CVS command or CVS in general)
