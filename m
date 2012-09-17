From: "Mestnik, Michael J - Eagan, MN - Contractor" 
	<Michael.J.Mestnik@usps.gov>
Subject: RE: Using Format/export-subst Howto.
Date: Mon, 17 Sep 2012 09:08:02 -0500
Message-ID: <84EA18831601B6429E578236AE239B01A5498B5390@EAGNMNSXMB07.usa.dce.usps.gov>
References: <84EA18831601B6429E578236AE239B01A54807F242@EAGNMNSXMB07.usa.dce.usps.gov>
 <50532B35.9050607@drmicha.warpmail.net> <5053480E.2010002@viscovery.net>
 <84EA18831601B6429E578236AE239B01A54807F376@EAGNMNSXMB07.usa.dce.usps.gov>
 <50534FC6.2040207@viscovery.net>
 <1347656962.3998.140661128069097.6D9BE3C4@webmail.messagingengine.com>
 <7vfw6k2t8w.fsf@alter.siamese.dyndns.org>
 <84EA18831601B6429E578236AE239B01A5498B52A3@EAGNMNSXMB07.usa.dce.usps.gov>
 <50572971.9020204@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 16:25:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDcGi-0007bn-3w
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 16:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756497Ab2IQOZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 10:25:31 -0400
Received: from mailwest1.usps.gov ([56.0.84.21]:46483 "EHLO
	mailwest16.srvs.usps.gov" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756503Ab2IQOZ0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 10:25:26 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2012 10:25:26 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=usps.gov; s=uspsgov0913; c=relaxed/simple;
	q=dns/txt; i=@usps.gov; t=1347891024; x=1351779024;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oGbu9ZODIf27XVkw6p8ATGZyAO3bxl9D1VfOeWxfCMA=;
	b=Yo3TKhMLf/eZoZdzm9F26aFzQZk+kIg6iO5gTKXTI+QIkMAf5qZyFl2uspZ6qAdG
	JUUwVC2KDcjY3zZTrSsrZy1wfRb1yLMcvmhU29H7Gs07EYYJnqkXjh9tf0outuO0
	8SKBOu8+dBjHJo5pBtoLdeg4v6ivjckq8BNv9kFRclk=;
Received: from mailrelay-w.srvs.usps.gov (mailrelay-w.usps.gov [56.224.66.105])
	by mailwest16.srvs.usps.gov (Sendmail 8.14.3) with SMTP id BB.0B.25969.4CE27505; Mon, 17 Sep 2012 09:08:05 -0500 (CDT)
X-AuditID: 38005410-b7f606d000006571-5c-50572ec4611f
Received: from EAGNMNSXMHC01.usa.dce.usps.gov (EAGNMNSXMHC01.usa.dce.usps.gov [56.207.244.211])
	(using TLS with cipher AES128-SHA (AES128-SHA/128 bits))
	(Client did not present a certificate)
	by mailrelay-w.srvs.usps.gov (Symantec Messaging Gateway) with SMTP id C4.85.30870.4CE27505; Mon, 17 Sep 2012 07:08:04 -0700 (PDT)
Received: from EAGNMNSXMB07.usa.dce.usps.gov ([169.254.1.68]) by
 EAGNMNSXMHC01.usa.dce.usps.gov ([56.207.244.211]) with mapi; Mon, 17 Sep 2012
 09:08:03 -0500
Thread-Topic: Using Format/export-subst Howto.
Thread-Index: Ac2U2r+zo+OuZa2cTMqHKKqINFB/UQAAePGg
In-Reply-To: <50572971.9020204@drmicha.warpmail.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsViwRCireuvHx5gcHGhjcWaF6eZLbqudDNZ
	NPReYbZY+bPGgcWjdfIkZo+Ll5Q9Pm+S87j7fydTAEsUt01SYklZcGZ6nr5dAnfGgsZGloJ9
	khWfNjxib2BcLNLFyMkhIWAi8W7aFEYIW0ziwr31bF2MXBxCAicYJU51/WCGKfp0YiETVIJJ
	YuLsEywQzkJGiW27XoC1swkESaz5tI8NxBYR0Je4du4JK4jNLFAtcW/bWrBJLAKqEo1zbzOB
	2MICuhK9jZ+ZIOr1JO5vv8EKYRtJ3P2xAayeVyBMYuH854wQy/4yS3QcO8zexcjBwQl00sxl
	FSA1jEBnfz+1hglil7jErSfzmSCuFpBYsuc81AeiEi8f/2OFqBeVuNO+nhGiXkdiwe5PbBC2
	tsSyha+h9gpKnJz5BOxJCYH3bBKbD59hgYXRhyXbmCYwSs1Csm8WklmzkMyahWTWAkaWVYwS
	6dm65bqpuYmZOXrFRWXFeqXFBcV66fllmxgh8Sywg/HwLcVDjAIcjEo8vIaTwgKEWBPLiitz
	DzFKcDArifDeFggPEOJNSaysSi3Kjy8qzUktPsQozcGiJM5b8iwwQEggPbEkNTs1tSC1CCbL
	xMEJIrikGhjtd2YIGB4xeL02Qu1pl6X/+5hVxXXMPqx/3yxgEVO/f+5VX9jXJzkLvYQEbXUn
	hp+/5qnjY+7M2Xvpr3Usq93XmEbbWcnTzy6xUe9YdOX6zxWLUz94Xy85/kJJgd0wz6g6dJ/Q
	Pq7Wguhz527cCQ1q/33USzXF626V1UFX/oD2GYrM2k5PapVYijMSDbWYi4oTASrB 
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVicf7LZd0jeuEBBuu+W1iseXGa2aLrSjeT
	RUPvFWaLlT9rHFg8WidPYva4eEnZ4/MmOY+7/3cyBbBEcdmkpOZklqUW6dslcGUsaGxkKdgn
	WfFpwyP2BsbFIl2MnBwSAiYSn04sZIKwxSQu3FvP1sXIxSEkcIJJYuLsEywQzkJGiW27XjCC
	VLEJBEms+bSPDcQWEdCXuHbuCSuIzSxQLXFv21pmEJtFQFWice5tsKnCAroSvY2fmSDq9STu
	b7/BCmEbSdz9sQGsnlcgTGLh/OeMEMv+Mkt0HDvM3sXIwcEJdN7MZRUgNYxA130/tYYJYpe4
	xK0n86GuFpBYsuc8M4QtKvHy8T9WiHpRiTvt6xkh6nUkFuz+xAZha0ssW/gaaq+gxMmZT1gm
	MIrNQjJ2FpKWWUhaZiFpWcDIsopRMjcxM6coNSexUrdcr7iorFivtLigWC89v2wTIyjWHjhl
	7GBccErxEKMAB6MSD6/BpLAAIdbEsuLK3EOMEhzMSiK8twXCA4R4UxIrq1KL8uOLSnNSiw8x
	SnOwKInzPvV1CxASSE8sSc1OTS1ILYLJMnFwSjUw8pyQ2LDCpPntAb/We52pwl6JZqea1loG
	1L4SrdpnXyYzI+HDRtNFZzO9NrMxtFS0m28z1lNnW6Vvob45ZW+6UNSlJefqNabXfd92qnvN
	W43JZ64HZj/6P8Xn8h67h6qy+jtZfzqnsNcffMxZyMXrkyCl8fh6Q9LDndsU9S+eTv4mY/rn
	UeZvJZbijERDLeai4kQAlkokwbECAAA=
X-CFilter-Loop: DLP SM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205694>


> -----Original Message-----
> From: Michael J Gruber [mailto:git@drmicha.warpmail.net] 
> Sent: Monday, September 17, 2012 8:45 AM
> To: Mestnik, Michael J - Eagan, MN - Contractor
> Cc: Junio C Hamano; Johannes Sixt; git@vger.kernel.org
> Subject: Re: Using Format/export-subst Howto.
> 
> Mestnik, Michael J - Eagan, MN - Contractor venit, vidit, dixit
> 17.09.2012 14:12:
> > 
> >> -----Original Message-----
> >> From: Junio C Hamano [mailto:gitster@pobox.com] 
> >> Sent: Friday, September 14, 2012 4:24 PM
> >> To: Michael J Gruber
> >> Cc: Johannes Sixt; Mestnik, Michael J - Eagan, MN - 
> >> Contractor; git@vger.kernel.org
> >> Subject: Re: Using Format/export-subst Howto.
> >>
> >> Michael J Gruber <git@drmicha.warpmail.net> writes:
> >>
> >>> you need to "rm file && git checkout file"). If the user 
> >> has to update
> >>> $Id$ to match the current sha1
> >>> (by remembering to do a more forceful checkout than 
> >> checkout -f) then
> >>> one half of that feature is useless. 
> >>
> >> As if there is any value in "$Id$" _feature_.  It's a 
> checkbox item,
> >> nothing more ;-).
> >>
> > 
> > I agree here, $Id$ is much more useful in rcs/cvs.  That's 
> why I chose to dive into export-subst, because I wanted my 
> output to not only contain the uniq Id of the script but also 
> the time and user of the last edit.
> > 
> > I'm going to read up on export today.  Just for context I'm 
> using git to manage daily cron scripts, run on about 1,000 
> hosts, located on NFS.  I've moved the editing of the scripts 
> into user's home directories as I'm a fan of not using 
> editors on live data.  The key point is that when sudoing to 
> the shared user who manages the files the commands run should 
> be minimal and "pushd; ln -s ... .git; git pull; rm .git; 
> popd;" works well.  If I can replace this with something that 
> would populate these fields that would be awesome.
> 
> I'm not completely sure about the setup, but something like
> 
> GIT_DIR=fromthisrepo git archive usethisbranchortag |
> git tar -xf- -C thereyougo
> 
Yes, that's about what the man page says.  I though I could pass --keep-newer-files to tar and that would prevent files from being re-created, but a "git archive --format=tar HEAD | tar -tvv" indicates that every file has the current date/time and not, for example, the time of the last commit that modified that file.  Not only would pushing every file be undesirable it would also cause every server to pull every file and that's unacceptable.  Another down side, or perhaps this is the downside, to this method is that it lacks any form of merge capability and will destroy local changes.

It looks like I'll be doing this in a hook.

BTW: I couldn't find "git tar", if it exists that might be the way for me...  Depending on what it would do.

Thank you for all the insight!

> may do the job (and expand export-subst formats).
> 
> Cheers
> Michael
> 


Mike Mestnik, Michael J
The ESM Tools
Enterprise Systems Monitoring
United States Postal Service
 O: (651) 406-2048
Michael.J.Mestnik@usps.gov
ITEnterpriseSystemsMonitoring@usps.gov
 