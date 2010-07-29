From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Re: Possible feature request for merge and pull
Date: Wed, 28 Jul 2010 21:30:07 -0400
Message-ID: <AANLkTinPcH-urWJJ_UELA5Kj=m3zKKLB8yGuvj6b03jw@mail.gmail.com>
References: <AANLkTim6JAPrSVaSaGZ72xtfFnUUcYeWT8vpL3rYuwki@mail.gmail.com>
	<AANLkTinRvq71GS5WVdWs9zP5QSJ=TjCWBgTfRGn2Qub0@mail.gmail.com>
	<AANLkTikA2jWu76aPUNG+B7Nwc9eDzoU93VcGvUFWR0Ri@mail.gmail.com>
	<20100729010341.GA25732@coredump.intra.peff.net>
	<AANLkTikP+5GxyWbXNcKeOtQoOEGAT9v313jAum+q-1LV@mail.gmail.com>
	<20100729012723.GH29156@dert.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Avery Pennarun <apenwarr@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 03:30:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeHws-0001sg-OI
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 03:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707Ab0G2BaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 21:30:09 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41476 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab0G2BaI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 21:30:08 -0400
Received: by gwb20 with SMTP id 20so183gwb.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 18:30:08 -0700 (PDT)
Received: by 10.100.92.1 with SMTP id p1mr12557951anb.57.1280367007866; Wed, 
	28 Jul 2010 18:30:07 -0700 (PDT)
Received: by 10.229.236.2 with HTTP; Wed, 28 Jul 2010 18:30:07 -0700 (PDT)
In-Reply-To: <20100729012723.GH29156@dert.cs.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152143>

On Wed, Jul 28, 2010 at 9:27 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Bradley Wagner wrote:
>> On Wed, Jul 28, 2010 at 9:03 PM, Jeff King <peff@peff.net> wrote:
>
>>> Really? I get:
> [...]
>> --log is supposed to include one-log summaries of each of the merged
>> commits, right? It's not doing that for me
>
> Just a wild guess, but are you using a version of git before
> 1.7.1.1?

Certainly am: git version 1.7.0

> If you upgrade, you'll be able to use -m with --log for
> "git merge", at least (v1.7.1.1~23^2: merge: --log appends
> shortlog to message if specified, 2010-05-11).

Thanks, I'll do that.

> Thanks, Tay!
> Jonathan
