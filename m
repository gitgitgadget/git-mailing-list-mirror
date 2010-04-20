From: Petr Baudis <pasky@suse.cz>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Tue, 20 Apr 2010 14:07:31 +0200
Message-ID: <20100420120731.GP10939@machine.or.cz>
References: <201004150630.44300.chriscool@tuxfamily.org>
 <201004181950.19610.jnareb@gmail.com>
 <20100418195623.GA3563@machine.or.cz>
 <201004191243.24209.jnareb@gmail.com>
 <20100419115113.GC3563@machine.or.cz>
 <j2ke72faaa81004191103qabe0c3ddj959d8804e873ed04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 14:07:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4CEs-0005dV-So
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 14:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316Ab0DTMHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 08:07:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45772 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754228Ab0DTMHd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 08:07:33 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id E4826125A15C; Tue, 20 Apr 2010 14:07:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <j2ke72faaa81004191103qabe0c3ddj959d8804e873ed04@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145368>

On Mon, Apr 19, 2010 at 11:33:49PM +0530, Pavan Kumar Sunkara wrote:
> Implementing a proper and perfect file editor will be a tough job. So,
> I removed it from GSoC and listed in that section.
> But we can always have a simple textarea to implement it and I think I
> will have time to do this simple textarea during my GSoC.

Of course we meant just plain textarea, I think that's more than enough.
I think this would be rather important part of the project.

For later, there's also plenty of javascript editors available that can
be used as drop-ins, though I'm not sure if any of them is programming
oriented. At any rate, I don't see why text editor like this would be
gitweb-specific.

-- 
				Petr "Pasky" Baudis
http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
