From: Bill Lear <rael@zopyra.com>
Subject: Re: Dangers of working on a tracking branch
Date: Fri, 16 Feb 2007 10:40:11 -0600
Message-ID: <17877.56939.79093.519874@lisa.zopyra.com>
References: <17876.51013.561979.431717@lisa.zopyra.com>
	<Pine.LNX.4.64.0702151557410.1757@xanadu.home>
	<17876.52962.662946.582507@lisa.zopyra.com>
	<17876.53654.426022.454712@lisa.zopyra.com>
	<er333i$787$1@sea.gmane.org>
	<17877.51730.418633.750922@lisa.zopyra.com>
	<alpine.LRH.0.82.0702161044100.18370@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Feb 16 17:40:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI68n-0001cS-HF
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 17:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945998AbXBPQkl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 11:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946000AbXBPQkl
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 11:40:41 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61429 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945998AbXBPQkk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 11:40:40 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1GGeFJ20922;
	Fri, 16 Feb 2007 10:40:15 -0600
In-Reply-To: <alpine.LRH.0.82.0702161044100.18370@xanadu.home>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39928>

On Friday, February 16, 2007 at 11:34:01 (-0500) Nicolas Pitre writes:
>On Fri, 16 Feb 2007, Bill Lear wrote:
>
>> Ok, I'm trying to come up with an experiment that verifies this, so
>> I can give a concrete example to our developers.
>> 
>> I don't seem to be able to get it to fail, but I sure remember having
>> severe problems with this in practice.
>
>Try this:

Ok, that's basically what I was looking for --- incontrovertible
evidence from "them" (a git expert --- not me).  Thanks very much
Nicolas.


Bill
