From: "Mestnik, Michael J - Eagan, MN - Contractor" 
	<Michael.J.Mestnik@usps.gov>
Subject: RE: Using Format/export-subst Howto.
Date: Fri, 14 Sep 2012 11:05:03 -0500
Message-ID: <84EA18831601B6429E578236AE239B01A54807F3BE@EAGNMNSXMB07.usa.dce.usps.gov>
References: <84EA18831601B6429E578236AE239B01A54807F242@EAGNMNSXMB07.usa.dce.usps.gov>
 <50532B35.9050607@drmicha.warpmail.net> <5053480E.2010002@viscovery.net>
 <84EA18831601B6429E578236AE239B01A54807F376@EAGNMNSXMB07.usa.dce.usps.gov>
 <50534FC6.2040207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Sep 14 18:20:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCYcx-0004aV-U3
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 18:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab2INQUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 12:20:13 -0400
Received: from mailwest2.usps.gov ([56.0.84.22]:47883 "EHLO
	gk-w2-email.srvs.usps.gov" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752607Ab2INQUK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 12:20:10 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Sep 2012 12:20:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=usps.gov; s=uspsgov0913; c=relaxed/simple;
	q=dns/txt; i=@usps.gov; t=1347638709; x=1351526709;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z56zEP1RU+Eism8OvJ98XFjGXhF+UrY1XWG4+POeZOY=;
	b=IKzh0nk+dZfERXRBnLJD5bXOC6g9FLUr82Z1yaoCl2Yp/92zrwjEGxrRkbngvcai
	XLaKFKkloG0mDFF06EW75iaXDI0rZOlr96+0bCUnBoj+wpmF9eEdM5FCopd7VrOp
	+ap+ZUM2Xms0EJ4tbSG50UCN8FP8WDHnfud0g4VwAP4=;
Received: from mailrelay-w3i.usps.gov (Unknown_Domain [56.224.66.58])
	by gk-w2-email.srvs.usps.gov (Sendmail 8.14.3) with SMTP id 77.23.05889.4B553505; Fri, 14 Sep 2012 11:05:08 -0500 (CDT)
X-AuditID: 38005411-b7f806d000001701-59-505355b4360f
Received: from EAGNMNSXMHC07.usa.dce.usps.gov (EAGNMNSXMHC07.usa.dce.usps.gov [56.207.244.217])
	by mailrelay-w3i.usps.gov (Symantec Messaging Gateway) with SMTP id 0A.C5.03288.7E553505; Fri, 14 Sep 2012 09:05:59 -0700 (PDT)
Received: from EAGNMNSXMB07.usa.dce.usps.gov ([169.254.1.98]) by
 EAGNMNSXMHC07.usa.dce.usps.gov ([56.207.244.217]) with mapi; Fri, 14 Sep 2012
 11:05:05 -0500
Thread-Topic: Using Format/export-subst Howto.
Thread-Index: Ac2Sj17bQxSODWC4QX2j+q+W4oIAMwAAvcPQ
In-Reply-To: <50534FC6.2040207@viscovery.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsViwRCirbslNDjA4NAfNYs1L04zW3Rd6Way
	WPmzxoHZo3XyJGaPz5vkPO7+38kUwBzFbZOUWFIWnJmep2+XwJ2xa/8bxoJ2gYoT3YfYGhjv
	83QxcnJICJhIzJhynBHCFpO4cG89G4gtJLCfUWLSfn6YmtOXJ7F0MXIBxR8ySlxYfp8ZwlkI
	5Ez4zwpSxSYQJLHm0z6wbhEBDYndp3vZuxg5OJgF4iSmHRUFMVkEVCUeT0wBqRAW0JXobfzM
	BFGtJ3F/+w1WkBIRASOJbWejQcK8AmESE95fhdo0kUni2LKVzCAJTqDeeXvugd3MCHTz91Nr
	wOYwC4hL3HoynwniZgGJJXvOM0PYohIvH/9jhagXlbjTvp4Rol5HYsHuT2wQtrbEsoWvmSEW
	C0qcnPkE7F8JgftsEqdm9zLDAujDkm1MExilZiHZNwvJrFlIZs1CMmsBI8sqRsn0bN1yI93U
	3MTMHL3iorJivdLigmK99PyyTYyQyBXcwdh/VfcQowAHoxIPb8C/wAAh1sSy4srcQ4wSHMxK
	Iry22kEBQrwpiZVVqUX58UWlOanFhxilOViUxHnLnwFVC6QnlqRmp6YWpBbBZJk4OEEEl1QD
	o53uv+ZHXjMmrjoel8R4t/vEsl/7indKxOkfY4pdc+K0ztJjc7jVkz57bZVbN8vuNnvU9piS
	GzXTeu8dsS107JZiE/As2srrVPrw5sNJXke+X71j9kSkcNrO94oh7TGMKwVblVeaX/9SaHnu
	0y7NIrbn8Wm+om+yFu1TZpTf+cv+7grrpc+M3iixFGckGmoxFxUnAgDhv3n43QIA 
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsVicf7LTd3nocEBBmf/qluseXGa2aLrSjeT
	xcqfNQ7MHq2TJzF7fN4k53H3/06mAOYoLpuU1JzMstQifbsEroxd+98wFrQLVJzoPsTWwHif
	p4uRk0NCwETi9OVJLBC2mMSFe+vZuhi5OIQEHjJKXFh+nxnCWQjkTPjPClLFJhAksebTPjYQ
	W0RAQ2L36V72LkYODmaBOIlpR0VBTBYBVYnHE1NAKoQFdCV6Gz8zQVTrSdzffoMVpEREwEhi
	29lokDCvQJjEhPdXoTZNZJI4tmwlM0iCE6h33p57jCA2I9Bt30+tAZvDLCAucevJfCaImwUk
	luw5zwxhi0q8fPyPFaJeVOJO+3pGiHodiQW7P7FB2NoSyxa+ZoZYLChxcuYTlgmMYrOQjJ2F
	pGUWkpZZSFoWMLKsYhTLTczMKUrNSazULTfO1CstLijWS88v28QIiqcHTkY7GG89ND/EKMDB
	qMTDu4E9KECINbGsuDL3EKMEB7OSCK+tNlCINyWxsiq1KD++qDQntfgQozQHi5I4r5SfW4CQ
	QHpiSWp2ampBahFMlomDU6qBkWU9xyUBBrZS85XHjVuPPSzNWxbjd4/DY88L278rPilGqT2f
	xDzrF4/e9aUbDqyIEFz3VVOWa1GgdeHmq+dvFunv3dKcsVDrQavj3V+ZAjdVX52avTFb2dJm
	lo567be1u0N7WY4tkNP/+OK+cfATy6qwbZ7Cls0TanvON3g/an+RILZ63tr3JUosxRmJhlrM
	RcWJAHhFTlWjAgAA
X-CFilter-Loop: DLP SM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205498>


> -----Original Message-----
> From: Johannes Sixt [mailto:j.sixt@viscovery.net] 
> Sent: Friday, September 14, 2012 10:40 AM
> To: Mestnik, Michael J - Eagan, MN - Contractor
> Cc: Michael J Gruber; git@vger.kernel.org
> Subject: Re: Using Format/export-subst Howto.
> 
> Am 9/14/2012 17:27, schrieb Mestnik, Michael J - Eagan, MN - 
> Contractor:
> > 
> >> -----Original Message----- From: Johannes Sixt
> >> If EOL conversion or a clean filter was applied during 'git add
> >> file', is the version in the worktree suddenly wrong? Of course,
> >> not.
> >> 
> >> I would place $Id$ treatment in the same ball park and 
> declare it as
> >> a mistake of the editor that it did not remove the now "wrong" SHA1
> >> from $Id:$.
> > 
> > I think the difference here is that git does not *currently 
> change the
> > OS's LEF.  In this case each commit alters the Id and git is the one
> > altering the Id.
> 
> Maybe you misunderstood $Id$? The value you get there is the 
> blob's SHA1,
> not the commit's. That is, it does not change on every 
> commit, but only
> when the file changes.
> 
> You are right that the value itself is something that is 
> dictated by git's
> database model, but the change logically happens when the 
> editor modifies
> the file.
> 
> (My contribution to this thread should be regarded as food 
> for thought.
> Personally, I don't mind whether or not and when $Id$ is updated.)
>
Thank you for correcting me, I've always noticed this number doesn't seam to correlate to anything of use for me.  However it's been helpful when reading these reports to see what version generated it and that's why I wanted to further expand the information provided...  The date and time of the commit are specifically useful to me.

> -- Hannes
> 



Mike Mestnik, Michael J
The ESM Tools
Enterprise Systems Monitoring
United States Postal Service
 O: (651) 406-2048
Michael.J.Mestnik@usps.gov
ITEnterpriseSystemsMonitoring@usps.gov
 