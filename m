From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: git sequencer prototype
Date: Sat, 26 Jul 2008 19:01:26 +0200
Message-ID: <bd6139dc0807261001l23e130fu7714f0e1fe773a5@mail.gmail.com>
References: <1217049644-8874-1-git-send-email-s-beyer@gmx.net>
	 <alpine.DEB.1.00.0807261617010.26810@eeepc-johanness>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Stephan Beyer" <s-beyer@gmx.net>, git@vger.kernel.org,
	"Christian Couder" <chriscool@tuxfamily.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 26 19:02:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMnA5-0005FH-Ad
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 19:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304AbYGZRB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 13:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754257AbYGZRB1
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 13:01:27 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:15902 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbYGZRB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 13:01:27 -0400
Received: by wf-out-1314.google.com with SMTP id 27so4788090wfd.4
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 10:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Wr6vScP9My4lapg+AOPpwDdQrpTbE7BQjX0FsjwjFwM=;
        b=MgIGeCgFYSJaNu1A6/uwf3jMcRSjkDRS7pQxwEkaKZIbhb42lSpn4W8tpPOaOD8C49
         a58Od/FT1uu/DDVMRRykubiZ9j9O81UD8KZqdaHiopf0XXCmam2R3b0j6fHdGNO/DqeI
         xZKdJ/gjXc/u0PHGzcPBniHNZzJl2P2WGbnQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=mBH4dkOCPRIoz9Yv6xYdUgAO4NLMTsLSc4dTYsxwpfzTt5HZ5+AYLwSPrGgG8k+KcP
         taqu5DACK0hHOOXnX6FdGzqeRQS1P8tpTEYO3pLDE4nmect1cVgPu+Dkx8f+37oprJ3f
         8SGHUE3u27eWLopqF1aLYTGGpYbj7syT4p44E=
Received: by 10.142.84.3 with SMTP id h3mr965311wfb.309.1217091686704;
        Sat, 26 Jul 2008 10:01:26 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Sat, 26 Jul 2008 10:01:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807261617010.26810@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90261>

On Sat, Jul 26, 2008 at 16:19, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Why is it no issue for the builtin?  Is it so much different from the
> prototype?

Because it's blazing fast :P.

-- 
Cheers,

Sverre Rabbelier
