From: "Anand Kumria" <wildfire@progsoc.org>
Subject: Re: Licensing and the library version of git
Date: Fri, 28 Jul 2006 00:25:45 +0000 (UTC)
Message-ID: <eabli8$c6a$2@sea.gmane.org>
References: <9e4733910607261436v4c0802e5v7301e904593f9bab@mail.gmail.com>
	<20060727114105.GZ13776@pasky.or.cz>
	<Pine.LNX.4.63.0607271400160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<9e4733910607270554p5622ee20ida8c264cf3122500@mail.gmail.com>
	<20060727131127.GA13776@pasky.or.cz>
	<9e4733910607270911p50d25d97w1a898fc7a9119e7d@mail.gmail.com>
	<Pine.LNX.4.64.0607270936200.4168@g5.osdl.org>
	<Pine.LNX.4.64.0607270941400.4168@g5.osdl.org>
	<9e4733910607271047r57fe0aa3hf29b4b9244c02f2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-From: git-owner@vger.kernel.org Fri Jul 28 02:30:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6GEy-0007rY-FQ
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 02:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWG1AaE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 20:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWG1AaE
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 20:30:04 -0400
Received: from main.gmane.org ([80.91.229.2]:20153 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750760AbWG1AaD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 20:30:03 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1G6GEr-0007p4-Tl
	for git@vger.kernel.org; Fri, 28 Jul 2006 02:30:01 +0200
Received: from 88-109-231-203.dynamic.dsl.as9105.com ([88.109.231.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Jul 2006 02:30:01 +0200
Received: from wildfire by 88-109-231-203.dynamic.dsl.as9105.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Jul 2006 02:30:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 88-109-231-203.dynamic.dsl.as9105.com
User-Agent: pan 0.102 ("From the Years of Neon Through Iodine")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24357>

On Thu, 27 Jul 2006 13:47:24 -0400, Jon Smirl wrote:

> On 7/27/06, Linus Torvalds <torvalds@osdl.org> wrote:
>> I seriously doubt that Eclipse or Visual Stupido could ever actually
>> _understand_ what git does, so the only parts you actually would want to
>> use for those is literally the trivial stuff - the "look up objects" and
>> "generate commits" part.
> 
> Typically an integrated IDE can move, delete, rename directories and
> files. Get a log. Push, pull and commit. Revert a change. Generate
> diffs to previous versions.

Kind of what you can do via CVSNT and git-cvsserver, no?

Anand
