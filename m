From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Merge problems with git-mingw
Date: Tue, 09 Oct 2007 08:10:26 +0200
Message-ID: <470B1B52.20009@viscovery.net>
References: <Pine.LNX.4.64.0710081203020.29715@ds9.cixit.se>	 <8c5c35580710080500n78259210v1b087e1ef506c0ee@mail.gmail.com>	 <Pine.LNX.4.64.0710081333350.29715@ds9.cixit.se>	 <8c5c35580710080610y739fb51aga82964e212c7917f@mail.gmail.com>	 <Pine.LNX.4.64.0710081555480.29570@ds9.cixit.se> <8c5c35580710081259j6d7e8587r546d4c35d42a67a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Karlsson <peter@softwolves.pp.se>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 08:10:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If8Ik-0006lK-9p
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 08:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbXJIGKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 02:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752186AbXJIGKa
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 02:10:30 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:54774 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbXJIGK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 02:10:29 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1If8IO-00040O-Im; Tue, 09 Oct 2007 08:10:20 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8E20E69F; Tue,  9 Oct 2007 08:10:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <8c5c35580710081259j6d7e8587r546d4c35d42a67a6@mail.gmail.com>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60359>

Lars Hjemli schrieb:
> On 10/8/07, Peter Karlsson <peter@softwolves.pp.se> wrote:
>> $ git var GIT_COMMITTER_IDENT
>> usage: git-var [-l | <variable>]
> 
> Does 'git var -l' work as expected? Also, could you try the latest
> git-package provided by the cygwin installer? If CRLF-handling was
> your problem, take a look at the description of core.autocrlf with
> 'git help config'.
> 
> [This does look like an issue with running mingw.git under Cygwin.
> Johannes, is this even supposed to work?]

Sure, why not? Cygwin's settings as well as core.autocrlf should be 
completely irrelevant. I've no clue what could be wrong here.

-- Hannes
