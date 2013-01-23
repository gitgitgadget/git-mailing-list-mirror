From: "Lang, David" <David.Lang@uhn.ca>
Subject: RE: Question re. git remote repository
Date: Wed, 23 Jan 2013 19:40:50 +0000
Message-ID: <201301231941.r0NJf3oa001238@smtpb01.one-mail.on.ca>
References: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca>
 <20130116220615.48c159546bccfa5b9cd9028e@domain007.com>
 <20130116182156.GB4426@sigill.intra.peff.net>
 <20130116233744.7d0775eaec98ce154a9de180@domain007.com>
 <0630A778-9AC8-4023-889C-4FC58ABAB683@gmail.com>
 <alpine.DEB.2.02.1301161459060.21503@nftneq.ynat.uz>,<201301172153.r0HLrU4F019815@smtpb02.one-mail.on.ca>
 <1BBEF94B6B46E54980290D150A6F2EDD46B7AAE2@BN1PRD0612MB635.namprd06.prod.outlook.com>
 <201301181833.r0IIXNe7021768@smtpb01.one-mail.on.ca>
 <1BBEF94B6B46E54980290D150A6F2EDD46B7D7D0@BN1PRD0612MB635.namprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "'Matt Seitz'" <mseitz@mhseitz.onmicrosoft.com>,
	David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Wed Jan 23 20:57:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty6S7-0003y1-Sc
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 20:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650Ab3AWT5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 14:57:23 -0500
Received: from gwfb01.gwf.one-mail.on.ca ([142.46.227.146]:59987 "EHLO
	gwfa01.gwf.one-mail.on.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750813Ab3AWT5W convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 14:57:22 -0500
X-Greylist: delayed 968 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jan 2013 14:57:21 EST
Received: from gwb01.gw.one-mail.on.ca (gw01.local.one.mail [10.250.13.132])
	by sshone0bgf01.int.ssha.ca (Switch-3.3.3/Switch-3.3.3) with ESMTP id r0NJgDX2000471
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Wed, 23 Jan 2013 14:42:13 -0500
Received: from smtpb01.one-mail.on.ca (tlsb.tls.one-mail.on.ca [10.250.26.61])
	by gwb01.gw.one-mail.on.ca (gwb01) with ESMTP id r0NJf9kS003487
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Wed, 23 Jan 2013 14:41:10 -0500
Received: from uhnsmtp003.uhn.on.ca (uhnsmtp003.uhn.on.ca [199.212.7.88])
	(authenticated bits=0)
	by smtpb01.one-mail.on.ca (smtpb01) with ESMTP id r0NJf3oa001238
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <git@vger.kernel.org>; Wed, 23 Jan 2013 14:41:06 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ap8EAHI8AFEKPg5D/2dsb2JhbABEvkhzgh4BAQEDATolGgUHBAIBCA4HDRQJBzIUAwENAgQBCQQFCIgMvhCMch+DQWEDqUqBZz0
Thread-Topic: Question re. git remote repository
Thread-Index: AQHN9BQsnE5PXSeuRLaLkaBQ75QiNZhMmGQAgAAVLgCAADhAAIAAAHSAgAEp7QCAAHgWMYAA5CUAgAAsvnCAB721kA==
In-Reply-To: <1BBEF94B6B46E54980290D150A6F2EDD46B7D7D0@BN1PRD0612MB635.namprd06.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.2.19.202]
x-tm-as-product-ver: SMEX-10.2.0.2087-7.000.1014-19580.001
x-tm-as-result: No--53.800800-8.000000-31
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
X-CT-Refid: str=0001.0A020207.51003CD2.006F:SCFSTAT15037076,ss=1,fgs=0
X-Spam-Score: 0.00%
X-Spam-Analysis: v=1.1 cv=9F42CGUj3zhKouQQFImvTLPh38UMJkhp8E0yNdeEst0= c=1 sm=1 a=q7aWwITXUpIA:10 a=IcfhDb_qSfAA:10 a=kj9zAlcOel0A:10 a=h8FGBgC4kO2qrAwYUDRSMg==:17 a=VwQbUJbxAAAA:8 a=xyCbayrwS_7O-we1OKsA:9 a=CjuIK1q_8ugA:10 a=h8FGBgC4kO2qrAwYUDRSMg==:117%
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214349>

