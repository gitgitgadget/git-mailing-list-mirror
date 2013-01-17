From: "Lang, David" <David.Lang@uhn.ca>
Subject: RE: Question re. git remote repository
Date: Thu, 17 Jan 2013 21:53:29 +0000
Message-ID: <201301172153.r0HLrU4F019815@smtpb02.one-mail.on.ca>
References: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca>
 <20130116220615.48c159546bccfa5b9cd9028e@domain007.com>
 <20130116182156.GB4426@sigill.intra.peff.net>
 <20130116233744.7d0775eaec98ce154a9de180@domain007.com>
 <0630A778-9AC8-4023-889C-4FC58ABAB683@gmail.com>
 <alpine.DEB.2.02.1301161459060.21503@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Stephen Smith <ishchis2@gmail.com>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Thu Jan 17 23:12:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvxh1-0000vH-PF
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 23:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825Ab3AQWLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 17:11:55 -0500
Received: from gwfb01.gwf.one-mail.on.ca ([142.46.227.146]:45790 "EHLO
	gwfa01.gwf.one-mail.on.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751328Ab3AQWLy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 17:11:54 -0500
X-Greylist: delayed 1091 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Jan 2013 17:11:54 EST
Received: from gwb01.gw.one-mail.on.ca (gw01.local.one.mail [10.250.13.132])
	by sshone0bgf01.int.ssha.ca (Switch-3.3.3/Switch-3.3.3) with ESMTP id r0HLsiRD019445
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 17 Jan 2013 16:54:44 -0500
Received: from smtpb02.one-mail.on.ca (tlsb.tls.one-mail.on.ca [10.250.26.62])
	by gwb01.gw.one-mail.on.ca (gwb01) with ESMTP id r0HLra1K029282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 17 Jan 2013 16:53:36 -0500
Received: from uhnsmtp004.uhn.on.ca (uhnsmtp004.uhn.on.ca [199.212.7.89])
	(authenticated bits=0)
	by smtpb02.one-mail.on.ca (smtpb02) with ESMTP id r0HLrU4F019815
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <git@vger.kernel.org>; Thu, 17 Jan 2013 16:53:31 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ap8EAPtx+FAKPg5D/2dsb2JhbABFvklzgh4BAQEEOiUaDAQCAQgRBAEBCxQJBzIUCQgCBA4FCIgdu0iQWGEDlyiSIoIk
Thread-Topic: Question re. git remote repository
Thread-Index: AQHN9BQsnE5PXSeuRLaLkaBQ75QiNZhMmGQAgAAVLgCAADhAAIAAAHSAgAEp7QA=
In-Reply-To: <alpine.DEB.2.02.1301161459060.21503@nftneq.ynat.uz>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.2.19.202]
x-tm-as-product-ver: SMEX-10.2.0.2087-7.000.1014-19564.002
x-tm-as-result: No--54.743300-8.000000-31
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
X-CT-Refid: str=0001.0A020203.50F872DB.00F8:SCFSTAT15037076,ss=1,fgs=0
X-Spam-Score: 0.00%
X-Spam-Analysis: v=1.1 cv=aVuH+yJaJQ3XxwVNIQ0kqFsStq18sPiz0wg/0xjW2bs= c=1 sm=1 a=q7aWwITXUpIA:10 a=IcfhDb_qSfAA:10 a=kj9zAlcOel0A:10 a=05+XHyEUMwofaMpFvQLczg==:17 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=h_gc_OxNfNfZWGqjTCoA:9 a=CjuIK1q_8ugA:10 a=05+XHyEUMwofaMpFvQLczg==:117%
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213882>

Hi David,

Ok, now I'm really lost! This is definitely due to my newbie git status but I'll ask anyway. I'm confused by your statement "... if you try to have one filesystem, with multiple people running git on their machines against that shared filesystem, I would expect you to have all sorts of problems."

Isn't that the whole point of git, or any versioning system? I thought the idea was that each developer installed git locally on their machines and (as needed) committed their changes to the master repository which resides externally to any of the local machines, such as on a network server (and which I'm assuming has git installed locally as well).

What am I missing?

The 'other' David Lang   ;-)

-----Original Message-----
From: David Lang [mailto:david@lang.hm] 
Sent: Wednesday, January 16, 2013 6:01 PM
To: Stephen Smith
Cc: Konstantin Khomoutov; Jeff King; git@vger.kernel.org; Lang, David
Subject: Re: Question re. git remote repository

On Wed, 16 Jan 2013, Stephen Smith wrote:

>>>>> Ideally we'd prefer to simply create our remote repository on a 
>>>>> drive of one of our local network servers. Is this possible?
>>>>
>>>> Yes, this is possible, but it's not advised to keep such a 
>>>> "reference" repository on an exported networked drive for a number 
>>>> of reasons (both performance and bug-free operation).
>>>
>>> I agree that performance is not ideal (although if you are on a fast 
>>> LAN, it probably would not matter much), but I do not recall any 
>>> specific bugs in that area. Can you elaborate?
>>
>> This one [1] for instance.  I also recall seing people having other 
>> "mystical" problems with setups like this so I somehow developed an 
>> idea than having a repository on a networked drive is asking for troubles.
>> Of course, if there are happy users of such setups, I would be glad 
>> to hear as my precautions might well be unfounded for the recent 
>> versions of Git.
>>
>> 1. http://code.google.com/p/msysgit/issues/detail?id=130
>
> A group I was with used a master repository on a windows share for quite some time without a database corruption being seen.   --

I think the risk is that if you have multiple people doing actions on the shared filesystem you can run into trouble.

As long as only one copy of git is ever running against the repository, I don't see any reason for there to be a problem.

But if you try to have one filesystem, with multiple people running git on their machines against that shared filesystem, I would expect you to have all sorts of problems.

David Lang

This e-mail may contain confidential and/or privileged information for the sole use of the intended recipient. 
Any review or distribution by anyone other than the person for whom it was originally intended is strictly prohibited. 
If you have received this e-mail in error, please contact the sender and delete all copies. 
Opinions, conclusions or other information contained in this e-mail may not be that of the organization.
