From: "Joshua Roys" <roysjosh@gmail.com>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008 projects?
Date: Mon, 18 Aug 2008 21:25:55 -0400
Message-ID: <19b271a20808181825mf2d0de8lc83ba067ed40f4e8@mail.gmail.com>
References: <200807080227.43515.jnareb@gmail.com>
	 <200808140457.56464.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Sam Vilain" <sam@vilain.net>,
	"Sverre Rabbelier" <alturin@gmail.com>,
	"Sverre Rabbelier" <sverre@rabbelier.nl>,
	"David Symonds" <dsymonds@gmail.com>,
	"Lea Wiemann" <LeWiemann@gmail.com>,
	"John Hawley" <warthog19@eaglescrag.net>,
	"Marek Zawirski" <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Stephan Beyer" <s-beyer@gmx.net>,
	"Christian Couder" <chriscool@tuxfamily.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	gittorrent@lists.utsl.gen.nz
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 03:27:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVFzx-0004B4-AR
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 03:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbYHSBZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 21:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753544AbYHSBZ5
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 21:25:57 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:53998 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbYHSBZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 21:25:56 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2233297rvb.1
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 18:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/oVgsdrP/OxS5PbldVaokY5ns2+8z0cNhBLrJv2Ej0o=;
        b=A1/O18V6drOrf79wDTyyrXmzbrtHTOLMBX12FHZOwy7BaXpBy1famAsWyUvG4znZ49
         BU+b5cpJRdyAT8/uDg2ghkFdJ+OgIEz1OJLghWLbNVKuumZYRB1HiJc0s+xS6AZwChj+
         B8Rz1yxiVY9RwNHBjw9eV4brBMoHBzDeTbcAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JdB+jkSr0jHvNoXkFmb+HSJVMrWA+cF/zm7SvCQxAcVes14wwaA0S6Vo3a5I4+ooiM
         0mQmxoFlR4EySdXp+E+19a070U/eXH0qtL/a8D5igXOfT34H66mbl+JA2QUdOmcTBatG
         6K3wxUk2jjlQbASvxXHTFQzgP+gus4VM/JCk4=
Received: by 10.141.36.10 with SMTP id o10mr3740501rvj.176.1219109155797;
        Mon, 18 Aug 2008 18:25:55 -0700 (PDT)
Received: by 10.140.192.21 with HTTP; Mon, 18 Aug 2008 18:25:55 -0700 (PDT)
In-Reply-To: <200808140457.56464.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92803>

Hello all.

As of today, here is the status of GitTorrent.  We can only transfer
repositories under extremely limited circumstances, which is not what
I would consider success, unfortunately.  I apologize for that.  I
would like to continue working on it, and other git things, in the
future though.  This was a really great experience, and in fact my
first actually working (closely) with the Open Source community.
Previously I had only sent in the random patch here and there.

A big 'thank you' to Sam Vilain and the other git folk who helped out.

For the curious that wish to look at the code:
http://utsl.gen.nz/gitweb/?p=VCS-Git-Torrent;a=summary
and a repo.or.cz mirror (since the above randomly fails):
http://repo.or.cz/w/VCS-Git-Torrent.git?a=shortlog

Joshua Roys

On Wed, Aug 13, 2008 at 10:57 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> 1. GitTorrent
>
> Student: Joshua Roys
> Mentor: Sam Vilain
>
> Student retention: One of reasons in Git application for participating
> in GSoC was having "fresh blood", new long-time contributors.  I have
> vague notion that Joshua is quite active not only with GitTorrent, and
> would stay git contributor...
>
