From: Yann Dirson <ydirson@altern.org>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Tue, 30 Jan 2007 22:25:11 +0100
Message-ID: <20070130212511.GA5362@nan92-1-81-57-214-146.fbx.proxad.net>
References: <87odognuhl.wl%cworth@cworth.org> <epobn1$jv8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 22:26:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC0UQ-0002UB-2n
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 22:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbXA3VZ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 16:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbXA3VZ6
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 16:25:58 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:34285 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbXA3VZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 16:25:57 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 2B2B25B6D;
	Tue, 30 Jan 2007 22:25:56 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 170831F080; Tue, 30 Jan 2007 22:25:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <epobn1$jv8$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38205>

On Tue, Jan 30, 2007 at 10:02:40PM +0100, Jakub Narebski wrote:
> > I propose this warning be removed here. Otherwise, I either add text
> > to my instructions telling the user to ignore the warning message they
> > get, or else I go back to "-b build" and back to all the old problems
> > it causes.
> 
> I rather leave warning, but (perhaps around 1.5.1) remove the
> instructions. RTFM (err... I'm not sure we have one about detached HEAD).

Or provide a "-q" flag to silence the warning ?

-- 
Yann.
