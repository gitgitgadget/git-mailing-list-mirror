From: Eric Raymond <esr@thyrsus.com>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Sun, 28 Mar 2010 08:10:34 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100328121034.GC25402@thyrsus.com>
References: <3d4937ff1003262240t6159d9c5sc9253f555c3aed1@mail.gmail.com>
 <20100327091938.GA4395@thyrsus.com>
 <f3271551003280225v17af30d4s6d3d24b4d548ff7d@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Peter Baumann <waste.manager@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Dave Olszewski <cxreg@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Steven Michalske <smichalske@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 14:10:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvrKD-00016s-Ax
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 14:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191Ab0C1MKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 08:10:36 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:33606
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab0C1MKf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 08:10:35 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 3E16820CB1C; Sun, 28 Mar 2010 08:10:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <f3271551003280225v17af30d4s6d3d24b4d548ff7d@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143387>

Ramkumar Ramachandra <artagnon@gmail.com>:
> Project Proposal: git-remote-svn | Native SVN support in Git
> Student: Ramkumar Ramachandra
> Mentor: Sverre Rabbelier

+1

I've just been through a Subversion-to-git migration, and have been
directly affected by an inadequacy in git-svn - failure to recognizer
SVN tags as tags rather than branches. See my blog post at
<http://esr.ibiblio.org/?p=1806>, "Subversion to GIT Migration: A Tale
of Two Gotchas" for discussion.

Accordingly, I support Ramkumar's proposal to rethink and rewrite the 
Subversion interface.  A concerted effort to do seamless interoperability 
would be well justified given the ubiquity of Subversion.  I think Rankumar
has chosen a goal that is useful, well defined, and realistically scoped.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
