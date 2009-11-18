From: Intland Software <marketing@intland.com>
Subject: Re: [ANNOUNCE] codeBeamer MR - Easy ACL for Git
Date: Wed, 18 Nov 2009 14:19:13 +0100
Message-ID: <4B03F451.4050709@intland.com>
References: <4B03B153.1020302@intland.com> <20091118120936.GL17748@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Nov 18 14:29:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAkbG-0004tH-HG
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 14:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756983AbZKRN3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 08:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756395AbZKRN3W
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 08:29:22 -0500
Received: from mail01d.mail.t-online.hu ([84.2.42.6]:49377 "EHLO
	mail01d.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756676AbZKRN3V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 08:29:21 -0500
X-Greylist: delayed 612 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2009 08:29:21 EST
Received: from [192.168.1.65] (dsl4E5C0B13.pool.t-online.hu [78.92.11.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail01d.mail.t-online.hu (Postfix) with ESMTPSA id 30A397586C2;
	Wed, 18 Nov 2009 14:18:33 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <20091118120936.GL17748@machine.or.cz>
X-DCC-mail.t-online.hu-Metrics: mail01d.mail.t-online.hu 32711; Body=2 Fuz1=2
	Fuz2=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133169>

  Thanks for your comments, Petr.

Petr Baudis wrote:
>> LEARN MORE & DOWNLOAD
>> More details, screenshots and downloads:
>> http://www.intland.com/products/cb-mr/overview.html
> 
> Interesting, thank you for the announcement; it would be good to note
> that it's not open-source.
  That's right, codeBeamer MR is not open source.
  More precisely: parts of the source code are actually open, including
the wiki plugins and the remote clients, for instance. The core source
is closed, because the same core is also used in our commercial offerings, and
our commercial license doesn't (currently) allow publishing the
complete code. We have quite some large customers from the defense space
that would not be happy if we opened everything ;)

  We are currently in the midst of rethinking our licensing scheme
in general, to make things more liberal or to set up some kind of a
dual license.

> I think a lot of people wonder now, how does this compare to existing
> solutions; from your announcement I thought it's something like
> Gitosis/Gitolite, but in fact it seems more similar to Gitorious or
> GitHub (if it was publicly available, of course); perhaps it would be
> good idea to present comparison to these on the project homepage.
  Good point. More on this later.
---
  Intland
