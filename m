From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git clone against firewall
Date: Fri, 15 Jan 2010 20:30:02 +0100
Message-ID: <m2aawf1804.fsf@igel.home>
References: <4B4FACB1.2080902@hartwork.org>
	<7vzl4fz0zb.fsf@alter.siamese.dyndns.org>
	<4B50BE10.5010603@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sebastian Pipping <webmaster@hartwork.org>
X-From: git-owner@vger.kernel.org Fri Jan 15 20:30:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVrs5-0003Yq-Np
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 20:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758061Ab0AOTaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 14:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757441Ab0AOTaH
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 14:30:07 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:34786 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757307Ab0AOTaG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 14:30:06 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 8D6B21C15673;
	Fri, 15 Jan 2010 20:30:03 +0100 (CET)
Received: from igel.home (DSL01.83.171.182.145.ip-pool.NEFkom.net [83.171.182.145])
	by mail.mnet-online.de (Postfix) with ESMTP id 7CC3390173;
	Fri, 15 Jan 2010 20:30:03 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 2285ACA298; Fri, 15 Jan 2010 20:30:03 +0100 (CET)
X-Yow: I need to discuss BUY-BACK PROVISIONS with at least
 six studio SLEAZEBALLS!!
In-Reply-To: <4B50BE10.5010603@hartwork.org> (Sebastian Pipping's message of
	"Fri, 15 Jan 2010 20:12:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137102>

Sebastian Pipping <webmaster@hartwork.org> writes:

> I get a loop/freeze on
>
>   Trying 66.219.59.40...
>
> nothing more.  Can you deduce from that, what's happening?

So your firewall is dropping the packets on the floor.  Not much that
can be done about that.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
