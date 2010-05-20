From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git-status and git-diff now very slow in project with a submodule
Date: Thu, 20 May 2010 19:49:41 +0200
Message-ID: <4BF57635.9090409@web.de>
References: <ht3194$1vc$1@dough.gmane.org> <4BF50A92.3060209@atlas-elektronik.com> <ht36u4$lo4$1@dough.gmane.org> <4BF55ACD.3060009@drmicha.warpmail.net> <ht3sda$cvo$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 20 19:50:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF9sx-0001Mc-Oi
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 19:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613Ab0ETRuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 13:50:13 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:39339 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146Ab0ETRuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 13:50:11 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate02.web.de (Postfix) with ESMTP id 1B22216188BBC;
	Thu, 20 May 2010 19:49:42 +0200 (CEST)
Received: from [80.128.73.13] (helo=[192.168.178.26])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OF9sL-0002gv-00; Thu, 20 May 2010 19:49:41 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <ht3sda$cvo$1@dough.gmane.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18FvvZGzcyxkvhr/pw2UDVfk4adzgwfWCU1fU57
	llvkCQwgirPxXlqyv7jBSPXaYQH6eLCAlg5o9UNdyIvrhH5Lqc
	ujryq7352laAlrtGX/ng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147403>

Am 20.05.2010 19:45, schrieb Andy Parkins:
> (Most of my
> personal use of submodule is embedding large projects that I want to be able 
> to guarantee are at a particular version, but I don't really change them)

But to guarantee they are at a particular version they have to be checked
for local modifications (no matter if they happened accidentally or on
purpose), no?
