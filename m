From: Christian Couder <christian.couder@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2014, #03; Tue, 10)
Date: Thu, 12 Jun 2014 18:30:27 +0200
Message-ID: <CAP8UFD0X0xVxJ5M-mtmFGii38HRkprFbm=JjK79mfwRVoS2LFQ@mail.gmail.com>
References: <xmqq38fc8l23.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 18:30:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv7tZ-0004ZR-6X
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 18:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072AbaFLQa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 12:30:29 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:58884 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756014AbaFLQa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 12:30:28 -0400
Received: by mail-vc0-f179.google.com with SMTP id id10so1078268vcb.10
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mrmtoHiuwnyG6rIgCrQV6wgJs/faBloJX7D2mhsYBjU=;
        b=wP73BSvXrb1u1kJ0B3dwp+dBWsUpfiMsDbQRg2h4rvdBrdwXVviMkIju3RySYhcSA7
         x1OPlgRGespEEYNvrwlSI+FhQKQmRrQwdx7TYmEsLVsrYYfVFK4qprg4kmSc9a+OSjfv
         eVv+dut7+xatQ3qZ5Vp1uTPLKdgdVpk4Gql+dR7mQJA/ooPnUC8OQF77ezpOfOnHMIYv
         KvqSMWkZ6vYRIvfFiK/FmQKDvXdqU82hnk6gkwf2P2pZ3Xg16jPagQI3D4TDAZ5WWEOJ
         spirc1sX6YKgHqi9vvhnso3gGZijggTgs2Mi/GvQqU67i1P4T+OPq8Jofz2AmfXbwPAE
         sAyA==
X-Received: by 10.52.93.201 with SMTP id cw9mr819798vdb.80.1402590627735; Thu,
 12 Jun 2014 09:30:27 -0700 (PDT)
Received: by 10.58.134.107 with HTTP; Thu, 12 Jun 2014 09:30:27 -0700 (PDT)
In-Reply-To: <xmqq38fc8l23.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251414>

On Wed, Jun 11, 2014 at 12:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> * cc/interpret-trailers (2014-05-28) 11 commits
>  - Documentation: add documentation for 'git interpret-trailers'
>  - trailer: add tests for commands in config file
>  - trailer: execute command from 'trailer.<name>.command'
>  - trailer: add tests for "git interpret-trailers"
>  - trailer: add interpret-trailers command
>  - trailer: put all the processing together and print
>  - trailer: parse trailers from file or stdin
>  - trailer: process command line trailer arguments
>  - trailer: read and process config information
>  - trailer: process trailers from input message and arguments
>  - trailer: add data structures and basic functions
>
>  A new filter to programatically edit the tail end of the commit log
>  messages.
>
>  What is the status of this one?  I think I saw reviews by Michael
>  but after that I do not recall seeing any updates.

Yeah, I am very busy with other things these days, but I should have
more time after next week.

Thanks,
Christian.
