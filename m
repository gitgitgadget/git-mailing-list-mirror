From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: My stash wants to delete all my files
Date: Tue, 25 Sep 2007 11:22:55 +0100
Message-ID: <0F9BDBCD-06AA-4AB1-9DDA-9C98E8796AA1@steelskies.com>
References: <5A9D6E3B-7B0E-4414-9AFB-C1C8B2EE6A9D@steelskies.com> <7vabrb8rin.fsf@gitster.siamese.dyndns.org> <DCBF8566-9B43-4EFA-A8B2-2EAB516C273F@steelskies.com> <Pine.LNX.4.64.0709251054440.28395@racer.site>
Mime-Version: 1.0 (Apple Message framework v901)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 25 12:24:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia7aK-0007C7-GL
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 12:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbXIYKXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 06:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbXIYKXn
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 06:23:43 -0400
Received: from juliet.asmallorange.com ([207.210.105.70]:50523 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbXIYKXm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 06:23:42 -0400
Received: from host217-35-101-26.in-addr.btopenworld.com ([217.35.101.26]:50898 helo=[192.168.1.2])
	by juliet.asmallorange.com with esmtpa (Exim 4.68)
	(envelope-from <maillist@steelskies.com>)
	id 1Ia7ZJ-00047y-If; Tue, 25 Sep 2007 06:23:05 -0400
In-Reply-To: <Pine.LNX.4.64.0709251054440.28395@racer.site>
X-Mailer: Apple Mail (2.901)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59107>


On 25 Sep 2007, at 10:56, Johannes Schindelin wrote:

> Hi,
>
> On Tue, 25 Sep 2007, Jonathan del Strother wrote:
>
>> I don't think I git-added anything - just made changes to the working
>> copy. (It *does* stash those, right??)
>
> Stash does not care about things that are not tracked, so no, it  
> does not
> stash those.  Imagine a stash saving all those .o, .a and .so files...
> Insanity!


Mm, ok - fair point.  I was actually thinking of files that are  
already tracked, but haven't been added to the staging area with git  
add.
