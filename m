From: "Philippe Ombredanne" <philippe@easyeclipse.org>
Subject: RE: [ANNOUNCE] Java Git (aka jgit) has switched to 3-clause BSD
Date: Mon, 9 Jun 2008 18:15:06 -0800
Message-ID: <027101c8ca9f$cd68afe0$1e01a8c0@computer>
References: <200806092139.58485.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "'Dave Watson'" <dwatson@mimvista.com>,
	"'Marek Zawirski'" <marek.zawirski@gmail.com>,
	<git@vger.kernel.org>
To: "'Robin Rosenberg'" <robin.rosenberg@dewire.com>,
	"'Shawn O. Pearce'" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 03:18:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5sUs-0001x0-Uc
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 03:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbYFJBRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 21:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753223AbYFJBRE
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 21:17:04 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:34524 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbYFJBRC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jun 2008 21:17:02 -0400
Received: from randymail-a5.g.dreamhost.com (sd-green-bigip-81.dreamhost.com [208.97.132.81])
	by hapkido.dreamhost.com (Postfix) with ESMTP id A293517AAFE
	for <git@vger.kernel.org>; Mon,  9 Jun 2008 18:17:00 -0700 (PDT)
Received: from computer (dsl017-042-218.sfo1.dsl.speakeasy.net [69.17.42.218])
	by randymail-a5.g.dreamhost.com (Postfix) with ESMTP id E85B490DA0;
	Mon,  9 Jun 2008 18:15:27 -0700 (PDT)
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <200806092139.58485.robin.rosenberg@dewire.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84467>

Robin:
I can check the commit message. If you have a seprate archive of the meails
that woudl help too .



-- 
Cheers
Philippe

philippe ombredanne | 1 650 799 0949 | pombredanne at nexb.com 
nexB - Open by Design (tm) - http://www.nexb.com 
http://easyeclipse.org - http://phpeclipse.net - http://eclipse.org/atf - 
http://eclipse.org/vep - http://labs.jboss.org/drools/ -
http://developer.mozilla.org/en/docs/XULRunner


> -----Original Message-----
> From: Robin Rosenberg [mailto:robin.rosenberg@dewire.com] 
> Sent: Monday, June 09, 2008 11:40 AM
> To: Shawn O. Pearce
> Cc: Dave Watson; Marek Zawirski; git@vger.kernel.org; 
> Philippe Ombredanne
> Subject: Re: [ANNOUNCE] Java Git (aka jgit) has switched to 
> 3-clause BSD
> 
> 
> Hi, all
> 
> I've got confirmation from all needed parties and pushed the 
> license changes to master. 
> See 
> http://repo.or.cz/w/egit.git?a=commit;h=2baa6eb54706926f74d8ca
5a10c7f0448acb5fe6
and
http://repo.or.cz/w/egit.git?a=commit;h=53a2cc3f6144ddcc10954d3abf68a5b90ed9
5248

The changes plus some fixes to the fetch code has been merged and pushed to
master.

Philippe, It would be nice if you could check to see that the licensing
looks ok. We can hand
over the complete e-mail messages separately from the commit comments.

I think we need to complement the UI for fetch plus and couple other fixes
and do more testing befire
bumping the revision number. 

-- robin
