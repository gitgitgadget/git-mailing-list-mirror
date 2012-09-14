From: "Mestnik, Michael J - Eagan, MN - Contractor" 
	<Michael.J.Mestnik@usps.gov>
Subject: RE: Using Format/export-subst Howto.
Date: Fri, 14 Sep 2012 10:27:25 -0500
Message-ID: <84EA18831601B6429E578236AE239B01A54807F376@EAGNMNSXMB07.usa.dce.usps.gov>
References: <84EA18831601B6429E578236AE239B01A54807F242@EAGNMNSXMB07.usa.dce.usps.gov>
 <50532B35.9050607@drmicha.warpmail.net> <5053480E.2010002@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 14 17:42:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCY2S-000414-1G
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 17:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758708Ab2INPmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 11:42:31 -0400
Received: from maileast16.srvs.usps.gov ([56.0.103.16]:63351 "EHLO
	maileast16.srvs.usps.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757859Ab2INPma convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 11:42:30 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Sep 2012 11:42:30 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=usps.gov; s=uspsgov0913; c=relaxed/simple;
	q=dns/txt; i=@usps.gov; t=1347636448; x=1351524448;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S8WAD2GQVv25q98VM7v3IlaeiIHKddeWNcQNcEno+40=;
	b=jsiPUqInmqfLYGYeipkDAhuVigh/VUledi6E7J8eMKQ8AOGDgJr0D1Wm6F7dUjEU
	v6j+lB5O9xpxMStxn6qqyzjFLd4dIBSmB8TZiFxzvthPB4stJhpd4Qt/im8xHIqx
	4/mD6gX7J/n8GXu9Lq2u9ms7ljxxMHJakrLWrPDz1rE=;
Received: from mailrelay-c2i.usps.gov (Unknown_Domain [56.207.40.245])
	by maileast16.srvs.usps.gov (Sendmail 8.14.3) with SMTP id AF.6C.02071.0EC43505; Fri, 14 Sep 2012 10:27:28 -0500 (CDT)
X-AuditID: 38006708-b7f816d000000817-2b-50534ce0b752
Received: from EAGNMNSXMHC01.usa.dce.usps.gov (EAGNMNSXMHC01.usa.dce.usps.gov [56.207.244.211])
	by mailrelay-c2i.usps.gov (Symantec Messaging Gateway) with SMTP id 8C.DF.23422.FDC43505; Fri, 14 Sep 2012 10:27:28 -0500 (CDT)
Received: from EAGNMNSXMB07.usa.dce.usps.gov ([169.254.1.98]) by
 EAGNMNSXMHC01.usa.dce.usps.gov ([56.207.244.211]) with mapi; Fri, 14 Sep 2012
 10:27:27 -0500
Thread-Topic: Using Format/export-subst Howto.
Thread-Index: Ac2SiqNafErsNNzjRVmf60tYXOzAigAAabJg
In-Reply-To: <5053480E.2010002@viscovery.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsViwZCurfvAJzjAoPOqvMWaF6eZLbqudDNZ
	rPxZ48Ds0Tp5ErPH501yHnf/72QKYI7itklKLCkLzkzP07dL4M7YNnsFa8FC4YpVP7MaGGfy
	dzFyckgImEjM39nICmGLSVy4t54NxBYS2M8osbq1rouRA6xmxZ2yLkYuoPBDRomX36ayQDgL
	GSXmnt3LDtLAJhAksebTPrBmEYFwifXLz4ANZRbQl/j05wATiM0ioCrRPeE1M4gtLKAr0dv4
	mQmiXk/i/vYbrBC2kcS8I9/BZvIKhEncftPMCrfs3P7FYEWcQM3nO46DLWMEuvr7qTVMEMvE
	JW49mc8E8Y2AxJI955khbFGJl4//sULUi0rcaV/PCFGvI7Fg9yc2CFtbYtlCiON4BQQlTs58
	AvalhMBtNombO74yw4Jo3pNXzBMYpWYh2TcLyaxZSGbNQjJrASPLKkaJ9GzdVN3U3MTMHL3i
	orJivdLigmK99PyyTYyQyOXYwfh9j+IhRgEORiUeXg6uoAAh1sSy4srcQ4wSHMxKIry22kAh
	3pTEyqrUovz4otKc1OJDjNIcLErivLnPAgOEBNITS1KzU1MLUotgskwcnCCCS6qBMfmx8ypm
	Nv/1NssnbL/xzohvffJDZ32ZQuE0g5jXBbJsB+4liGcKyuxtd/hvrt24Xf6BehFvt3ue4MSA
	LL677wtWrY5tWf/zYLGe0F2DtDlsWz5WqgjZ/5wUw3tgrg03wxO1YjXTz62P4jZzn44LVFVR
	nTZj6tqlwvZOCZoXnh0Ki/2UuphfiaU4I9FQi7moOBEAG044rt0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsVicf7LZd0HPsEBBvO3MVmseXGa2aLrSjeT
	xcqfNQ7MHq2TJzF7fN4k53H3/06mAOYoLpuU1JzMstQifbsEroxts1ewFiwUrlj1M6uBcSZ/
	FyMHh4SAicSKO2VdjJxAppjEhXvr2boYuTiEBB4ySrz8NpUFwlnIKDH37F52kCo2gSCJNZ/2
	sYHYIgLhEuuXn2EFsZkF9CU+/TnABGKzCKhKdE94zQxiCwvoSvQ2fmaCqNeTuL/9BiuEbSQx
	78h3sJm8AmESt980s8ItO7d/MVgRJ1Dz+Y7jYMsYgc77fmoNE8QycYlbT+YzQZwtILFkz3lm
	CFtU4uXjf6wQ9aISd9rXM0LU60gs2P2JDcLWlli2EOI4XgFBiZMzn7BMYBSbhWTsLCQts5C0
	zELSsoCRZRWjWG5iZk5Rak5ipW6yUaZeaXFBsV56ftkmRnBEabzdwbj1vvkhRgEORiUe3oB/
	gQFCrIllxZW5hxglOJiVRHhttYMChHhTEiurUovy44tKc1KLDzFKc7AoifPe8XULEBJITyxJ
	zU5NLUgtgskycXBKNTAeSfjI/PXfOVVmrpC4k8vSLXS+LvsUrzvHaLOQxKN7s9dwNBzedDj0
	UNEEX+9NF+3l9RMWrjNOT5CtmBFZuVTuds+HXRJ6tcvZV71cWfek9UlL+EG+Wd/e/51rkLos
	xD17x6ZHLVcjYjef0mRUTfpz/f5WG7uriTuYV36qYD28lftx4P5/tldTlViKMxINtZiLihMB
	rtR5iKQCAAA=
X-CFilter-Loop: DLP RL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205495>


> -----Original Message-----
> From: Johannes Sixt [mailto:j.sixt@viscovery.net] 
> Sent: Friday, September 14, 2012 10:07 AM
> To: Michael J Gruber
> Cc: Mestnik, Michael J - Eagan, MN - Contractor; git@vger.kernel.org
> Subject: Re: Using Format/export-subst Howto.
> 
> Am 9/14/2012 15:03, schrieb Michael J Gruber:
> > "git replaces $Id$... upon checkout.  Any byte sequence that begins
> > with $Id: and ends with $ in the worktree file is replaced with $Id$
> > upon check-in."
> > 
> > Now, the there are two problems after you add $Id$ and check-in
> > (commit):
> > 
> > - commit does not check out, i.e. your work-tree copy is 
> not updated 
> > with expanded $Id$ - Not even "git checkout thatFile" updates your
> > work-tree copy.
> > 
> > The first one could be considered OK, but at least the second one
> > seems to be a bug. Together they create the following problem: Say,
> > you've corrected that problem (rm that file and checkout) and then
> > update your file, add and commit. It will keeping having 
> the old (now
> > wrong) Id expansion.
> 
> If EOL conversion or a clean filter was applied during 'git 
> add file', is
> the version in the worktree suddenly wrong? Of course, not.
> 
> I would place $Id$ treatment in the same ball park and declare it as a
> mistake of the editor that it did not remove the now "wrong" 
> SHA1 from $Id:$.

I think the difference here is that git does not *currently change the OS's LEF.  In this case each commit alters the Id and git is the one altering the Id.  If git did change the expected/system LEF then it would seam reasonable that it would also be responsible for forward porting files to the new regime.

* If git could fix some misguided operating systems into following the correct LEF, that would be great!

What I mean is that I agree that git is not the tool to tackle every technical challenge, but I think it should carry though with any decisions it makes and that it should not ignore the effects(or changes) made as a result of **these decisions.

** Any and all, within reason.

Cheers!

> 
> > We should do something about this.
> 
> Not necessary, IMHO.
> 
> -- Hannes
> 



Mike Mestnik, Michael J
The ESM Tools
Enterprise Systems Monitoring
United States Postal Service
 O: (651) 406-2048
Michael.J.Mestnik@usps.gov
ITEnterpriseSystemsMonitoring@usps.gov
 