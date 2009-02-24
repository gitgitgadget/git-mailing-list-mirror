From: Charles Bailey <charles@hashpling.org>
Subject: Re: how do I resolve this merge manually + mergetool bug
Date: Tue, 24 Feb 2009 07:47:27 +0000
Message-ID: <20090224074727.GA23927@hashpling.org>
References: <81bfc67a0902232204y7a1e9a91x6cbf751319664734@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 08:49:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbs2G-0006H5-IG
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 08:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbZBXHrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 02:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbZBXHrc
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 02:47:32 -0500
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:40275 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751832AbZBXHrb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 02:47:31 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAAI1o0nUnw6R/2dsb2JhbADWG4QRBg
Received: from ptb-relay01.plus.net ([212.159.14.145])
  by relay.ptn-ipout02.plus.net with ESMTP; 24 Feb 2009 07:47:28 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay01.plus.net with esmtp (Exim) id 1Lbs0m-0003Px-Bm; Tue, 24 Feb 2009 07:47:28 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n1O7lSNQ024454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Feb 2009 07:47:28 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n1O7lRvw024453;
	Tue, 24 Feb 2009 07:47:27 GMT
Content-Disposition: inline
In-Reply-To: <81bfc67a0902232204y7a1e9a91x6cbf751319664734@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 8bf113a0082b8569f0ac45e1844fdea2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111233>

On Tue, Feb 24, 2009 at 01:04:23AM -0500, Caleb Cushing wrote:
> regardless of mergetools problems I'd like to know how to fix this
> merge without mergetool.

I see you've now resolved this without mergetool, I'll look at adding
a test case to mergetool and see how easy it is to get it to handle
this case better.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
