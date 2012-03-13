From: Sergio <sergio.callegari@gmail.com>
Subject: Re: Removing unmaintained scripts
Date: Tue, 13 Mar 2012 09:23:34 +0000 (UTC)
Message-ID: <loom.20120313T102017-876@post.gmane.org>
References: <1331514446.3022.140.camel@deadeye> <20120312024948.GB4650@kroah.com> <20120312063027.GB8971@1wt.eu> <20120312064855.GB16820@burratino> <20120312085820.GA11569@1wt.eu> <20120312152004.GB9380@kroah.com> <7vfwddu60f.fsf@alter.siamese.dyndns.org> <20120312171257.GA25347@kroah.com> <7vzkblsnos.fsf@alter.siamese.dyndns.org> <m38vj5zeo5.fsf_-_@localhost.localdomain> <20120312214139.GA11362@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 10:24:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Nxa-0007OI-Mt
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 10:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760159Ab2CMJX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 05:23:56 -0400
Received: from plane.gmane.org ([80.91.229.3]:60622 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759982Ab2CMJXz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 05:23:55 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S7NxG-0007BG-Ff
	for git@vger.kernel.org; Tue, 13 Mar 2012 10:23:52 +0100
Received: from i2-ve060.ingce.unibo.it ([137.204.107.60])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 10:23:42 +0100
Received: from sergio.callegari by i2-ve060.ingce.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 10:23:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.107.60 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192988>

Jonathan Nieder <jrnieder <at> gmail.com> writes:

> 
> Jakub Narebski wrote:
> 
> > A'propos, there is git-archimport script, last modified (as an
> > individual script) in 2007.  Is anyone using GNU arch nowadays;
> > isn't arch-fast-export better solution anyway?
> 
> According to [1] (see the green line), it still has some users,
> or at least people who access the file now and then.   As long
> as the script works, why would we want to cause them trouble?
> 
> For comparison, here's the corresponding graph for people using
> GNU arch[2] and participating in the same survey.
> 
> Hope that helps,
> Jonathan
> 
> [1] http://qa.debian.org/popcon-graph.php?packages=git-arch
>     http://qa.debian.org/popcon.php?package=git-core
> [2] http://qa.debian.org/popcon-graph.php?packages=tla
>     http://qa.debian.org/popcon.php?package=tla
> 


Hi,

please do not remove the ability to convert arch/tla repos unless it is a real
cost to maintain the scripts. There may be few people who still use arch, but
there may be a lot of them who have arch repos of quiescent stuff that one day
they may need to revitalize.

Sergio
