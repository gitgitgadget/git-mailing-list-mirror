From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [GSoC] Git projects for Google Summer of Code 2008 final evaluation
Date: Mon, 15 Sep 2008 14:13:35 +0200
Message-ID: <200809151413.37628.jnareb@gmail.com>
References: <200809042315.58898.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam@vilain.net>, Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 15 14:16:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfCym-0007uV-Dg
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 14:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbYIOMNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 08:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbYIOMNs
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 08:13:48 -0400
Received: from rn-out-0910.google.com ([64.233.170.185]:17909 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbYIOMNr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 08:13:47 -0400
Received: by rn-out-0910.google.com with SMTP id k40so1234255rnd.17
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 05:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=wkZk8u0Fwd3d0Xp9U+tRmrOa7w8KGYkKq4xL+aZH6Qk=;
        b=U39FpO1KyXiUd2XW+Fy/WdG9Nfm6F7r6C31bLEFG2/QevhqqFAU6txjEFuy1NEJ0JR
         SC2fYifhTyBqGP7f7NbDeEOw0DDP8ZmnsQlO33a0DB9P2MEYzNy4AiwBz29H2lxCLdHC
         +6fUpskZeDhCPy0754v51RInchj73pvu7CNwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Ozho5bisjKHBnlZF//COu6WndELoPxJnZHLXlI3iDOiC7bqHFhTHgWYYz+6mE25hV0
         uJU1uft3KA40LcebjMhKvjViqfril8MwFiVhkGCEt7prLHJLDSof1OE47jltmfAuqMCu
         M6f1DJpxH7HBpodU65gaUUEP2CbDTt8VwkATw=
Received: by 10.86.98.14 with SMTP id v14mr5864476fgb.74.1221480826603;
        Mon, 15 Sep 2008 05:13:46 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.248.215])
        by mx.google.com with ESMTPS id 4sm17236693fge.8.2008.09.15.05.13.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Sep 2008 05:13:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200809042315.58898.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95901>

On Thu, 4 Sep 2008, Jakub Narebski wrote:

> Mentors, could you tell us your side about how it was working as a 
> mentor for Google Summer of Code? Perhaps some tricks of trade?

By the way, I have found via LWN that Perl has written nice summary
of theirs Google Summer of Code projects[1].  Among other they very much
praise that students did blogging about their progress:

  "use Perl | Summer of Code recap"
  http://use.perl.org/articles/08/08/29/1224242.shtml

  Most of the students did a great job of blogging their progress, which
  I think is an important part of Summer of Code for the rest of the
  community.

What do you think about it (for example about doing it in a future
if our informal Git Development Community would participate in next
Google Summer of Code programs)?


[1] I plan to add quick summary of final results to GSoC2008 wiki page, 
http://git.or.cz/gitwiki/SoC2008Projects, of course if GSoC manager(s),
mentors, or students don't do it first...

-- 
Jakub Narebski
Poland
