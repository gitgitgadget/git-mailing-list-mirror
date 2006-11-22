X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: StGit metadata grabbing with git clone
Date: Wed, 22 Nov 2006 22:38:00 +0100
Message-ID: <20061122213800.GM7201@pasky.or.cz>
References: <87ac2jwutu.fsf@neumann.lab.ossystems.com.br> <200611222129.24369.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 22 Nov 2006 21:38:23 +0000 (UTC)
Cc: Otavio Salvador <otavio@debian.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611222129.24369.robin.rosenberg.lists@dewire.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32104>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmznP-0007jl-1u for gcvg-git@gmane.org; Wed, 22 Nov
 2006 22:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757043AbWKVViF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 16:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757040AbWKVViF
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 16:38:05 -0500
Received: from w241.dkm.cz ([62.24.88.241]:50098 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1757043AbWKVViC (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 16:38:02 -0500
Received: (qmail 22363 invoked by uid 2001); 22 Nov 2006 22:38:00 +0100
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org

On Wed, Nov 22, 2006 at 09:29:24PM CET, Robin Rosenberg wrote:
> onsdag 22 november 2006 13:05 skrev Otavio Salvador:
> > Hello,
> >
> > I'm a happy user of stgit together with git to maintain a patch queue
> > while I or the company team is working on patches that will be send
> > for merging. Both works great but we're having troubles when we try to
> > clone a stgit repository.
> >
> > When I clone the repository it grab the source but it loses the
> > metadata. I would like to grab those too. Does anybody has a solution
> > or a trick how I can do that?
> 
> You can copy the repo using rsync or scp instead of git-clone or use stg 
> uncommit after the regular clone. 

How do you sync them then?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
