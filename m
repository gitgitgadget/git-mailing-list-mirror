From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 10:30:51 -0700 (PDT)
Message-ID: <20060928173051.94640.qmail@web51004.mail.yahoo.com>
References: <20060928170110.GD3650@socrates.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Sep 28 19:43:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSzv3-0006GD-AR
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 19:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbWI1Rna (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 13:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbWI1Rna
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 13:43:30 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:24729 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1030309AbWI1Rn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 13:43:29 -0400
Received: from pd5mr2so.prod.shaw.ca
 (pd5mr2so-qfe3.prod.shaw.ca [10.0.141.233]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0J6B00ERKD57UW40@l-daemon> for git@vger.kernel.org; Thu,
 28 Sep 2006 11:41:31 -0600 (MDT)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
 by pd5mr2so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar
 15 2004)) with ESMTP id <0J6B000BYD56K3D0@pd5mr2so.prod.shaw.ca> for
 git@vger.kernel.org; Thu, 28 Sep 2006 11:41:31 -0600 (MDT)
Received: from socrates.priv ([68.148.44.50])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0J6B00FL0D569X11@l-daemon> for git@vger.kernel.org; Thu,
 28 Sep 2006 11:41:30 -0600 (MDT)
Received: from socrates.priv (localhost [127.0.0.1])
	by socrates.priv (8.13.4/8.13.4) with ESMTP id k8SHigkS021790	for
 <git@vger.kernel.org>; Thu, 28 Sep 2006 11:44:42 -0600
Received: (from cougar@localhost)	by socrates.priv (8.13.4/8.13.4/Submit)
 id k8SHigRJ021789	for git@vger.kernel.org; Thu, 28 Sep 2006 11:44:42 -0600
Received: from socrates.priv (localhost [127.0.0.1])
	by socrates.priv (8.13.4/8.13.4) with ESMTP id k8SHe1Ar021758	for
 <cougar@localhost>; Thu, 28 Sep 2006 11:40:02 -0600
Received: from serve.wwwroot17.net [209.51.149.122]	by socrates.priv with IMAP
 (fetchmail-6.3.4)	for <cougar@localhost> (single-drop); Thu,
 28 Sep 2006 11:40:02 -0600 (MDT)
Received: from media by serve.wwwroot17.net with local-bsmtp (Exim 4.52)
	id 1GSzip-0000Ed-Vz	for tom.prince@media-group.com; Thu,
 28 Sep 2006 13:31:04 -0400
Received: from [129.128.83.10] (helo=mail.ualberta.net)
	by serve.wwwroot17.net with esmtps (TLSv1:AES256-SHA:256)	(Exim 4.52)
	id 1GSzip-0000EP-1P	for tom.prince@media-group.com; Thu,
 28 Sep 2006 13:30:55 -0400
Received: from web51004.mail.yahoo.com ([206.190.38.135]:30673)
	by mail.ualberta.net with smtp (Exim 4.60)
	(envelope-from <mfoster167@yahoo.com>)
	id 1GSziy-000CjV-06	for tom.prince@ualberta.net; Thu,
 28 Sep 2006 11:31:04 -0600
Received: (qmail 94642 invoked by uid 60001); Thu, 28 Sep 2006 17:30:52 +0000
Received: from [207.172.80.85] by web51004.mail.yahoo.com via HTTP; Thu,
 28 Sep 2006 10:30:51 -0700 (PDT)
In-reply-to: <20060928170110.GD3650@socrates.priv>
To: Tom Prince <tom.prince@ualberta.net>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;  s=s1024; d=yahoo.com;
 h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 b=1WgJQZ8aiCbNkyu7FHzKLSvu88YGVKZ3pf6yjh6VZrhI0l9715XkStL8LU2WuO7E441Ag0Zae7RBlBwgE5lOrlS9GyRFbnCaKN/1p3TP7GpelZudEtSamBXaHaWRbdIQuX/JkiSE3gu9765OowQb2E7xCFbY/HSZS9AnYTn9bzs=  ;
X-Spam-Checker-Version: SpamAssassin 3.1.5 (2006-08-29) on serve.wwwroot17.net
X-Spam-Status: No, score=-2.6 required=8.0 tests=BAYES_00 autolearn=ham
	version=3.1.5
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28026>

--- Tom Prince <tom.prince@ualberta.net> wrote:

> On Thu, Sep 28, 2006 at 09:55:08AM -0700, Matthew L Foster wrote:
> > 
> > --- Rogan Dawes <discard@dawes.za.net> wrote:
> > 
> > > I just don't think that any of the kernel developers feel the need to 
> > > police any one else's clocks . . . they're more interested in the 
> > > contents of the patch.
> > 
> > I am not saying git should "police any one else's clocks", I am saying git should be designed
> or
> > configured in such a way, using local time, that it obviates the current reliance on everyone
> > else's clock being set correctly. 
> > 
> > -Matt
> 
> The point is, it DOES NOT rely on anyone's clock being set correctly.

gitweb.cgi does. It should be possible to export git data, through say a web interface, in a such
a way that local time order is consistent with commit order. 

[responding to Linus' mail here:] I understand that git doesn't care about time internally as it
treats it as a random number for people to care about or not on their own, I am only saying that
local time is more likely to be cared about than disparate remote creation times. 

-Matt


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
