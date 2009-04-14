From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: making docs
Date: Tue, 14 Apr 2009 09:18:02 -0400
Message-ID: <5788C28F-8C24-439D-9119-D96AFB266354@silverinsanity.com>
References: <49E4A72D.21604.198A9AD@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> <ee77f5c20904140614ofa0753apaec52584f2a3878c@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
	git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 15:20:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtiYB-0006oj-RD
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 15:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbZDNNSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 09:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754175AbZDNNSK
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 09:18:10 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:39124 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274AbZDNNSK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 09:18:10 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id AB2131FFC032; Tue, 14 Apr 2009 13:18:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.5.44] (nmd.sbx07360.rocheny.wayport.net [98.98.50.102])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 3B1AC1FFC02F;
	Tue, 14 Apr 2009 13:18:00 +0000 (UTC)
In-Reply-To: <ee77f5c20904140614ofa0753apaec52584f2a3878c@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116538>


On Apr 14, 2009, at 9:14 AM, David Symonds wrote:

> On Tue, Apr 14, 2009 at 11:09 PM, Ulrich Windl
> <ulrich.windl@rz.uni-regensburg.de> wrote:
>
>> 1) Pre-build the documentation (manual pages) with the source  
>> archive. If the
>> sources are used unmodified, the manual pages should be fine
>
> This is already in the git.git repository, in the 'man' and 'html'  
> branches.

Which can be installed using `make quick-install-man` or `make quick- 
install-html`.

~~ Brian
