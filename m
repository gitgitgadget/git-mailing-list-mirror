From: "Lang, David" <David.Lang@uhn.ca>
Subject: RE: Question re. git remote repository
Date: Fri, 18 Jan 2013 18:33:22 +0000
Message-ID: <201301181833.r0IIXNe7021768@smtpb01.one-mail.on.ca>
References: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca>
 <20130116220615.48c159546bccfa5b9cd9028e@domain007.com>
 <20130116182156.GB4426@sigill.intra.peff.net>
 <20130116233744.7d0775eaec98ce154a9de180@domain007.com>
 <0630A778-9AC8-4023-889C-4FC58ABAB683@gmail.com>
 <alpine.DEB.2.02.1301161459060.21503@nftneq.ynat.uz>,<201301172153.r0HLrU4F019815@smtpb02.one-mail.on.ca>
 <1BBEF94B6B46E54980290D150A6F2EDD46B7AAE2@BN1PRD0612MB635.namprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "'Matt Seitz'" <mseitz@mhseitz.onmicrosoft.com>,
	David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Fri Jan 18 19:53:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwH3z-0000gU-CT
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 19:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083Ab3ARSwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 13:52:49 -0500
Received: from gwfb01.gwf.one-mail.on.ca ([142.46.227.146]:33125 "EHLO
	gwfa01.gwf.one-mail.on.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751905Ab3ARSws convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 13:52:48 -0500
X-Greylist: delayed 1155 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Jan 2013 13:52:48 EST
Received: from gwb01.gw.one-mail.on.ca (gw01.local.one.mail [10.250.13.132])
	by sshone0bgf01.int.ssha.ca (Switch-3.3.3/Switch-3.3.3) with ESMTP id r0IIYXjV005475
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Fri, 18 Jan 2013 13:34:33 -0500
Received: from smtpb01.one-mail.on.ca (tlsb.tls.one-mail.on.ca [10.250.26.61])
	by gwb01.gw.one-mail.on.ca (gwb01) with ESMTP id r0IIXPDM031215
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Fri, 18 Jan 2013 13:33:25 -0500
Received: from uhnsmtp004.uhn.on.ca (uhnsmtp004.uhn.on.ca [199.212.7.89])
	(authenticated bits=0)
	by smtpb01.one-mail.on.ca (smtpb01) with ESMTP id r0IIXNe7021768
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <git@vger.kernel.org>; Fri, 18 Jan 2013 13:33:24 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqAEAH6U+VAKPg5D/2dsb2JhbAAqGr5Oc4IeAQEBAwE6JRoFBwQCAQgOAwQBAQsUCQcyFAkIAgQBDQUIDId/Eiy8N40Xg0FhA5cokiKBZz0
Thread-Topic: Question re. git remote repository
Thread-Index: AQHN9BQsnE5PXSeuRLaLkaBQ75QiNZhMmGQAgAAVLgCAADhAAIAAAHSAgAEp7QCAAHgWMYAA33kg
In-Reply-To: <1BBEF94B6B46E54980290D150A6F2EDD46B7AAE2@BN1PRD0612MB635.namprd06.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.2.19.202]
x-tm-as-product-ver: SMEX-10.2.0.2087-7.000.1014-19566.001
x-tm-as-result: No--47.727300-8.000000-31
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
X-CT-Refid: str=0001.0A020202.50F99575.0040:SCFSTAT15037076,ss=1,fgs=0
X-Spam-Score: 0.00%
X-Spam-Analysis: v=1.1 cv=9F42CGUj3zhKouQQFImvTLPh38UMJkhp8E0yNdeEst0= c=1 sm=1 a=q7aWwITXUpIA:10 a=IcfhDb_qSfAA:10 a=kj9zAlcOel0A:10 a=05+XHyEUMwofaMpFvQLczg==:17 a=ZDDKZPdRAAAA:8 a=VwQbUJbxAAAA:8 a=TSbVqHtbAAAA:8 a=zrjFa6EUWqUANKRuxn0A:9 a=CjuIK1q_8ugA:10 a=MfSQODttUenw8UTy:21 a=y_zZZaVohn2XQbV7:21 a=05+XHyEUMwofaMpFvQLczg==:117%
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213923>

