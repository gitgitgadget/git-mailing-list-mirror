From: David Turner <dturner@twopensource.com>
Subject: Re: Repository Code Security (Plan Text)
Date: Wed, 24 Jun 2015 16:00:14 -0400
Organization: Twitter
Message-ID: <1435176014.6499.4.camel@twopensource.com>
References: <BLUPR0701MB19693B73E05DF433C6B70182D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
	 <20150624213111.61ce6933040bbb7220d5903c@domain007.com>
	 <BLUPR0701MB196947C0396E91F8CCE39200D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
	 <alpine.DEB.2.02.1506241217010.4148@nftneq.ynat.uz>
	 <BLUPR0701MB1969E8CB9B348504F02231F3D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: David Lang <david@lang.hm>,
	Konstantin Khomoutov <kostix+git@007spb.ru>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: BGaudreault Brian <BGaudreault@edrnet.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 22:00:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7qqQ-0003Uy-Ep
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 22:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbbFXUAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 16:00:20 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35418 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271AbbFXUAS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 16:00:18 -0400
Received: by iebrt9 with SMTP id rt9so40660000ieb.2
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 13:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=CfwRFuH/yK+h8zLTnRvRkN2Q+n5wG6wSEMOatC+aVYM=;
        b=Z73AHWFlgXq58Y51/bzFya+1fmlcdA9XAPMIe3922GfmAHMmBeCsEIssDlfmCaNp2g
         xsSVswacILriWQWXLuE0mq4NHyEt+SW5IwyB/1D8aBlVYylCHF6YqgnVLZ+oxMq1hGEb
         d0dgB001OPp4NEGF66osL/b65wQ5iUzxDKFne2Hxdb3uzVzxcMIrBgD6a+LMH53icqe6
         wlx+cGKvpSasrdoi//iOuUTMOJO+y+2ZDpgB03QUs1CLYHVZQULo5myjPzXxzxJGW2+L
         nSZsIOaZZv5D5FDLjzwzN0PfZPITptee0lOxhpMkxiSVcw9TrNsGwVg5WQhY0KxvIQF8
         1Erg==
X-Gm-Message-State: ALoCoQm0WGjG4gew/pWWsPTdiORiLFv4gtrGTnAhOpyQaUCg2CS/+z1wzvc7pvnWCSVtSU840JTd
X-Received: by 10.50.141.164 with SMTP id rp4mr5572145igb.2.1435176017325;
        Wed, 24 Jun 2015 13:00:17 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id o9sm17999630ioe.35.2015.06.24.13.00.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jun 2015 13:00:16 -0700 (PDT)
In-Reply-To: <BLUPR0701MB1969E8CB9B348504F02231F3D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272603>

Git is not GitHub (any more than a cat is a cathouse).  Git is a piece
of software; GitHub is a hosting service for Git.  Contact GitHub for
GitHub support.


On Wed, 2015-06-24 at 19:53 +0000, BGaudreault Brian wrote:
> Hi David Lang,
> 
> I'm sorry, but I'm confused by your first two responses.  Am I not contacting Git when I e-mail this e-mail address?  You sound like you don't know exactly how GitHub works.  Should I be contacting someone else for GitHub support?
> 
> Thanks,
> Brian
> 
> -----Original Message-----
> From: David Lang [mailto:david@lang.hm] 
> Sent: Wednesday, June 24, 2015 3:20 PM
> To: BGaudreault Brian
> Cc: Konstantin Khomoutov; git@vger.kernel.org
> Subject: RE: Repository Code Security (Plan Text)
> 
> On Wed, 24 Jun 2015, BGaudreault Brian wrote:
> 
> > Thanks.  Yes, I meant that "local code" is code pulled down to a person's PC, so we don't want them to leave the company with access to this code.  So we can only prevent this scenario by running GitLab in our environment instead of running GitHub in the cloud?  Would removing a GitHub account from the GitHub repository prevent them from accessing the code on their PC?
> >
> > How do you prevent private GitHub repositories from being pulled down to unauthorized PCs?
> 
> policy, you say that it's against policy for someone to put company info on a personal machine.
> 
> You probably run your own repository that's only available within your network (or over your VPN) rather than using a cloud service like github (you may want to check with github to see if they can lock down a private repo to only be accessed from specific IP addresses)
> 
> you will also need to make sure that people don't plug personal laptops into your corporate network, and that they don't use personal phones to access company e-mail.
> 
> The bottom line is that it's no different from preventing them from having access to any other sensitive data in your company. What measures do you have in place to keep them from taking sensitive Word Docs or spreadsheets when they leave? do the same thing to deal with their access to code.
> 
> David Lang
> 
> > Thanks,
> > Brian
> >
> > -----Original Message-----
> >
> > On Wed, 24 Jun 2015 18:18:00 +0000
> > BGaudreault Brian <BGaudreault@edrnet.com> wrote:
> >
> >> If someone downloads code to their notebook PC and leaves the 
> >> company, what protection do we have against them not being able to 
> >> access the local code copy anymore?
> >
> > What do you mean by "local code"?
> > That one which is on the notebook?
> > Then you can do literally nothing except for not allowing cloning your Git repositories onto random computers in the first place.
> >
> > If you instead mean the copy of code available in the repositories hosted in your enterprise then all you need to do is to somehow terminate the access of that employee who's left to those repositories.
> > (This assumes they're accessible from the outside; if they aren't, the 
> > problem simply do not exist.)
> > --
> > To unsubscribe from this list: send the line "unsubscribe git" in the 
> > body of a message to majordomo@vger.kernel.org More majordomo info at  
> > http://vger.kernel.org/majordomo-info.html
> >
