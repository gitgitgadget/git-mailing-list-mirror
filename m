From: John Tapsell <johnflux@gmail.com>
Subject: Re: Generalised bisection
Date: Fri, 13 Mar 2009 12:42:00 +0000
Message-ID: <43d8ce650903130542o4125fef3rdddea4a31c23aa30@mail.gmail.com>
References: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>
	 <200903100808.15875.chriscool@tuxfamily.org>
	 <efe2b6d70903110159h78de744yc141effaf5aa0821@mail.gmail.com>
	 <43d8ce650903110235q5e2a59f6t201d5e65a4937476@mail.gmail.com>
	 <efe2b6d70903111515p2b9f656bp186d0b3cc7ae483d@mail.gmail.com>
	 <43d8ce650903112345x3d40b70ap7e4c0f8c7d0b6069@mail.gmail.com>
	 <efe2b6d70903130258t2594b027m5812e9a5895f477e@mail.gmail.com>
	 <alpine.DEB.1.00.0903131154190.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ealdwulf Wuffinga <ealdwulf@googlemail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 13 13:43:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li6ji-00020H-0C
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 13:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbZCMMmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 08:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752389AbZCMMmG
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 08:42:06 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:30988 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbZCMMmF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 08:42:05 -0400
Received: by an-out-0708.google.com with SMTP id c2so1103066anc.1
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 05:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=twQ4ieHFHwUgqgJk21s7RVVZE0RUWmCvqxHeQVtVriU=;
        b=i+0aFPVP32kxG7qza0kB7gFYVqV0Ky4ejumxtfGepmxWvXuRjr6LcRBCI3hNjnBAab
         ia8T3g9k6UM94OaGoPiLysA++Q85bP2M82pxwqSVhNMMsOI06oTBLV6OWI0IRoy36X9T
         5vqk+RlS66/nyEc00gQD7Ap3+j+J8PPSES8Xw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bRhVe4mteeqX0ajs/OzvF/oDJiVZ2rMwXhDVwMFNsinlz3AQdsfygJ0YIUpdPlMCA2
         RD453jwaadFjzAmTpM6O75w6P4Oii7I4DEyY9sAaWHFPtz5mQJKIsKC7IcTgUCsZv60m
         2zUbj5UYcDEk3nA28vDIh0aoWg6VTGG+5ispg=
Received: by 10.142.217.17 with SMTP id p17mr572485wfg.235.1236948121108; Fri, 
	13 Mar 2009 05:42:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903131154190.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113177>

2009/3/13 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Fri, 13 Mar 2009, Ealdwulf Wuffinga wrote:
>
>> It is BayesianSearch_Debugging.pdf.
>
> Now I'll only need a bayesian-search-for-original-url-in-mails.py.

I managed to work it out:

http://github.com/Ealdwulf/bbchop.git/BBChop/doc/BayesianSearch_Debugging.pdf

John
