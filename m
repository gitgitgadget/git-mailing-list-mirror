From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: [RFC] allow file list editing during cg-commit
Date: Mon, 9 May 2005 01:33:12 -0700
Message-ID: <20050509083312.GA17447@gate.ebshome.net>
References: <20050509041459.GA13475@gate.ebshome.net> <1115627229.8949.132.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 10:26:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DV3aZ-0005Tc-Uv
	for gcvg-git@gmane.org; Mon, 09 May 2005 10:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVEIIdP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 04:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVEIIdP
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 04:33:15 -0400
Received: from gate.ebshome.net ([64.81.67.12]:10457 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S261158AbVEIIdN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 04:33:13 -0400
Received: (qmail 17516 invoked by uid 1000); 9 May 2005 01:33:12 -0700
To: Marcel Holtmann <marcel@holtmann.org>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1115627229.8949.132.camel@pegasus>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.5.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 09, 2005 at 10:27:09AM +0200, Marcel Holtmann wrote:
> Hi Eugene,
> 
> > I just started playing with cogito and failed to find _easy_ way to
> > select which files will be committed and which won't. cg-commit seems
> > to support specifying file list in command line, but this isn't very
> > convenient when the list is big.
> 
> do you know any SCM native text interface that supports such a thing? In
> general this is done by high-level GUI based interfaces to the SCM or a
> special Emacs mode etc.

Perforce works like that. This is where I "stole" this idea :)

I think cogito _is_ UI, a text one, of course.

-- 
Eugene

