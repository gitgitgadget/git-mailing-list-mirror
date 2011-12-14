From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Git difftool / mergetool on directory tree
Date: Wed, 14 Dec 2011 17:25:14 +0100
Message-ID: <201112141725.14729.trast@student.ethz.ch>
References: <4EE8618E.7020902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 17:25:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rardy-00046f-4O
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 17:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757269Ab1LNQZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 11:25:18 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:32805 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753734Ab1LNQZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 11:25:16 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Dec
 2011 17:25:12 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Dec
 2011 17:25:14 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.3-1-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <4EE8618E.7020902@gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187142>

Daniele Segato wrote:
> Hi,
> 
> many diff / merge tool around have the ability to compare a directory 
> tree (meld is one, but there are many).
> 
> Is there a way to start a difftool or a mergetool on a folder instead of 
> the single file?
> 
> It would be an handsome feature to git.
> 
> I googled a little before popping out this question and I only found 
> suggestion on how to open "many" file at once instead of opening them 
> serially but that's not the same thing not as powerful as directory 
> comparison.

Maybe this helps:

  http://thread.gmane.org/gmane.comp.version-control.git/144839

It was never applied however.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
