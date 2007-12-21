From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH v2] builtin-tag.c: allow arguments in $EDITOR
Date: Thu, 20 Dec 2007 16:33:12 -0800
Message-ID: <C84F3F74-6FB1-46E9-8627-09FC636D256E@midwinter.com>
References: <20071219232326.GA4135@bit.office.eurotux.com> <20071220095706.GA9685@bit.office.eurotux.com> <Pine.LNX.4.64.0712201255510.14355@wbgn129.biozentrum.uni-wuerzburg.de> <7vhcidovxt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Luciano Rocha <luciano@eurotux.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 01:33:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Vpc-0006cG-Ng
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 01:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764750AbXLUAdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 19:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764728AbXLUAdP
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 19:33:15 -0500
Received: from tater.midwinter.com ([216.32.86.90]:53854 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764653AbXLUAdN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 19:33:13 -0500
Received: (qmail 8374 invoked from network); 21 Dec 2007 00:33:13 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=PNask/jb3T8AtT9KQLb+MvzFNbJBBMDvS/fV9BFJQxScfIU2mArTdNYAHrEPimgA  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 21 Dec 2007 00:33:13 -0000
In-Reply-To: <7vhcidovxt.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69034>

On Dec 20, 2007, at 2:14 PM, Junio C Hamano wrote:
> I think Steven stopped after you poked holes in that patch.

Nah, just entered a particularly busy period in my day job and haven't  
had time to do much more git stuff than occasionally skim the mailing  
list. I do plan to revisit that at some point unless the patch in your  
mail ends up being what we go with. (It seems like a sensible approach  
to me.)

-Steve
