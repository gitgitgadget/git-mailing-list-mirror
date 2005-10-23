From: Petr Baudis <pasky@suse.cz>
Subject: Re: LCA2006 Git/Cogito tutorial
Date: Mon, 24 Oct 2005 00:40:22 +0200
Message-ID: <20051023224022.GX30889@pasky.or.cz>
References: <4358597A.6000306@catalyst.net.nz> <200510231533.j9NFXhOv019272@inti.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Martin Langhoff \(CatalystIT\)" <martin@catalyst.net.nz>,
	Dmitry Torokhov <dtor_core@ameritech.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 00:40:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EToVv-0002xN-O4
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 00:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVJWWkZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 18:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVJWWkZ
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 18:40:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51112 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750823AbVJWWkY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Oct 2005 18:40:24 -0400
Received: (qmail 13990 invoked by uid 2001); 24 Oct 2005 00:40:22 +0200
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200510231533.j9NFXhOv019272@inti.inf.utfsm.cl>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10511>

Dear diary, on Sun, Oct 23, 2005 at 05:33:43PM CEST, I got a letter
where Horst von Brand <vonbrand@inf.utfsm.cl> told me that...
> Martin Langhoff (CatalystIT) <martin@catalyst.net.nz> wrote:
> [...]
> >     MERGE ERROR: : Not handling case  ->  ->
> 
> It happens when a new file with the same name appears in both parents. For
> example, we both see the need for a README file, and then I pull from you
> and try to merge into my version.

It certainly shouldn't happen with precisely that error message - there
should be at least something written between the arrows. And yes, there
are unhandled cases like that, as I wrote in one of my other mails.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