Thanks Matt and Dave and everyone else for your feedback on this.

Ok, I've done some more reading in the Pro Git manual and I think I have an idea of how to get started. Could I run this by you just in case I'm missing anything? Currently (pre-git status) what we have is two developers both working in Visual Studio, occasionally on the same project (hence the need for git). All the VS projects exist on a server and are accessible to both developers via a network share. Currently, if one of us needs to work on a project we turn around and ask our colleague if he's currently in it...this is how we avoid both being in at the same time. We run VS locally on each of our PC's and load the VS project into Visual Studio from the network share. Easy enough...

So to get this all set up with git, here's what I think I have to do...

1. Download and install git for Windows on the 2 networked developer's PC's and the 1 networked server.

2. On the server...
	a) Initialize the Visual Studio folder for a particular project as a git repository using 'git init'
	b) Using the git rep just created (above), create a bare repository on the server to act as the remote/master repository using 'git clone --bare'

3. On each of the PC's...
	a) Clone the remote repository from the network server using 'git clone' (this will automatically create 'origin' as a remote source on the PC's)

Couple of questions...

1. Anyone see any problems/issues with the above?

2. Is it sufficient to use the local protocol for transferring files? Seems like the most straightforward.

3. On p.84 of the guide there's a section entitled "Putting the Bare Repository on a Server" but since the first two rep's (original and bare) are already on the server, this is unnecessary, correct?

4. The original Visual Studio project folder essentially remains untouched, correct? The 'git init' and 'git clone' commands just make copies and references of whatever data is in the VS project folder, right?

David

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> 
> But ultimately, there shouldn't be a question of "if" you have a 
> master repository but "where" you have the master repository, correct?
> Or in other words, it doesn't seem like you'd want to designate any 
> one developer's local repository as also being the master repository, right?

You have two options:

1.  Central model:  
a. each developer has their own private repository b. each developer uses "git commit" to commit changes into their own private repository c. in addition, you also have a shared master repository d. each developer uses "git push" to push their changes from their private repository to the shared master repository e. each developer uses "git pull" to pull other developers' changes from the shared master repository

2.  Peer-to-peer model:
a. each developer has their own private repository b. each developer uses "git commit" to commit changes into their own private repository c. each developer uses "git pull" to pull other developers' changes from other developers' private repositories

You can even mix these models.  Say you have a 5 member team, and 2 members are working on a feature together.  The 2 people working on the feature may use "git pull" to pull changes from each other's private repositories.  Then, when the feature is ready, one of them can use "git push" to push the final version from their private repository into the team's shared repository.

What you don't want to do is this:

Single repository, multiple developers:  just one repository, and every developer uses "git commit" to commit their changes into the same repository.

> My sense is that would defeat the purpose of the DVCS.

Not at all.  The purpose of the DVCS is to allow each developer to have their own private repository where they can commit changes, while still allowing people to share changes from one repository to another.  That's true whether you use the central model or the peer-to-peer model.  

The traditional VCS has just one repository, and everyone has to commit their changes into that one central repository.

> We have access to many servers on our
> company's network, some of which we have full rights to, so there's no 
> issue in regards to storage space.

That will work fine.

> I suppose another idea would be to have the master simply reside on 
> one of the two developers local machines, so one of us would have both 
> a local rep and the master rep and the other of us would have just a 
> local rep.

That will also work.  You could even omit the master rep. and just have each developer have a local repository.  Each developer could then commit changes to their own local repository, and pull the other developer's changes from the other developer's local repository (the peer-to-peer model mentioned above).

> Or is it best to
> always have the master hosted on a machine with no other local reps?

There's no requirement to have the master hosted on a machine with no other local reps.  The only issue is that the machine with the master rep. must be turned on for the other developers to push changes from their private repositories to the master repository.  Having the master repository on a 24x7 server ensures it is always available to all developers.  It also gives you another backup copy of your code, in case the developer's machine's storage fails or gets corrupted.




This e-mail may contain confidential and/or privileged information for the sole use of the intended recipient. 
Any review or distribution by anyone other than the person for whom it was originally intended is strictly prohibited. 
If you have received this e-mail in error, please contact the sender and delete all copies. 
Opinions, conclusions or other information contained in this e-mail may not be that of the organization.
