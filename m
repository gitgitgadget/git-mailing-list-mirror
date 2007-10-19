From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH resend again] gitk: Do not pick up file names of "copy
 from" lines
Date: Fri, 19 Oct 2007 10:05:55 +0200
Message-ID: <47186563.3070607@viscovery.net>
References: <20071019052823.GI14735@spearce.org> <47185BCC.9010307@viscovery.net> <20071019073253.GM14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 10:09:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Iimuk-0001wv-72
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 10:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934087AbXJSIGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 04:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764751AbXJSIGp
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 04:06:45 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:35132 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765807AbXJSIGm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 04:06:42 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IimrW-0003z1-2m; Fri, 19 Oct 2007 10:05:42 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 68660546; Fri, 19 Oct 2007 10:05:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071019073253.GM14735@spearce.org>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61668>

Shawn O. Pearce schrieb:
> Johannes Sixt <j.sixt@viscovery.net> wrote:
>>  Would you mind putting this one into your queue, too? I haven't seen it
>>  appear in Paul's repo.
> 
> I think it is already in Paul's repo:

No, it's not. I checked both Paul's master and dev, and also your own
gitk branch. Would you mind cherry-picking from the tip of

git://repo.or.cz/git/mingw.git mob

Thanks,
-- Hannes
