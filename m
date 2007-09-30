From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: A tour of git: the basics (and notes on some unfriendly messages)
Date: Sun, 30 Sep 2007 15:41:56 +0200
Message-ID: <D6FD584E-9B14-4566-8955-ACA1BAFB0456@zib.de>
References: <87ir5us82a.wl%cworth@cworth.org> <20070929000056.GZ3099@spearce.org> <E5C688F2-4A8D-402A-9757-5007BE4A8B25@zib.de> <7vlkapjeir.fsf@gitster.siamese.dyndns.org> <E8851B12-AAA5-4B4D-9F28-C5AB5AEF0E57@zib.de> <Pine.LNX.4.64.0709301343000.28395@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Carl Worth <cworth@cworth.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 30 15:40:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibz2I-0006kw-Il
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 15:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755870AbXI3Nkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 09:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755493AbXI3Nkd
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 09:40:33 -0400
Received: from mailer.zib.de ([130.73.108.11]:64324 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755225AbXI3Nkd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 09:40:33 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l8UDeL4a016445;
	Sun, 30 Sep 2007 15:40:21 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db16feb.pool.einsundeins.de [77.177.111.235])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l8UDeKvq000292
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 30 Sep 2007 15:40:20 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0709301343000.28395@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59540>


On Sep 30, 2007, at 2:44 PM, Johannes Schindelin wrote:

>>
>> A much simpler output could be easier to scan by a human
>>
>> updating 'refs/heads/master' .. fast forward .. ok.
>> updating 'refs/heads/pu' .. forced non-fast forward .. ok.
>> updating 'refs/heads/next' ..
>> ERROR: 'refs/heads/next' not updating to non-fast forward
>> exit(1) here.
>
> No, please no.  This is way too short.
>
> If at all, please let 8c3275abcacb83ea3f4c4f4ceb2376799fc282bd be an
> example, and make git respect several different output levels, but not
> changing the default (at first).

good idea.

	Steffen
