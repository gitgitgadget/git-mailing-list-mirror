X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: "Ryan Anderson" <rda@google.com>
Subject: Re: information for a 60-minute "intro to git" needed
Date: Sat, 11 Nov 2006 20:51:00 -0800
Message-ID: <87dcb0bd0611112051o3d7efca5r3b2c7c34034e2446@mail.gmail.com>
References: <8664dmxdrf.fsf@blue.stonehenge.com>
	 <20061111143304.GA7201@pasky.or.cz> <ej4teo$bjo$1@sea.gmane.org>
	 <7vac2xkdgi.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90611111449g63ab5b41p8dc669beea864e51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 12 Nov 2006 04:51:23 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, jnareb@gmail.com,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=QaspGI00r9RhpmRj1xgilkRfKaiCeRmtDjqjWz8lBCrKDklmaFjMKFt+eDB0kFpfY
	5gABoqWblY/4f2JeJ9Lzg==
In-Reply-To: <46a038f90611111449g63ab5b41p8dc669beea864e51@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31254>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gj7JM-0001C1-BD for gcvg-git@gmane.org; Sun, 12 Nov
 2006 05:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754963AbWKLEvM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006
 23:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754966AbWKLEvM
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 23:51:12 -0500
Received: from smtp-out.google.com ([216.239.45.12]:44604 "EHLO
 smtp-out.google.com") by vger.kernel.org with ESMTP id S1754963AbWKLEvK
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 23:51:10 -0500
Received: from zps76.corp.google.com (zps76.corp.google.com [172.25.146.76])
 by smtp-out.google.com with ESMTP id kAC4p6lH012179 for
 <git@vger.kernel.org>; Sat, 11 Nov 2006 20:51:06 -0800
Received: from nz-out-0102.google.com (nzbq3.prod.google.com [10.36.93.3]) by
 zps76.corp.google.com with ESMTP id kAC4p1gQ017697 for <git@vger.kernel.org>;
 Sat, 11 Nov 2006 20:51:01 -0800
Received: by nz-out-0102.google.com with SMTP id q3so23443nzb for
 <git@vger.kernel.org>; Sat, 11 Nov 2006 20:51:00 -0800 (PST)
Received: by 10.64.156.1 with SMTP id d1mr5570349qbe.1163307060732; Sat, 11
 Nov 2006 20:51:00 -0800 (PST)
Received: by 10.64.84.4 with HTTP; Sat, 11 Nov 2006 20:51:00 -0800 (PST)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

On 11/11/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 11/11/06, Junio C Hamano <junkio@cox.net> wrote:
> > I think Martin Langhoff promised to make his presentation done
> > in Mexico available to us sometime ago, but I wonder what
> > happened to it...
>
> Hola! You are right, I never published anything... The Mexico
> presentation was a combination of your original slides (I ended up
> using the PDF directly as I didn't have OOv2) plus a version of my
> older talk notes, updated and in Spanish. So I swapped the two
> around.... "live".
>
> The old, outdated talk is based on Cogito, and can be found here. I
> still use it for my inhouse team --
> http://wellington.pm.org/archive/200510/git/

I gave this talk at Ubucon:
http://h4x0r5.com/~ryan/presentations/git-why.pdf
(I modeled this one after Junio's OLS talk, as I thought it was more
interesting to give a 'why' talk, rather than a 'magic incantation'
talk.)

Back in April, I used these to give a talk at Penguicon:
http://h4x0r5.com/~ryan/presentations/git-tutorial.pdf

