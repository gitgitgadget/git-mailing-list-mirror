From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Feature Request: Branch Annotations
Date: Fri, 10 Oct 2008 09:24:08 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0810100922180.10709@ds9.cixit.se>
References: <d2115f4f0810080341m27c4ca9bv9b1e9b66704ef3fa@mail.gmail.com> 
 <d2115f4f0810080348t62e18b14x1dfe798974332b05@mail.gmail.com> 
 <d2115f4f0810080349o30b6bc2labc2745b8d981e0d@mail.gmail.com> 
 <48ECB5CB.4010703@gmx.net> <7vwsgiptph.fsf@gitster.siamese.dyndns.org>
 <32541b130810081621k32493e20occba9cd97671775d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	David Soria Parra <sn_@gmx.net>,
	Rotem Yaari <vmalloc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 10:25:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoDJp-0002Z3-Ay
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 10:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbYJJIYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 04:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbYJJIYl
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 04:24:41 -0400
Received: from ds9.cixit.se ([193.15.169.228]:57804 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831AbYJJIYk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 04:24:40 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m9A8O9Y1025173
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 10 Oct 2008 10:24:09 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m9A8O8EP025167;
	Fri, 10 Oct 2008 10:24:08 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <32541b130810081621k32493e20occba9cd97671775d@mail.gmail.com>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Fri, 10 Oct 2008 10:24:09 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97914>

Avery Pennarun:

> I guess bash completions would help with this (if you're using bash),
> but even then it's kind of unreasonable to name branches something
> like "bug-111234-widget-performance-improvements-for-customer-x",
> which is the sort of information that would be awfully helpful two
> months later when you're looking at old unmerged branches.

That's exactly what I do for one of the projects I am working on (well,
minus the "bug-" prefix, that's implied). Bash completion works quite
well for that, and the merge commits do give meaningful information.

But I would still like to be able to annotate it. Especially for
long-living bug-fix branches, it could be useful to be able to add
describe a branch with what state it is in, for instance.

-- 
\\// Peter - http://www.softwolves.pp.se/
