From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git diff - no newline after @@ ?
Date: Fri, 18 Aug 2006 14:25:00 +0200
Message-ID: <81b0412b0608180525t284d3124j867a9461bf14ed91@mail.gmail.com>
References: <44E5AE42.6090506@scssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 14:25:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE3PR-000105-Oj
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 14:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWHRMZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 08:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWHRMZE
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 08:25:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:63664 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932408AbWHRMZC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 08:25:02 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1264004nfa
        for <git@vger.kernel.org>; Fri, 18 Aug 2006 05:25:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aSpgFy3p/3o0aeF5AgHVc+wSgDJHwEnFF82I3CLKhL4V25kd3z44RINqA0vm+z5gTHA6qqlj6Sl/v7LKiw+b0/Y/kyyHohsYZgm4O2pFjSAfnEp5y/1P+j2KYHmXxK67/3Fktc6VsPw7M6Z+zrSMBZXZX9Su8RXhK88CwKqv2Tc=
Received: by 10.49.8.1 with SMTP id l1mr3962222nfi;
        Fri, 18 Aug 2006 05:25:00 -0700 (PDT)
Received: by 10.78.160.12 with HTTP; Fri, 18 Aug 2006 05:25:00 -0700 (PDT)
To: "Petr Sebor" <petr@scssoft.com>
In-Reply-To: <44E5AE42.6090506@scssoft.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25654>

On 8/18/06, Petr Sebor <petr@scssoft.com> wrote:
> Hello,
>
> has anyone noticed that the 'git diff' output somehow lacks the newline
> after the @@ tag?
>

Why should it? It's hunk comment.
