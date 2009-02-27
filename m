From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: help with reflog
Date: Fri, 27 Feb 2009 00:43:53 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngqedq9.g56.sitaramc@sitaramc.homelinux.net>
References: <450196A1AAAE4B42A00A8B27A59278E709E04E87@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 27 01:45:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcqrB-0000Fs-33
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 01:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbZB0AoL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Feb 2009 19:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753073AbZB0AoI
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 19:44:08 -0500
Received: from main.gmane.org ([80.91.229.2]:43926 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128AbZB0AoH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 19:44:07 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lcqpd-0004yl-TI
	for git@vger.kernel.org; Fri, 27 Feb 2009 00:44:01 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 00:44:01 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 00:44:01 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111623>

On 2009-02-27, John Dlugosz <JDlugosz@TradeStation.com> wrote:
> My Log for 'HEAD' only has 14 entries.=A0 Shouldn't it go
> back for 90 days?=A0 I see nothing in the 'config' file.

what does 'git reflog show HEAD@{now}' say?
