From: Pavel Roskin <proski@gnu.org>
Subject: Re: [RFC] qgit with tabs
Date: Sat, 13 May 2006 14:28:40 -0400
Message-ID: <20060513142840.39c0kwkw84g8g88g@webmail.spamcop.net>
References: <e5bfff550605130344n75e3e55eq533c49fc2a4f5483@mail.gmail.com>
	<20060513070726.qa5ssccws80go044@webmail.spamcop.net>
	<e5bfff550605130431w417b8aacl2b17cf5655b46f31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 13 20:28:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Feyr7-0006Mi-GY
	for gcvg-git@gmane.org; Sat, 13 May 2006 20:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWEMS2m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 14:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWEMS2m
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 14:28:42 -0400
Received: from mailgate.cesmail.net ([216.154.195.36]:46034 "HELO
	mailgate.cesmail.net") by vger.kernel.org with SMTP id S932493AbWEMS2l
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 May 2006 14:28:41 -0400
Received: (qmail 17692 invoked from network); 13 May 2006 18:28:40 -0000
Received: from unknown (HELO gamma.cesmail.net) (192.168.1.20)
  by mailgate.cesmail.net with SMTP; 13 May 2006 18:28:40 -0000
Received: (qmail 24326 invoked by uid 99); 13 May 2006 18:28:40 -0000
Received: from wsip-70-168-203-106.ri.ri.cox.net
	(wsip-70-168-203-106.ri.ri.cox.net [70.168.203.106]) by webmail.spamcop.net
	(Horde) with HTTP for <proski@spamcop.net@cesmail.net>; Sat, 13 May 2006
	14:28:40 -0400
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550605130431w417b8aacl2b17cf5655b46f31@mail.gmail.com>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19943>

Quoting Marco Costalba <mcostalba@gmail.com>:

> > Just one thing for now.  Double click on a file on the "rev list" tab
> should
> > show the patch (what Ctrl-P would do), not the whole file.  That would be
> more
> > compatible with gitk, and it's what I normally need if I just browse the
> latest
> > changes in the rev list.
> >
>
> Well, double click activates the current top entry in context menu.

That's a good thing.  But I think that the top entry should be different.

> This behaviour has not changed from past releases.

I know.  But as the more prominent issues are sorted out, minor things become
more visible.

> To show the patch
> perhaps you may, as always, double click on the selected revision, in
> revisions list.

Sure, but I often want to see what changed in a particular file.

And of course I only mean the subwindow dislaying the files affected by the
patch.  The file tree should still have file annotation bound to the double
click.

> FWIK gitk does not have a file content viewer.

That's true.  The reason may be because changes are more interesing than the
whole file in the context of git (as opposed to the context of an editor or a
compiler).

--
Regards,
Pavel Roskin
