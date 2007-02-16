From: James Cloos <cloos@jhcloos.com>
Subject: Re: [PATCH] Dissociating a repository from its alternates
Date: Fri, 16 Feb 2007 14:11:27 -0500
Message-ID: <m3wt2h3ojt.fsf@lugabout.jhcloos.org>
References: <7vabzfhn9q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 16 20:46:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI929-00026T-EV
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 20:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946055AbXBPTqM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 14:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946088AbXBPTqM
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 14:46:12 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:3314 "EHLO ore.jhcloos.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946055AbXBPTqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 14:46:09 -0500
X-Greylist: delayed 2043 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Feb 2007 14:46:09 EST
Received: from lugabout.jhcloos.org (ppp3.pm3-8.buf-ch.ny.localnet.com [69.48.11.195])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "lugabout.jhcloos.org", Issuer "ca.jhcloos.com" (verified OK))
	by ore.jhcloos.com (Postfix) with ESMTP id 5C7D11C57D
	for <git@vger.kernel.org>; Fri, 16 Feb 2007 13:12:01 -0600 (CST)
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 04ADB2205E4; Fri, 16 Feb 2007 19:11:50 +0000 (UTC)
X-Hashcash: 1:23:070216:git@vger.kernel.org::JUj1XV7F35zSm3pM:000000000000000000000000000000000000000000TbAJ
In-Reply-To: <7vabzfhn9q.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed\, 14 Feb 2007 23\:51\:13 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.0 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAMnRFWHRUaXRsZQAvbWF4dG9y
 L2Nsb29zL2luY29taW5nLzIwMDQvMDIvUFdHL0pIQzE2LnBuZyJMlEwAAAAadEVYdFNvZnR3YXJl
 AEdOT01FIEljb24gRWRpdG9ynioKbAAAAHFJREFUeJzFk8EKwCAMQ1/ED9cvzw6iuM0N9WIvDTWE
 1KjAxmKnLBEBjLcEIBCeI2nccy5YKrjxwbbvAvZ37zlo4GB9iRMC/cq/AppItwmMyJ5I98wd9G7P
 xxgrSKlYS2lMrOcV13o95aVSKA7E5ndGXG+IIzcl4BNfAAAAAElFTkSuQmCC
Copyright: Copyright 2006 James Cloos
X-Hashcash: 1:23:070216:junkio@cox.net::HPi2JA7pDTHab9ws:000PUId
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39943>

[ARGH; hit r rather than f; cc-ing the list. -JimC]

Wierd.

I was /just/ about to inquire on what the best method was for disassociating.

And then I read this thread.

Effective mind reading!  :)

WRT Johannes's followup, I presume it will re-use the alternate packs,
such that the computation is minimal?

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
