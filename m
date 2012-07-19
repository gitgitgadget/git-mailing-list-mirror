From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: Feature request: fetch --prune by default
Date: Thu, 19 Jul 2012 17:11:38 +0200
Message-ID: <1knhokc.vqc6kir7kbjmM%lists@haller-berlin.de>
References: <CAPBPrnsFk-Ww-52W-=qkTK7Yifjowx3tpsELznO4ncmqwfP_Qg@mail.gmail.com>
Cc: alexey.muranov@gmail.com (Alexey Muranov), git@vger.kernel.org
To: computerdruid@gmail.com (Dan Johnson), peff@peff.net (Jeff King)
X-From: git-owner@vger.kernel.org Thu Jul 19 17:19:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrsVd-0006LY-94
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 17:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930Ab2GSPTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 11:19:15 -0400
Received: from server90.greatnet.de ([83.133.96.186]:34162 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516Ab2GSPTO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 11:19:14 -0400
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Jul 2012 11:19:14 EDT
Received: from [192.168.0.42] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id 3BC9F3B0E43;
	Thu, 19 Jul 2012 17:11:37 +0200 (CEST)
In-Reply-To: <CAPBPrnsFk-Ww-52W-=qkTK7Yifjowx3tpsELznO4ncmqwfP_Qg@mail.gmail.com>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.7.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201736>

Dan Johnson <computerdruid@gmail.com> wrote:

> In the meantime, would it make sense to introduce a configuration
> variable to request this behavior?
> 
> fetch.prune = always
> 
> Of course, this might be just a waste of time to introduce a feature
> no one would use, in which case we obviously should not introduce such
> options.

I would use it.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
