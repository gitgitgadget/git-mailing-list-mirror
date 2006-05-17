From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: "git add $ignored_file" fail
Date: Wed, 17 May 2006 21:52:41 +0200
Organization: At home
Message-ID: <e4fuu3$vv$1@sea.gmane.org>
References: <8aa486160605161507w3a27152dq@mail.gmail.com> <Pine.LNX.4.64.0605161526210.16475@g5.osdl.org> <8aa486160605161542u704ccf03w@mail.gmail.com> <Pine.LNX.4.63.0605171306400.19012@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0605170604i689a8f7axa5aeb7752dc72072@mail.gmail.com> <8aa486160605170641p2ab8704o@mail.gmail.com> <e4f9eo$b60$1@sea.gmane.org> <1147893786.16654.5.camel@dv> <BAYC1-PASMTP12920BE00C27B0CF31CB9FAEA10@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed May 17 21:53:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgS56-0001Dh-ET
	for gcvg-git@gmane.org; Wed, 17 May 2006 21:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWEQTxN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 15:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWEQTxN
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 15:53:13 -0400
Received: from main.gmane.org ([80.91.229.2]:56759 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751058AbWEQTxN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 15:53:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FgS4o-00019X-FS
	for git@vger.kernel.org; Wed, 17 May 2006 21:52:58 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 May 2006 21:52:58 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 May 2006 21:52:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20234>

Sean wrote:


> Shouldn't git just always respect the ignore rules?  Forcing someone to
> remove a file from the .gitignore [...]

Or adding exclude rule (!filename) for specific file to .gitignore.

-- 
Jakub Narebski
Warsaw, Poland
