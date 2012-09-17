From: "Mestnik, Michael J - Eagan, MN - Contractor" 
	<Michael.J.Mestnik@usps.gov>
Subject: RE: Using Format/export-subst Howto.
Date: Mon, 17 Sep 2012 10:52:24 -0500
Message-ID: <84EA18831601B6429E578236AE239B01A5498B54AA@EAGNMNSXMB07.usa.dce.usps.gov>
References: <84EA18831601B6429E578236AE239B01A54807F242@EAGNMNSXMB07.usa.dce.usps.gov>
 <50532B35.9050607@drmicha.warpmail.net> <5053480E.2010002@viscovery.net>
 <84EA18831601B6429E578236AE239B01A54807F376@EAGNMNSXMB07.usa.dce.usps.gov>
 <50534FC6.2040207@viscovery.net>
 <1347656962.3998.140661128069097.6D9BE3C4@webmail.messagingengine.com>
 <7vfw6k2t8w.fsf@alter.siamese.dyndns.org>
 <84EA18831601B6429E578236AE239B01A5498B52A3@EAGNMNSXMB07.usa.dce.usps.gov>
 <50572971.9020204@drmicha.warpmail.net>
 <84EA18831601B6429E578236AE239B01A5498B5390@EAGNMNSXMB07.usa.dce.usps.gov>
 <505731CE.1090500@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 17:53:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDddZ-0000iC-2O
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 17:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280Ab2IQPxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 11:53:20 -0400
Received: from mailwest1.usps.gov ([56.0.84.21]:54072 "EHLO
	mailwest16.srvs.usps.gov" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932093Ab2IQPxS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 11:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=usps.gov; s=uspsgov0913; c=relaxed/simple;
	q=dns/txt; i=@usps.gov; t=1347897196; x=1351785196;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=71vFrzc9j3tKenC6mxMReEPIrVQ0DBDH3RPxw3rrIzw=;
	b=FIEXh3Z9lGaGMRrt44S8bpSKY/UPf9dF3dEHgMPkRU2LBo07BNYNhmrNtZ76/cz+
	8kDVZM6ptCRWPzxWclgcvoqAT5SFiFiFWymhAXMCZzUlX0VhIgzKkqsK6KJaYKh2
	u4fZOQbD7MKR+m5Qsf/OfF3XB0gXlv99h8g57pFcvNg=;
Received: from mailrelay-w4i.usps.gov (Unknown_Domain [56.224.66.59])
	by mailwest16.srvs.usps.gov (Sendmail 8.14.3) with SMTP id 5B.E2.25628.B6747505; Mon, 17 Sep 2012 10:53:15 -0500 (CDT)
X-AuditID: 38005410-b7f7d6d00000641c-27-5057476b5cd1
Received: from EAGNMNSXMHC02.usa.dce.usps.gov (EAGNMNSXMHC02.usa.dce.usps.gov [56.207.244.212])
	by mailrelay-w4i.usps.gov (Symantec Messaging Gateway) with SMTP id FB.88.03438.A6747505; Mon, 17 Sep 2012 08:53:14 -0700 (PDT)
Received: from EAGNMNSXMB07.usa.dce.usps.gov ([169.254.1.68]) by
 EAGNMNSXMHC02.usa.dce.usps.gov ([56.207.244.212]) with mapi; Mon, 17 Sep 2012
 10:52:26 -0500
Thread-Topic: Using Format/export-subst Howto.
Thread-Index: Ac2U3+7wJSjZ6nPRQ1qZFlWRF3PKVQACxgOQ
In-Reply-To: <505731CE.1090500@drmicha.warpmail.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsViwRCiqZvtHh5gcHCvjcWaF6eZLbqudDNZ
	NPReYbZY+bPGgcWjdfIkZo+Ll5Q9Pm+S87j7fydTAEsUt01SYklZcGZ6nr5dAnfGwVuzmQsO
	qlZceu3YwPhctouRk0NCwESiYcNtFghbTOLCvfVsXYxcHEIC+xglHhx4wAZT9PrmdmaIxENG
	ibf7HrODJIQEFjJK/NtlD2KzCQRJrPm0D6xBREBf4tq5J6wgNrNAtcS9bWuZQWwWAVWJFW1N
	YNuEBXQlehs/M0HU60nc336DFcI2kji/uhtsPq9AmMTsOx/ZIRZ/YZE42XsNLMEJdNHEu01g
	yxiBzv5+ag0TxDJxiVtP5jNBXC0gsWTPeWYIW1Ti5eN/rBD1ohJ32tczQtTrSCzY/YkNwtaW
	WLbwNTPEYkGJkzOfsIAslhB4zSbR+ugT1FApiXl/DrFPYJSahWTfLCSzZiGZNQvJrAWMLKsY
	JdKzdct1U3MTM3P0iovKivVKiwuK9dLzyzYxQqJZYAfj4VuKhxgFOBiVeHgNJ4UFCLEmlhVX
	5h5ilOBgVhLhvS0QHiDEm5JYWZValB9fVJqTWnyIUZqDRUmct+RZYICQQHpiSWp2ampBahFM
	lomDE0RwSTUwbmxzeqHmOklP16xmh3K169XVBu5Bc0JeaZ179GiDRYfg3Jsvqn6IdblO9vvP
	xytTdeDLpg4+zmSexme+1mYGPdWmjJ1uiTfYQ1Y97H7AeJfHc5kva4rMy0M1KhHbF7zS0Ize
	lny9kyOy8MSsg8p3bXbvOG6Y++Rj8j7+RXz9cfenP5t9dc9uJZbijERDLeai4kQA 
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVicf7LFd0s9/AAgwWXjSzWvDjNbNF1pZvJ
	oqH3CrPFyp81DiwerZMnMXtcvKTs8XmTnMfd/zuZAliiuGxSUnMyy1KL9O0SuDIO3prNXHBQ
	teLSa8cGxueyXYycHBICJhKvb25nhrDFJC7cW8/WxcjFISTwkFHi7b7H7CAJIYGFjBL/dtmD
	2GwCQRJrPu1jA7FFBPQlrp17wgpiMwtUS9zbthZsEIuAqsSKtiYWEFtYQFeit/EzE0S9nsT9
	7TdYIWwjifOru8Hm8wqEScy+85EdYvEXFomTvdfAEpxA10282wS2jBHouu+n1jBBLBOXuPVk
	PhPE1QISS/ach/pAVOLl43+sEPWiEnfa1zNC1OtILNj9iQ3C1pZYtvA1M8RiQYmTM5+wTGAU
	m4Vk7CwkLbOQtMxC0rKAkWUVo1huYmZOUWpOYqVuuUmmXmlxQbFeen7ZJkZQjD1wMt7BeO+h
	+SFGAQ5GJR5e40lhAUKsiWXFlbmHGCU4mJVEeG8LhAcI8aYkVlalFuXHF5XmpBYfYpTmYFES
	5/3i6xYgJJCeWJKanZpakFoEk2Xi4JRqYJxzb4bg44Jde8IUlpz6rZifoWfBlCHkNVP474ZL
	gm/KW9ceubnyp3Pim/JMudhH5ofXhi0K5TFvrHt47tsvk082NiJ6fRZLXx3YU172cG79lU06
	j/d8spjU5B35/LRNj75Q1NLles/vT/Zbr1ZQ43bx4TUGh5lcdx5x7I9cbD7Xje2JiISc9V0l
	luKMREMt5qLiRAAGpHOHrQIAAA==
X-CFilter-Loop: SM DLP03-2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205704>


> -----Original Message-----
> From: Michael J Gruber [mailto:git@drmicha.warpmail.net] 
> Sent: Monday, September 17, 2012 9:21 AM
> To: Mestnik, Michael J - Eagan, MN - Contractor
> Cc: Junio C Hamano; Johannes Sixt; git@vger.kernel.org
> Subject: Re: Using Format/export-subst Howto.
> 
> Mestnik, Michael J - Eagan, MN - Contractor venit, vidit, dixit
> 17.09.2012 16:08:
> > 
> >> -----Original Message-----
> >> From: Michael J Gruber [mailto:git@drmicha.warpmail.net] 
> >> Sent: Monday, September 17, 2012 8:45 AM
> >> To: Mestnik, Michael J - Eagan, MN - Contractor
> >> Cc: Junio C Hamano; Johannes Sixt; git@vger.kernel.org
> >> Subject: Re: Using Format/export-subst Howto.
> >>
> >> Mestnik, Michael J - Eagan, MN - Contractor venit, vidit, dixit
> >> 17.09.2012 14:12:
> >>>
> >>>> -----Original Message-----
> >>>> From: Junio C Hamano [mailto:gitster@pobox.com] 
> >>>> Sent: Friday, September 14, 2012 4:24 PM
> >>>> To: Michael J Gruber
> >>>> Cc: Johannes Sixt; Mestnik, Michael J - Eagan, MN - 
> >>>> Contractor; git@vger.kernel.org
> >>>> Subject: Re: Using Format/export-subst Howto.
> >>>>
> >>>> Michael J Gruber <git@drmicha.warpmail.net> writes:
> >>>>
> >>>>> you need to "rm file && git checkout file"). If the user 
> >>>> has to update
> >>>>> $Id$ to match the current sha1
> >>>>> (by remembering to do a more forceful checkout than 
> >>>> checkout -f) then
> >>>>> one half of that feature is useless. 
> >>>>
> >>>> As if there is any value in "$Id$" _feature_.  It's a 
> >> checkbox item,
> >>>> nothing more ;-).
> >>>>
> >>>
> >>> I agree here, $Id$ is much more useful in rcs/cvs.  That's 
> >> why I chose to dive into export-subst, because I wanted my 
> >> output to not only contain the uniq Id of the script but also 
> >> the time and user of the last edit.
> >>>
> >>> I'm going to read up on export today.  Just for context I'm 
> >> using git to manage daily cron scripts, run on about 1,000 
> >> hosts, located on NFS.  I've moved the editing of the scripts 
> >> into user's home directories as I'm a fan of not using 
> >> editors on live data.  The key point is that when sudoing to 
> >> the shared user who manages the files the commands run should 
> >> be minimal and "pushd; ln -s ... .git; git pull; rm .git; 
> >> popd;" works well.  If I can replace this with something that 
> >> would populate these fields that would be awesome.
> >>
> >> I'm not completely sure about the setup, but something like
> >>
> >> GIT_DIR=fromthisrepo git archive usethisbranchortag |
> >> git tar -xf- -C thereyougo
> >>
> > Yes, that's about what the man page says.  I though I could 
> pass --keep-newer-files to tar and that would prevent files 
> from being re-created, but a "git archive --format=tar HEAD | 
> tar -tvv" indicates that every file has the current date/time 
> and not, for example, the time of the last commit that 
> modified that file.  Not only would pushing every file be 
> undesirable it would also cause every server to pull every 
> file and that's unacceptable.  Another down side, or perhaps 
> this is the downside, to this method is that it lacks any 
> form of merge capability and will destroy local changes.
> 
> I thought it's only a few files and you don't care about merging (in
> sudo), only about deploying a checkout, since you're removing 
> the git dir.
> 
Allow me to explain.  There was an issue with copying the .git folder to every host, we literally don't have the space for that and I wonder what happens when these files grow by a few hundred k.  I had put in the symlink, but our replicator script was chocking on it.  Thus I've resorted to not only using a symlink, but also removing it when not in use.  Correcting these issues is lower priority then making the logs have all the information they need.

Merging has been done when edits are needed ASAP and git becomes an after thought.  I've done pushes from the live files too, though it is something that happens after an emergency.

I know I've got a rather strange environment, most of it surprises me as well.

> > It looks like I'll be doing this in a hook.
> > 
> > BTW: I couldn't find "git tar", if it exists that might be 
> the way for me...  Depending on what it would do.
> 
> Oh yeah. Done too much git work lately. I know I keep using "git help
> foo" rather than "man foo", but this one is new :)
> 
> I just meant tar.
> 
> Michael
> 

Mike Mestnik, Michael J
The ESM Tools
Enterprise Systems Monitoring
United States Postal Service
 O: (651) 406-2048
Michael.J.Mestnik@usps.gov
ITEnterpriseSystemsMonitoring@usps.gov
 