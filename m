From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/3] mailinfo: allow individual e-mail files as input
Date: Thu, 06 Aug 2009 20:21:05 -0500
Message-ID: <mEqhWlw9LAyH0nh8YYU987gX5gaEeucbUmEtSnZRFab29VT4nc0amA@cipher.nrlssc.navy.mil>
References: <MEhvdM_GHnyaFj9ZU3lxKS47vmOk5BKslGm0FxkE_lg0SQT5Zx6KhA@cipher.nrlssc.navy.mil> <COrzR9ThNBy5SQ7chsXyUOUuBmX-VWMCz3MUVwvBOlIZzlIXRRMP6EMS7BRy_6uJvxt5H-FbtdY@cipher.nrlssc.navy.mil> <COrzR9ThNBy5SQ7chsXyUB30jVGIijxZQ3LI9L_y7Ab5vWcDcy_HolvjjuHTC7DHI9ntV-eR_v0@cipher.nrlssc.navy.mil> <20090807011820.GA16472@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, ni.s@laposte.net, giuseppe.bilotta@gmail.com,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 07 03:21:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZE96-0007T5-S6
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 03:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756431AbZHGBVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 21:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754670AbZHGBVR
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 21:21:17 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57122 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509AbZHGBVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 21:21:16 -0400
Received: by mail.nrlssc.navy.mil id n771L6iZ006238; Thu, 6 Aug 2009 20:21:06 -0500
In-Reply-To: <20090807011820.GA16472@coredump.intra.peff.net>
X-OriginalArrivalTime: 07 Aug 2009 01:21:05.0935 (UTC) FILETIME=[560781F0:01CA16FD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125153>

Jeff King wrote:
> On Thu, Aug 06, 2009 at 08:08:12PM -0500, Brandon Casey wrote:
> 
>> You'll notice that I changed your grep -E to an egrep and dropped the -e.
>> I do not see any other grep which uses -e, and I seem to recall Jeff King
>> actively removing -e claiming that some greps do not recognize it.  I do not
>> have a perfect memory though, so apologies to Jeff if I am mistaken.
> 
> Fortunately git does have a perfect memory:

:)
