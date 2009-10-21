From: David Gerard <dgerard@gmail.com>
Subject: Re: [Foundation-l] Wikipedia meets git
Date: Thu, 22 Oct 2009 00:36:59 +0100
Message-ID: <fbad4e140910211636hd772962x4535ccbda6faa3c7@mail.gmail.com>
References: <ee9cc730910151155w307a87f0w7bba5c4039bb1ef9@mail.gmail.com>
	 <deea21830910170804s61786d8ewae0bc9390baaed71@mail.gmail.com>
	 <71cd4dd90910170823o3f58b8c2x1d39040e7582634@mail.gmail.com>
	 <ee9cc730910170939m6e83ad2fy5f22a541c3679638@mail.gmail.com>
	 <deea21830910170953o33823dd3rd7a9305f9ea794d@mail.gmail.com>
	 <ee9cc730910171011l1b68a1a0q7096a93c36362959@mail.gmail.com>
	 <e405c96a0910190830y51009225lc72942a703575042@mail.gmail.com>
	 <5396c0d10910210543i4c0a3350je5bee4c6389a2292@mail.gmail.com>
	 <1256154567.1477.87.camel@giskard>
	 <ee9cc730910211308u5a0284d6he483b0904ddb6068@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Bernie Innocenti <bernie@codewiz.org>, git <git@vger.kernel.org>
To: Wikimedia Foundation Mailing List 
	<foundation-l@lists.wikimedia.org>
X-From: git-owner@vger.kernel.org Thu Oct 22 01:37:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0kjq-0007EX-4c
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 01:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbZJUXg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 19:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbZJUXg4
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 19:36:56 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:45202 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbZJUXg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 19:36:56 -0400
Received: by ewy3 with SMTP id 3so6649910ewy.17
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 16:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ztmNjJ6ZNAXfwACjO7AAhFTNw45kVoUcRjpO3byVvqQ=;
        b=OyCYwYRn17KCXU/VuBeExKkt6V7Qezky/atVAyTPWAeUaz6Cl5E/i5drar83zbpbJl
         zwoj3E48D+RUWwviecH86WNttGiwAKL1UOFbrds/OM1tsDIxVs1LYnGi7OURkMuopKIx
         o4tCke8mpZqkY6+zEIHTVEr8OI097Xmb/ckbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rEdOGBAPIKrpnjply3tmcIOjb63iEGkIuGRNxRf47iY4TM3mQ6mNPQW1YJ5NeQGd4r
         lLWwZz57FsDWI4YcQVO7C4Azzv88Yrf2HNX5DFIFUpxdBgzRmAjdCAaZ7p5qddsbJXFL
         VHmHRl6jYcgyXGYTjUF7cZodcYByeFs8PEnbQ=
Received: by 10.210.154.9 with SMTP id b9mr3584761ebe.34.1256168219798; Wed, 
	21 Oct 2009 16:36:59 -0700 (PDT)
In-Reply-To: <ee9cc730910211308u5a0284d6he483b0904ddb6068@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130987>

2009/10/21 jamesmikedupont@googlemail.com <jamesmikedupont@googlemail.com>:

> most people are working on very small subsets of the data. Very few
> people will want to have all the data, think about getting all the
> versions from all the git repos, it would be the same.
> My idea is for smaller chapters who want to get started easily, or
> towns, regions to host their own branches of relevant data.
> Given a world full of such servers, the sum would be great but the
> individual branches needed at one time would be small.


A distributed backend is a nice idea anyway - imagine a meteor hitting
the Florida data centres ...

And there are third-party users who could benefit from a highly
distributed backend, such as Wikileaks.

This thread should probably move to mediawiki-l ...


- d.
