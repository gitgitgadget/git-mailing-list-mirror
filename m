From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: diff settings
Date: Fri, 30 Jan 2009 06:07:42 +0900
Message-ID: <20090130060742.6117@nanako3.lavabit.com>
References: <alpine.GSO.2.00.0901240936080.23073@kiwi.cs.ucla.edu> <87ocxwv6qg.fsf@iki.fi> <alpine.GSO.2.00.0901241159050.23073@kiwi.cs.ucla.edu> <497CD352.2060402@tedpavlic.com> <alpine.GSO.2.00.0901251307030.12651@kiwi.cs.ucla.edu> <497D1AB7.7000208@tedpavlic.com>
 <4981D8AD.6000000@tedpavlic.com> <alpine.DEB.1.00.0901291731220.3586@pacific.mpi-cbg.de> <alpine.GSO.2.00.0901291044280.23065@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ted Pavlic <ted@tedpavlic.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Thu Jan 29 22:10:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSe8u-0006Ep-DO
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 22:09:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbZA2VIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 16:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbZA2VIS
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 16:08:18 -0500
Received: from karen.lavabit.com ([72.249.41.33]:57766 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348AbZA2VIR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 16:08:17 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id EF516C7B31;
	Thu, 29 Jan 2009 15:08:14 -0600 (CST)
Received: from 5700.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id CZZSKKO2BMF5; Thu, 29 Jan 2009 15:08:14 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=gnULXBl43lDXtZH6/wvdcYC92i+N7f45d3emsswMJYdifTB4H57mqe4xUeDdfdHafL4lAApcq6aJ6+Z+U8R0YGUk8WyoJ+dg+/7nVxOnE4UKpLnZeP50R1Csr2ncpyRiHEwKccLT4SXJ5Z00XJxYevnGJwo8qQWvqLditMnGwvU=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <alpine.GSO.2.00.0901291044280.23065@kiwi.cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107730>

Quoting Keith Cascio <keith@CS.UCLA.EDU>:

> On Thu, 29 Jan 2009, Johannes Schindelin wrote:
>
>> we already have a distinction between what is called from scripts vs from 
>> humans: plumbing vs porcelain.  So you can set the defaults for porcelain as 
>> much as you want, but please leave plumbing alone.
>
> May we consider "git diff" Porcelain and "git diff-{files,index,tree}" plumbing?

Sure we may. To see the list of commands with categories, you can consult

http://www.kernel.org/pub/software/scm/git/docs/

Junio, I think you could have stated this a bit more clearly in your message

http://thread.gmane.org/gmane.comp.version-control.git/107069/focus=107165

to avoid confusion, especially when you know you are talking to somebody new to git.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
