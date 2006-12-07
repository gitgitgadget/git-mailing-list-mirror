X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation: reorganize cvs-migration.txt
Date: Thu, 7 Dec 2006 10:21:44 -0500
Message-ID: <20061207152144.GA13613@fieldses.org>
References: <20061206.105251.144349770.wl@gnu.org> <Pine.LNX.4.63.0612061325320.28348@wbgn013.biozentrum.uni-wuerzburg.de> <4576D92A.80307@xs4all.nl> <20061206145802.GC1714@fieldses.org> <Pine.LNX.4.63.0612061613460.28348@wbgn013.biozentrum.uni-wuerzburg.de> <20061206171950.GD1714@fieldses.org> <20061206172450.GE1714@fieldses.org> <7v7ix47wbr.fsf@assigned-by-dhcp.cox.net> <20061207041805.GC3457@fieldses.org> <7vu008uucx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 15:22:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vu008uucx.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33588>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsL53-0006UR-0w for gcvg-git@gmane.org; Thu, 07 Dec
 2006 16:22:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937978AbWLGPVr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 10:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937980AbWLGPVr
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 10:21:47 -0500
Received: from mail.fieldses.org ([66.93.2.214]:59753 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937978AbWLGPVq (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 10:21:46 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GsL4D-0003Zn-0l; Thu, 07 Dec 2006
 10:21:45 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Wed, Dec 06, 2006 at 09:51:10PM -0800, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> > diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
> > index 6812683..773fc99 100644
> > --- a/Documentation/cvs-migration.txt
> > +++ b/Documentation/cvs-migration.txt
> > @@ -1,113 +1,21 @@
> 
> This conflicted in a funny way with your own commit but I think
> this version (773fc99 blob) supersedes its contents.

Oh, yeah, sorry, I should have made an incremental patch.

> I munged only one line, though.  The title of this section 
> should not be "a CVS repository" but "a shared repository" for
> obvious reasons ;-).

Oops, yes, thanks!

