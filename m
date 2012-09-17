From: "Mestnik, Michael J - Eagan, MN - Contractor" 
	<Michael.J.Mestnik@usps.gov>
Subject: RE: Using Format/export-subst Howto.
Date: Mon, 17 Sep 2012 08:26:41 -0500
Message-ID: <84EA18831601B6429E578236AE239B01A5498B532F@EAGNMNSXMB07.usa.dce.usps.gov>
References: <84EA18831601B6429E578236AE239B01A54807F242@EAGNMNSXMB07.usa.dce.usps.gov>
 <50532B35.9050607@drmicha.warpmail.net> <5053480E.2010002@viscovery.net>
 <84EA18831601B6429E578236AE239B01A54807F376@EAGNMNSXMB07.usa.dce.usps.gov>
 <50534FC6.2040207@viscovery.net>
 <1347656962.3998.140661128069097.6D9BE3C4@webmail.messagingengine.com>
 <7vfw6k2t8w.fsf@alter.siamese.dyndns.org>
 <7v7grw2qcu.fsf@alter.siamese.dyndns.org>
 <505722DD.3000806@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 15:45:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDbdH-0008SQ-B3
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 15:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473Ab2IQNoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 09:44:55 -0400
Received: from mailwest2.usps.gov ([56.0.84.22]:49785 "EHLO
	gk-w2-email.srvs.usps.gov" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752532Ab2IQNox convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 09:44:53 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2012 09:44:53 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=usps.gov; s=uspsgov0913; c=relaxed/simple;
	q=dns/txt; i=@usps.gov; t=1347888592; x=1351776592;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rRYK1qBN9rcvIQLiQs+DKaVcxI1aLVdy7hfFoMSdyoE=;
	b=N88nOuU6zRytEesLLOHautP1vX/7maX6CQQSDQMcHqSOGyWDdaCpG++TtKkl5m3F
	qi1LKLNIUHpJuZWwbXEgFENpXserOIci41nBak02ulKvKsFqSLjJCXJ2Jryw1Xip
	A/Ge4DrO0OR3XuMP5DFtJLDFTnK9pUxtg2QL1CJP8NM=;
Received: from mailrelay-w2.srvs.usps.gov (mailrelay2-w.usps.gov [56.224.66.107])
	by gk-w2-email.srvs.usps.gov (Sendmail 8.14.3) with SMTP id 01.90.05889.31527505; Mon, 17 Sep 2012 08:26:43 -0500 (CDT)
X-AuditID: 38005411-b7f806d000001701-87-5057251305b3
Received: from EAGNMNSXMHC07.usa.dce.usps.gov (EAGNMNSXMHC07.usa.dce.usps.gov [56.207.244.217])
	by mailrelay-w2.srvs.usps.gov (Symantec Messaging Gateway) with SMTP id 67.89.12388.31527505; Mon, 17 Sep 2012 08:26:43 -0500 (CDT)
Received: from EAGNMNSXMB07.usa.dce.usps.gov ([169.254.1.68]) by
 EAGNMNSXMHC07.usa.dce.usps.gov ([56.207.244.217]) with mapi; Mon, 17 Sep 2012
 08:26:42 -0500
Thread-Topic: Using Format/export-subst Howto.
Thread-Index: Ac2U1sWo3IguvARtQVa/07HdL/b7WAAAEtnQ
In-Reply-To: <505722DD.3000806@drmicha.warpmail.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsViwRCirXteNTzA4OZ5c4s1L04zW3Rd6Way
	aOi9wmyx8meNA4tH6+RJzB4XLyl7fN4k53H3/06mAJYobpukxJKy4Mz0PH27BO6Mnm37WAtW
	q1as2/OTqYHxomwXIyeHhICJxIfjXxkhbDGJC/fWs3UxcnEICZxmlLiw+SozTNH8lYsYIRJP
	GSU+zHgGVbWQUWLmu4vsIFVsAkESaz7tYwOxRQRCJT42rQOLMwuES9yZ1AJmswioSrTNewBm
	CwvoSvQ2fmaCqNeTuL/9BiuEbSSx58pnMJtXIExi3dtGdohld5glTtybDZbgBDrpx8O5YMsY
	ge7+fmoNE8QycYlbT+YzQZwtILFkz3moF0QlXj7+xwpRLypxp309I0S9jsSC3Z/YIGxtiWUL
	XzNDLBaUODnzCQvIYgmB12wSj98dgQfShyXbmCYwSs1Csm8WklmzkMyahWTWAkaWVYyS6dm6
	5Ua6qbmJmTl6xUVlxXqlxQXFeun5ZZsYITEtuIOx/6ruIUYBDkYlHl6jSWEBQqyJZcWVuYcY
	JTiYlUR4bwuEBwjxpiRWVqUW5ccXleakFh9ilOZgURLnLX8WGCAkkJ5YkpqdmlqQWgSTZeLg
	BBFcUg2MMmsUnkeUXxP/v/62uCBH6Tt9oUnr2q9/9A7vcdJmyF+od3p6pbJO8omfDz77feRQ
	+t84c5FAQISosd2inq2ZdZt3Sn6ZoTxJmyP25XuhmC87nK71nLmpzTPL8TG39iq5e0z/s/an
	M84+r9x9U89aIunWYZOirvVXn1ScDszjyzwr4LktqzJKiaU4I9FQi7moOBEAOF1+ 
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVicf7LTV1h1fAAg6afXBZrXpxmtui60s1k
	0dB7hdli5c8aBxaP1smTmD0uXlL2+LxJzuPu/51MASxRXDYpqTmZZalF+nYJXBk92/axFqxW
	rVi35ydTA+NF2S5GTg4JAROJ+SsXMULYYhIX7q1n62Lk4hASeMoo8WHGMyhnIaPEzHcX2UGq
	2ASCJNZ82scGYosIhEp8bFoHFmcWCJe4M6kFzGYRUJVom/cAzBYW0JXobfzMBFGvJ3F/+w1W
	CNtIYs+Vz2A2r0CYxLq3jewQy+4wS5y4NxsswQl03o+Hc8GWMQKd9/3UGiaIZeISt57MZ4I4
	W0BiyZ7zzBC2qMTLx/9YIepFJe60r2eEqNeRWLD7ExuErS2xbOFrZojFghInZz5hmcAoNgvJ
	2FlIWmYhaZmFpGUBI8sqRqncxMycotScxErdciO94qKyYr3S4oJivfT8sk2MoHh74JS1g/Ho
	b91DjAIcjEo8vB1TwgKEWBPLiitzDzFKcDArifDeFggPEOJNSaysSi3Kjy8qzUktPsQozcGi
	JM77wtctQEggPbEkNTs1tSC1CCbLxMEp1cBoaeLyoMxnadT1Q1H2PO9Np1y632Qrmjcj/0ff
	ohCJ/N4l1m1R73UfiK/p1l/VEB3lynVcyHfGsWVZkQJ6WQe/LF/DUraqNIm7p539Zu/prlMP
	p85+xPN1Sal4ve4pX0YtW33XpK1XnsbLBBu/zPlan1s31Wz+t9aQV1EzrIU4beenuHK78iix
	FGckGmoxFxUnAgBRuVmoswIAAA==
X-CFilter-Loop: DLP SM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205688>


> -----Original Message-----
> From: Michael J Gruber [mailto:git@drmicha.warpmail.net] 
> Sent: Monday, September 17, 2012 8:17 AM
> To: Junio C Hamano
> Cc: Johannes Sixt; Mestnik, Michael J - Eagan, MN - 
> Contractor; git@vger.kernel.org
> Subject: Re: Using Format/export-subst Howto.
> 
> Junio C Hamano venit, vidit, dixit 14.09.2012 23:23:
> > Michael J Gruber <git@drmicha.warpmail.net> writes:
> > 
> >> you need to "rm file && git checkout file"). If the user has to
> >> update $Id$ to match the current sha1 (by remembering to do a more
> >> forceful checkout than checkout -f) then one half of that feature
> >> is useless.
> > 
> > As if there is any value in "$Id$" _feature_.  It's a 
> checkbox item, 
> > nothing more ;-).
> 
> It's your favorite feature^Wcheckbox item, I know ;)
> 
> I wouldn't mind dropping it or making it export-only, but the current
> state of that item is quite confusing. I seem to remember 
> this has been
> brought up before.
> 
> Junio C Hamano venit, vidit, dixit 15.09.2012 00:26:
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> >> Michael J Gruber <git@drmicha.warpmail.net> writes:
> >> 
> >>> you need to "rm file && git checkout file"). If the user has to
> >>> update $Id$ to match the current sha1 (by remembering to do a
> >>> more forceful checkout than checkout -f) then one half of that
> >>> feature is useless.
> >> 
> >> As if there is any value in "$Id$" _feature_.  It's a checkbox
> >> item, nothing more ;-).
> > 
> > Having said that, I think you could do something along this line (I 
> > am thinking aloud, so there may be leaps in the logic below).
> > 
> > * Introduce a new on-disk flag in the index.  Call it X.  After 
> > entry.c:write_entry() writes it out to the working tree, 
> this flag is
> > cleared.  And this codepath is the only place that clears this flag.
> > 
> > * When applying a clean filter (from here on, everything that breaks
> > byte-for-byte identity between the copy on the working tree and the
> > contents that is hashed and stored in the object store are 
> considered
> > "clean filter", including CRLF->LF and ident), internally apply the
> > corresponding smudge filter to the cleaned result and 
> compare it with
> > the original input we obtained from the working tree.  If they
> > differ, flip the X bit on for the path in the index.
> > 
> > * When "checkout" and any potential callers of write_entry() decide 
> > whether it is worth calling write_entry() [*1*], consider any path
> > with the X bit on as "dirty" and call write_entry().
> > 
> > You have to be very careful when designing the third point, though. 
> > There will now be two kinds of "the working tree file is different 
> > from the version registerd in the index" once you do the above. 
> > Different only because of "clean->smudge" roundtrip comparison, and 
> > different because it does have a real local modification.  
> The former
> > must be considered "no local modification" for the purpose of merges
> > and branch switching (otherwise you will get "cannot merge, you have
> > local modifications" error).
> > 
> > 
> > [Footnote]
> > 
> > *1* This currently is done primarily with ie_match_stat(), that 
> > essentially is "Does the result of applying 'clean' to the working 
> > tree contents match what is registered to the index?  Do not bother 
> > doing this check over and over again once you checked this until the
> > file in the working tree is modified again".
> > 
> 
> You've convinced me not to try this in-core...
> 
> Maybe a post-commit hook is enough for Id. It's just that we also have
> no in-core way of doing a forceful enough checkout on those 
> files. But I
> wouldn't mind making Id export-only (export-subst). Really, 
> most people
> who look at Id really want something like VERSION_GEN 
I'm just reporting that I didn't think Id was behaving as it should in my working folder, this is of no consequence for me.  After git pull, AFAIK, the Id has the correct/new value if the file has changed.

> (without having to
> use a build script/make/...).
> 
> Michael
> 

I would not be opposed to going the build script/make route, if I could do it in a hook.  I'm using git to produce the final product in my case, I don't want this live folder to be used as a temporary place for doing builds.  I guess I'm looking for behavior similar to install.

Cheers.

Mike Mestnik, Michael J
The ESM Tools
Enterprise Systems Monitoring
United States Postal Service
 O: (651) 406-2048
Michael.J.Mestnik@usps.gov
ITEnterpriseSystemsMonitoring@usps.gov
 