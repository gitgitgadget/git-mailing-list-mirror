From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Sat, 21 Oct 2006 10:40:43 +0200
Message-ID: <200610211040.44333.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610201630000.3962@g5.osdl.org> <7vk62ujw7j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jan Hudec <bulb@ucw.cz>,
	bazaar-ng@lists.canonical.com, Jeff Licquia <jeff@licquia.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Oct 21 10:40:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbCPK-0003K8-96
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 10:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992852AbWJUIki (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 04:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992855AbWJUIki
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 04:40:38 -0400
Received: from hu-out-0506.google.com ([72.14.214.228]:25704 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S2992852AbWJUIkh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 04:40:37 -0400
Received: by hu-out-0506.google.com with SMTP id 28so507592hub
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 01:40:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fD9UY6tWFi4bvBOE5hHzMELpvm0PPYGohJ2wedrietK5UhhDwsvm1jSYFBBTLdKHERQtxvwUMPp5VrYciCzkQXADK4EWDbAkKte2/vhNCedA/AmntAn2pAOxbP0Eer5FI5rJ0TlVejFUs3ETnvoG2rHvF7BJmmHahna41vxEuEI=
Received: by 10.67.121.15 with SMTP id y15mr3460435ugm;
        Sat, 21 Oct 2006 01:40:35 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id x26sm2239735ugc.2006.10.21.01.40.35;
        Sat, 21 Oct 2006 01:40:35 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vk62ujw7j.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29593>

Junio C Hamano wrote:

> For people new to the list, the message is:
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/27/focus=217
> 
> I think I've quoted this link at least three times on this list;
> I consider it is _the_ most important message in the whole list
> archive.  If you haven't read it, read it now, print it out,
> read it three more times, place it under the pillow before you
> sleep tonight.  Repeat that until you can recite the whole
> message.  It should not take more than a week.
> 
> To me, personally, achieving that ideal "drill down" dream was
> one of the more important goals of my involvement in this
> project.  I did diffcore-rename to fill some part of the dream,
> and then diffcore-pickaxe to fill some other part.  Neither was
> even close.  I think the recent round of pickaxe is getting much
> closer.

What I find lacking in this mail, and in git as it is now, is
somehow remembering and perhaps even propagating user's corrections
to automatic contents movement (which includes file renames and
file copying) detection.
-- 
Jakub Narebski
Poland