Hi Matt and David,

Your responses have been very helpful for this newbie...thanks very much! I have a good sense now of the difference btw a CVCS and a DVCS. Here are two more questions...

1. I now get the sense that there's quite a few options in regards to the way that any one group implements their "origin"/"master"/<fill in your favourite name> repository. But ultimately, there shouldn't be a question of "if" you have a master repository but "where" you have the master repository, correct? Or in other words, it doesn't seem like you'd want to designate any one developer's local repository as also being the master repository, right? My sense is that would defeat the purpose of the DVCS.

2. Assuming I'm right about question #1, our first hurdle is where to host the master repository. Could you provide any suggestions for a setup based on our VERY simple department model? I work for a small IT department with a grand total of TWO developers (who sit five feet apart from one another)! The reason we're looking at a VCS is because I was hired a few months ago and the dept never needed one before now. We realize that git will be overkill for what we need but frankly anything will be overkill for what we need, and since git seems to be so well regarded in the community (and free) it looks like a good choice.

So the question is, how would either of you recommend we set up our master repository? We definitely want to keep everything "in house" so off-site hosting isn't something we'd consider. We have access to many servers on our company's network, some of which we have full rights to, so there's no issue in regards to storage space. I suppose another idea would be to have the master simply reside on one of the two developers local machines, so one of us would have both a local rep and the master rep and the other of us would have just a local rep. This would simplify the model. What do you think? Or is it best to always have the master hosted on a machine with no other local reps?

David

-----Original Message-----
From: Matt Seitz [mailto:mseitz@mhseitz.onmicrosoft.com] 
Sent: Friday, January 18, 2013 12:52 AM
To: Lang, David; David Lang
Cc: Konstantin Khomoutov; Jeff King; git@vger.kernel.org; Stephen Smith
Subject: RE: Question re. git remote repository

From: git-owner@vger.kernel.org [git-owner@vger.kernel.org] on behalf of Lang, David [David.Lang@uhn.ca]

> I thought the idea was that each developer installed git locally on 
> their machines

Yes.

> and (as needed) committed their changes to the master repository which 
> resides externally to any of the local machines, such as on a network 
> server

Yes, but committing their changes to the master repository is a two step process:

1.  Each developer first commits their changes to their personal repository using the "git commit" command.
2.  Each developer pushes their changes from their personal repository to the master repository with the "git push" command

> (and which I'm assuming has git installed locally as well).

Maybe.

If the machine with the master repository has git installed locally, then each developer can push their changes to the master repository using either the git protocol or the ssh protocol.

If the machine with the master repository does not have git installed locally, then each developer can push their changes to the master repository using NFS or CIFS/SMB.  The git documentation refers to this method as the "file protocol".

The other David Lang (david@lang.hm) believes that using "git push" using NFS or CIFS/SMB may not be safe and reliable.  Based on the following article by the creator of git, I believe using "git push" over NFS or CIFS/SMB is safe and reliable:

http://permalink.gmane.org/gmane.comp.version-control.git/122670

The GitFaq wiki also says that using "git push" over NFS or CIFS/SMB is safe and reliable:

https://git.wiki.kernel.org/index.php/GitFaq#What_can_I_use_to_set_up_a_public_repository.3F

This e-mail may contain confidential and/or privileged information for the sole use of the intended recipient. 
Any review or distribution by anyone other than the person for whom it was originally intended is strictly prohibited. 
If you have received this e-mail in error, please contact the sender and delete all copies. 
Opinions, conclusions or other information contained in this e-mail may not be that of the organization.
