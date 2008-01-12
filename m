From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Sat, 12 Jan 2008 18:03:24 +0300
Message-ID: <20080112150324.GF2963@dpotapov.dyndns.org>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org> <200801120026.01930.robin.rosenberg@dewire.com> <1973E1D5-C8CC-4979-A085-85A2C5A13E57@sb.org> <200801120115.41274.robin.rosenberg@dewire.com> <191B60D7-FD89-48D8-8D48-C91645D4814D@sb.org> <7v7iif28i2.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801120139170.8333@wbgn129.biozentrum.uni-wuerzburg.de> <B2968E86-D43E-4F5E-921F-DF8A15886C98@sb.org> <7vprw7zv7s.fsf@gitster.siamese.dyndns.org> <08E42D03-7AAA-4ADD-9F5B-215AB30E34E1@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 16:04:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDhtz-0002Na-IP
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 16:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759454AbYALPD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 10:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758236AbYALPD0
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 10:03:26 -0500
Received: from smtp03.mtu.ru ([62.5.255.50]:51978 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757915AbYALPD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 10:03:26 -0500
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id 6062218711E0;
	Sat, 12 Jan 2008 18:03:24 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-140-170-195.pppoe.mtu-net.ru [85.140.170.195])
	by smtp03.mtu.ru (Postfix) with ESMTP id 43A191871226;
	Sat, 12 Jan 2008 18:03:24 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JDhtM-000438-5z; Sat, 12 Jan 2008 18:03:24 +0300
Content-Disposition: inline
In-Reply-To: <08E42D03-7AAA-4ADD-9F5B-215AB30E34E1@sb.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70321>

On Fri, Jan 11, 2008 at 08:43:35PM -0500, Kevin Ballard wrote:
> 
> Fair enough, though I believe OS X has a good reason, namely it's an  
> OS designed for regular users rather than servers or programmers. Case- 
> sensitivity would confuse my mother.

Many of *nix servers are running web-services and samba servers, yet most
users are even not aware of whether they dealing with case-sensitive file
system or not, let alone being confused by that. This is because most
regular users will type the name only once when they create a new file
and then just click on this name. So case-sensitive file systems can
really confuse only some badly written applications...

Dmitry
