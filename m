From: David Soria Parra <sn_@gmx.net>
Subject: Re: Feature Request: Branch Annotations
Date: Wed, 08 Oct 2008 15:29:47 +0200
Message-ID: <48ECB5CB.4010703@gmx.net>
References: <d2115f4f0810080341m27c4ca9bv9b1e9b66704ef3fa@mail.gmail.com>	 <d2115f4f0810080348t62e18b14x1dfe798974332b05@mail.gmail.com> <d2115f4f0810080349o30b6bc2labc2745b8d981e0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Rotem Yaari <vmalloc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 15:31:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnZ8V-0002RX-1m
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 15:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbYJHN3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 09:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbYJHN3w
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 09:29:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:42217 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750753AbYJHN3v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 09:29:51 -0400
Received: (qmail invoked by alias); 08 Oct 2008 13:29:48 -0000
Received: from p57AEC1DC.dip.t-dialin.net (EHLO [192.168.2.25]) [87.174.193.220]
  by mail.gmx.net (mp045) with SMTP; 08 Oct 2008 15:29:48 +0200
X-Authenticated: #4427663
X-Provags-ID: V01U2FsdGVkX19+nFU/G4F+0D9g0eWyC8sG5hm45aPv2LGw8Tf3tj
	jtQbyw/bW586Ww
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <d2115f4f0810080349o30b6bc2labc2745b8d981e0d@mail.gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97799>


> Any opinions on this?

would be great to have something like that build in git-core like

git branch -i 'Fix bla' ds/fix next
git branch -i
  ds/fix (Fix Bla)

david
