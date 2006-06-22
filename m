From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: git pull w/o checkout?
Date: Thu, 22 Jun 2006 08:15:31 -0500
Message-ID: <A4C01915-3337-460C-BE19-7AC17249BE50@kernel.crashing.org>
References: <E65F8DB5-677B-4C7B-A4EC-5F6FB76D6E9A@kernel.crashing.org> <20060622130523.GA6893@coredump.intra.peff.net> <E333ADD9-1096-4137-9D72-D58A8E2A5582@kernel.crashing.org> <20060622131344.GA7168@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 15:17:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtP25-0004d2-8f
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 15:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030634AbWFVNPi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 09:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030638AbWFVNPi
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 09:15:38 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:52540 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1030634AbWFVNPh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 09:15:37 -0400
Received: from cpe-66-69-212-100.austin.res.rr.com ([66.69.212.100] helo=[192.168.1.100])
	by nommos.sslcatacombnetworking.com with esmtp (Exim 4.52)
	id 1FtP20-000435-1E; Thu, 22 Jun 2006 08:15:36 -0500
In-Reply-To: <20060622131344.GA7168@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.750)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22333>


On Jun 22, 2006, at 8:13 AM, Jeff King wrote:

> On Thu, Jun 22, 2006 at 08:10:10AM -0500, Kumar Gala wrote:
>
>>> git-fetch?
>> Its the first half, still need to resolve FETCH_HEAD, HEAD, etc..
>
> Can you elaborate on what you're trying to accomplish?

A local mirror of a git tree.  I can do the clone easy enough, its  
trying to figure out the updates after the fact that is the issue.

- k
