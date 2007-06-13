From: Scott Lamb <slamb@slamb.org>
Subject: Re: git-p4import.py robustness changes
Date: Wed, 13 Jun 2007 14:06:49 -0700
Message-ID: <46705C69.8000500@slamb.org>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org> <200706031511.31157.simon@lst.de> <20070604055600.GE4507@spearce.org> <200706122347.00696.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Wed Jun 13 23:07:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hya3g-00054m-20
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 23:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344AbXFMVG7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 17:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756677AbXFMVG7
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 17:06:59 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:51758 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756344AbXFMVG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 17:06:58 -0400
Received: from slamb-mac.dhcp.2wire.com (slamb-mac.vpn.slamb.org [172.16.0.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hobbes.slamb.org (Postfix) with ESMTP id 85B9D980D1;
	Wed, 13 Jun 2007 14:06:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <200706122347.00696.simon@lst.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50131>

Simon Hausmann wrote:
> _If_ one of you decides to pull then my plan is to discontinue the git-p4 
> branch in the fast-export repository and instead work in a git.git fork on 
> repo.or.cz (similar to the fastimport repository).

So you'll continue maintain this code and others should submit changes 
through you? What is the best way to do so? (Not sure what it was 
before, or if it would change under this plan.) Email a format-patch To: 
you? Cc: this list? some other list? no list?

-- 
Scott Lamb <http://www.slamb.org/>
