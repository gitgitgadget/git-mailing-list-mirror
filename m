From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: Extract Git classes from git-svn (1/10)
Date: Thu, 19 Jul 2012 00:43:58 -0300
Message-ID: <CACnwZYcuyLWKE4M6gOk964peVEosGypT605dR-+zBbkSctpFCw@mail.gmail.com>
References: <5004B772.3090806@pobox.com>
	<20120717174446.GA14244@burratino>
	<5005F139.8050205@pobox.com>
	<20120717233125.GF25325@burratino>
	<7vy5mhwrdl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael G Schwern <schwern@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	robbat2@gentoo.org, Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 05:44:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Srheo-0001pU-9b
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 05:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764Ab2GSDoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 23:44:00 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41449 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab2GSDn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 23:43:59 -0400
Received: by obbuo13 with SMTP id uo13so3097227obb.19
        for <git@vger.kernel.org>; Wed, 18 Jul 2012 20:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jCvmrX68ruo6UuVP2oVVjVMy9a7TmNn7iwJtvbbO5ZM=;
        b=vYz8bsw3MMF25uFOFf/A7JeYUJ3yGzIu1TBmjgXfLTcbKxYUSdhuxsbdL5KC+ADbdF
         vV1Xv/httZXOFgwqh/Ipqk+mWxbI/EyrhyOjUZvIQ7vAVmLoSz7LGawwpkDplMYrsUMA
         bPS+W6D5fT+NTxYWyRjMDSjw2i0MqekJfI0K63Mf0Os/Op8feeEqI3N7qDD7rQfN81lN
         oSEuYh8mXN+TGu1UBXOK1agHd5Hh3weq6uTi9JIX0f7+Wop+siZPlDZ4OwQCOK6g5ypK
         jGqXTM7mxx9F1ABT1L4huSVnSc6E0/rIt71mzY97XWNnNkGnqr/oY5YTNvmXPCeScbRV
         nVXA==
Received: by 10.182.144.68 with SMTP id sk4mr358486obb.0.1342669438884; Wed,
 18 Jul 2012 20:43:58 -0700 (PDT)
Received: by 10.182.212.67 with HTTP; Wed, 18 Jul 2012 20:43:58 -0700 (PDT)
In-Reply-To: <7vy5mhwrdl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201711>

On Wed, Jul 18, 2012 at 2:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> There may be a hosting site with better code review features, but
> all the code review of Git happens on this mailing list, and that is
> not likely to change in the near future.
>
For me, you know, it's codereview, aka rietveld. [1]

[1] code.google.com/p/rietveld/
