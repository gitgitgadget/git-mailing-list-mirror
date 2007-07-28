From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git diff with add/modified codes
Date: Sat, 28 Jul 2007 17:26:27 +0200
Organization: At home
Message-ID: <f8fn72$l30$1@sea.gmane.org>
References: <9e4733910707271505x4eac928axe639308afed20cb3@mail.gmail.com> <7vir85whxy.fsf@assigned-by-dhcp.cox.net> <9e4733910707271717q5ea33b55r227d8dbb1023de47@mail.gmail.com> <20070728043901.GB11916@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 17:26:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEoBw-0005pu-QW
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 17:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbXG1P0u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 11:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbXG1P0u
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 11:26:50 -0400
Received: from main.gmane.org ([80.91.229.2]:39510 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765AbXG1P0t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 11:26:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IEoBi-0007Ew-Dm
	for git@vger.kernel.org; Sat, 28 Jul 2007 17:26:38 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 17:26:38 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 17:26:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54038>

Jeff King wrote:

> On Fri, Jul 27, 2007 at 08:17:54PM -0400, Jon Smirl wrote:
> 
>> That's not what I want. I'm looking a report that indicates new files
>> vs modified ones in a single list. These old patches I am working with
>> often create 100 files and modify another 200.
>> 
>> Adding a code like (Added (A), Copied (C), Deleted (D), Modified (M),
>> Renamed (R))  to --stat would be perfect.
> 
> How about --name-status?

Or -r --name-status?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
