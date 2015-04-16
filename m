From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git-owner, was Re: [bug] first line truncated with `git log
 --oneline --decorate --graph`
Date: Thu, 16 Apr 2015 19:06:25 +0200
Organization: gmx
Message-ID: <ef9e69f60275dc7edb2dff8e65952630@www.dscho.org>
References: <20150416.115628.1228076242478955092.davem@davemloft.net>
 <6ebf8090f8246f9880f2bd94d494c872@www.dscho.org>
 <20150416162620.GA10573@peff.net>
 <20150416.123109.141223786207291496.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Thu Apr 16 19:06:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YinFQ-0004vR-9h
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 19:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289AbbDPRGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 13:06:36 -0400
Received: from mout.gmx.net ([212.227.15.18]:51918 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752341AbbDPRGf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 13:06:35 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MGSDw-1YeNOs39Cy-00DJik; Thu, 16 Apr 2015 19:06:26
 +0200
In-Reply-To: <20150416.123109.141223786207291496.davem@davemloft.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:BunRdbTsDIfh1waA4kLcjL1Y3dw0driixf5sK82SEZ5I4grbHdl
 s7KHJydmCQoZZurvPGlnwnQOFFMzyVTZJWjI4H+aFcwZ+mhxKseUBabwqh2sbjbqFTgNnif
 VKFbOxc7UyMg44FgkNeb31+mxs4qQUAgA7DyN3Cnc7k6Fjz+SzlJd83nm5xHGmIM1yMNm7d
 jEBXJpBT8CnKsqHsf69ug==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267310>

On 2015-04-16 18:31, David Miller wrote:
> From: Jeff King <peff@peff.net>
> Date: Thu, 16 Apr 2015 12:26:21 -0400
> 
>> Weird. In a nearby thread with the same problem, the first email that
>> mentions git-owner in a cc header is yours[1]. It's in reply to a
>> message that does not mention git-owner at all[2], except in the
>> "Sender" field. Your agent header looks like:
>>
>>   User-Agent: Roundcube Webmail/1.1.0
>>
>> Maybe their "reply to all" function is a little over-zealous?
> 
> This is always caused by broken reply list handling in email clients.

That must be it. Dave, my apologies! Will investigate *right now*.
