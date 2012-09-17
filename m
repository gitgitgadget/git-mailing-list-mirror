From: "Mestnik, Michael J - Eagan, MN - Contractor" 
	<Michael.J.Mestnik@usps.gov>
Subject: RE: Using Format/export-subst Howto.
Date: Mon, 17 Sep 2012 07:12:55 -0500
Message-ID: <84EA18831601B6429E578236AE239B01A5498B52A3@EAGNMNSXMB07.usa.dce.usps.gov>
References: <84EA18831601B6429E578236AE239B01A54807F242@EAGNMNSXMB07.usa.dce.usps.gov>
 <50532B35.9050607@drmicha.warpmail.net> <5053480E.2010002@viscovery.net>
 <84EA18831601B6429E578236AE239B01A54807F376@EAGNMNSXMB07.usa.dce.usps.gov>
 <50534FC6.2040207@viscovery.net>
 <1347656962.3998.140661128069097.6D9BE3C4@webmail.messagingengine.com>
 <7vfw6k2t8w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 14:28:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDaQs-0001lX-VR
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 14:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756194Ab2IQM2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 08:28:01 -0400
Received: from mailwest1.usps.gov ([56.0.84.21]:57694 "EHLO
	mailwest16.srvs.usps.gov" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756161Ab2IQM2A convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 08:28:00 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2012 08:28:00 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=usps.gov; s=uspsgov0913; c=relaxed/simple;
	q=dns/txt; i=@usps.gov; t=1347883978; x=1351771978;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=duWhidi+JuHQdPHbc/TbzSgW7amAi/czJNmoItyYdRQ=;
	b=RA+mU1YLRBAVX/Vr0GhF7JdSXPfXrG26y7LaBLJJV6+slOp2TUVMDSlAROs0435q
	Pc+kKRUckV0xfBQXF9DSpgAQyET/ZkgXmWfGHdMan62tbR95F8a1pa5YvLav8hiV
	6VTlz1uT21DKae5jkRYWurZRMipG8TnN19VYOx5eH3s=;
Received: from mailrelay-w2.srvs.usps.gov (mailrelay2-w.usps.gov [56.224.66.107])
	by mailwest16.srvs.usps.gov (Sendmail 8.14.3) with SMTP id 39.D0.25969.AC317505; Mon, 17 Sep 2012 07:12:58 -0500 (CDT)
X-AuditID: 38005410-b7f606d000006571-a1-505713ca7f3c
Received: from EAGNMNSXMHC05.usa.dce.usps.gov (EAGNMNSXMHC05.usa.dce.usps.gov [56.207.244.215])
	by mailrelay-w2.srvs.usps.gov (Symantec Messaging Gateway) with SMTP id 66.36.12388.AC317505; Mon, 17 Sep 2012 07:12:58 -0500 (CDT)
Received: from EAGNMNSXMB07.usa.dce.usps.gov ([169.254.1.68]) by
 EAGNMNSXMHC05.usa.dce.usps.gov ([56.207.244.215]) with mapi; Mon, 17 Sep 2012
 07:12:57 -0500
Thread-Topic: Using Format/export-subst Howto.
Thread-Index: Ac2Sv0QndUUAXcUaTnKrKdw08wD9kQCDPGKw
In-Reply-To: <7vfw6k2t8w.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsViwRCirXtKODzAYMY2UYs1L04zW3Rd6Way
	aOi9wmyx8meNA4tH6+RJzB4XLyl7fN4k53H3/06mAJYobpukxJKy4Mz0PH27BO6M/0ubWQrm
	81a8eX+WrYHxMFcXIyeHhICJxNH3XxkhbDGJC/fWs3UxcnEICZxilOj6+5wFpmjX2dmsEImn
	jBLvDk5khnAWMkr8nj+XGaSKTSBIYs2nfWwgtohAqMTnTTvB4swC4RJ3JrWwdzFycLAIqErM
	alMHCQsL6Er0Nn5mgijXk7i//QYrhG0kcfz/AbBWXoEwiZ4fO8HiQgJtzBKnP5qD2JwCZhKL
	t1wHizMCXf391BomiFXiEreezGeCOFpAYsme88wQtqjEy8f/oOpFJe60r2eEqNeRWLD7ExuE
	rS2xbOFrqL2CEidnPmEB+VFC4D2bxJZHM+BB9GHJNqYJjFKzkOybhWTWLCSzZiGZtYCRZRWj
	RHq2brluam5iZo5ecVFZsV5pcUGxXnp+2SZGSDQL7GA8fEvxEKMAB6MSD6/hpLAAIdbEsuLK
	3EOMEhzMSiK8twXCA4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzljwLDBASSE8sSc1OTS1ILYLJ
	MnFwggguqQbGPWoPt/oEFjic/5McaG+5uy7ie8MprmJnlzUcV5Xl58rLm7M0mP6t+HCy4aGh
	1sYlndZTdDOqfqzfO+Oqd8kX/cB1Pw5YnH2vvJhZ72fP6peHLytxsWZMv83PfCrU7+CNWcaq
	n0Jl9GL+86z1avfWNV12bDnrNp2N6Yf1NAwN/Iz/8sY3TKlUYinOSDTUYi4qTgQA 
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVicf7Ldd1TwuEBBv/v8FiseXGa2aLrSjeT
	RUPvFWaLlT9rHFg8WidPYva4eEnZ4/MmOY+7/3cyBbBEcdmkpOZklqUW6dslcGX8X9rMUjCf
	t+LN+7NsDYyHuboYOTkkBEwkdp2dzQphi0lcuLeerYuRi0NI4CmjxLuDE5khnIWMEr/nz2UG
	qWITCJJY82kfG4gtIhAq8XnTTrA4s0C4xJ1JLexdjBwcLAKqErPa1EHCwgK6Er2Nn5kgyvUk
	7m+/wQphG0kc/38ArJVXIEyi58dOsLiQQBuzxOmP5iA2p4CZxOIt18HijEDHfT+1hglilbjE
	rSfzmSCOFpBYsuc8M4QtKvHy8T+oelGJO+3rGSHqdSQW7P7EBmFrSyxb+Bpqr6DEyZlPWCYw
	is1CMnYWkpZZSFpmIWlZwMiyilEqNzEzpyg1J7FSt9xIr7iorFivtLigWC89v2wTIyjWHjhl
	7WA8+lv3EKMAB6MSD2/HlLAAIdbEsuLK3EOMEhzMSiK8twXCA4R4UxIrq1KL8uOLSnNSiw8x
	SnOwKInzvvB1CxASSE8sSc1OTS1ILYLJMnFwSjUwmpbndFjw/pnKnV1ZtfBVekxapJz/8v23
	THWyTLRtZE0ZshfM7NHtqJ0sbFV4v0TVpj5qR7FzubnRgd8n8kxuvfMVvbz54//Nb+o6QmuY
	mY6f/NVis4Yn8pK1aiULs9qqs2v2/y4RS9zbMmGeb8eN5+/vHvz4zXeOdO3JaKXbZ890zZ3y
	4oaqEktxRqKhFnNRcSIACKI5x7ECAAA=
X-CFilter-Loop: DLP SM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205681>


> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com] 
> Sent: Friday, September 14, 2012 4:24 PM
> To: Michael J Gruber
> Cc: Johannes Sixt; Mestnik, Michael J - Eagan, MN - 
> Contractor; git@vger.kernel.org
> Subject: Re: Using Format/export-subst Howto.
> 
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> > you need to "rm file && git checkout file"). If the user 
> has to update
> > $Id$ to match the current sha1
> > (by remembering to do a more forceful checkout than 
> checkout -f) then
> > one half of that feature is useless. 
> 
> As if there is any value in "$Id$" _feature_.  It's a checkbox item,
> nothing more ;-).
> 

I agree here, $Id$ is much more useful in rcs/cvs.  That's why I chose to dive into export-subst, because I wanted my output to not only contain the uniq Id of the script but also the time and user of the last edit.

I'm going to read up on export today.  Just for context I'm using git to manage daily cron scripts, run on about 1,000 hosts, located on NFS.  I've moved the editing of the scripts into user's home directories as I'm a fan of not using editors on live data.  The key point is that when sudoing to the shared user who manages the files the commands run should be minimal and "pushd; ln -s ... .git; git pull; rm .git; popd;" works well.  If I can replace this with something that would populate these fields that would be awesome.

Cheers.

Mike Mestnik, Michael J
The ESM Tools
Enterprise Systems Monitoring
United States Postal Service
 O: (651) 406-2048
Michael.J.Mestnik@usps.gov
ITEnterpriseSystemsMonitoring@usps.gov
 