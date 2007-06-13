From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 19:31:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0706131916270.5241@castor.milkiway.cos>
References: <1HyUO6-04z4yG0@fwd28.aul.t-online.de> <18032.3836.710438.73912@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 19:32:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyWhU-0002fX-ID
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 19:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757659AbXFMRcF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 13:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757555AbXFMRcE
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 13:32:04 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:55479 "EHLO
	mailout07.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756315AbXFMRcD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2007 13:32:03 -0400
Received: from fwd30.aul.t-online.de 
	by mailout07.aul.t-online.de with smtp 
	id 1HyWhK-0005tk-09; Wed, 13 Jun 2007 19:31:58 +0200
Received: from [192.168.2.100] (ZeKoJuZFYevMzWBHlTwm9R0JroF99kB1s9rI7fPj363CqpzidCcnYX@[84.163.230.106]) by fwd30.t-online.de
	with esmtp id 1HyWhG-2D43Qu0; Wed, 13 Jun 2007 19:31:54 +0200
X-X-Sender: michael@castor.milkiway.cos
In-Reply-To: <18032.3836.710438.73912@lisa.zopyra.com>
X-ID: ZeKoJuZFYevMzWBHlTwm9R0JroF99kB1s9rI7fPj363CqpzidCcnYX
X-TOI-MSGID: a260cb86-593a-4dd4-9ab2-5ae05150075d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50104>

Hi,

but even if they just play with the code. Why not always commit?
As long as they don't push nobody else will be affected.

Even if you play with the code it's useful to go back to earlier 
versions. Why would you not want to benefit from this possibility?

So this would really only be two commands the commit and the pull command.

I hope I didn't miss your point completely.

Cheers
Michael

On Wed, 13 Jun 2007, Bill Lear wrote:

> On Wednesday, June 13, 2007 at 17:03:58 (+0200) MichaelTiloDressel@t-online.de writes:
> >Hi,
> >
> >why don't they just do a simple 
> >git commit -a
> >of their work before pulling?
> 
> Because they are basically playing with some code and don't want to
> commit it.
> 
> >That's different to cvs! Committing only affects the cloned repository.
> 
> Yup, we realize that.
> 
> >I think one of the biggest advantages of git is the concept of everyone
> >working on a clone. So developers are not prevented from actually using
> >revision control just because they are afraid of disturbing others. They
> >don't until they e.g. push!
> 
> Right, but they just want updates to their working tree, as they could
> do under CVS, without issuing five (or even one) other commands.
> 
> 
> Bill
> 
