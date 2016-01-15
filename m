From: Mike Hommey <mh@glandium.org>
Subject: Re: Announcing git-cinnabar 0.3.0
Date: Fri, 15 Jan 2016 18:40:05 +0900
Message-ID: <20160115094005.GA24233@glandium.org>
References: <20160115085658.GA15539@glandium.org>
 <alpine.DEB.2.20.1601151022050.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 15 10:40:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK0ro-0001Gn-7I
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 10:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757255AbcAOJkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 04:40:13 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:57500 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757064AbcAOJkL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 04:40:11 -0500
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <mh@glandium.org>)
	id 1aK0rV-0006LV-Fq; Fri, 15 Jan 2016 18:40:05 +0900
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1601151022050.2964@virtualbox>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284154>

On Fri, Jan 15, 2016 at 10:25:14AM +0100, Johannes Schindelin wrote:
> Hi Mike,
> 
> On Fri, 15 Jan 2016, Mike Hommey wrote:
> 
> > Git-cinnabar is a git remote helper to interact with mercurial
> > repositories. It allows to clone, pull and push from/to mercurial remote
> > repositories, using git.
> 
> Great news! I was really sad when Sverre's work on remote-hg was basically
> ignored and replaced (and he went away after that), and then the
> replacement was not maintained properly.
> 
> So I am personally very happy that there is a well-maintained alternative
> now.
> 
> Hopefully I will get a chance to test this soon, but I already have one
> comment: at
> > 1. https://github.com/glandium/git-cinnabar/wiki/Windows-Support
> 
> ... it is mentioned that...
> 
> 	Git for Windows 32-bits is untested, but assumed to have the same
> 	issue as MSys2 32-bits
> 
> ... but as is mentioned here:
> 
> 	https://github.com/git-for-windows/git/wiki/32-bit-issues
> 
> Git for Windows executes the rebaseall step as part of the installation,
> so it should not have the same issue as MSys2 32-bits ;-)

Please feel free to update the wiki page, it should be publicly editable
:)

Mike
