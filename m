From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v4 11/26] Move WebDAV HTTP push under remote-curl
Date: Fri, 30 Oct 2009 17:09:33 -0700
Message-ID: <20091031000933.GJ10505@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org> <1256774448-7625-12-git-send-email-spearce@spearce.org> <be6fef0d0910300802t44801cb9n7a129905725f5c56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Clemens Buchacher <drizzd@aon.at>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 01:11:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N41Yn-0008EG-Kw
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 01:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933113AbZJaAJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 20:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933107AbZJaAJ3
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 20:09:29 -0400
Received: from george.spearce.org ([209.20.77.23]:60762 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933077AbZJaAJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 20:09:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 97B8B381D3; Sat, 31 Oct 2009 00:09:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <be6fef0d0910300802t44801cb9n7a129905725f5c56@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131780>

Tay Ray Chuan <rctay89@gmail.com> wrote:
> On Thu, Oct 29, 2009 at 8:00 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > ?update http tests according to remote-curl capabilities
> 
> it would be great if you could mention the $ORIG_HEAD bit:
> 
>  o Use a variable ($ORIG_HEAD) instead of full SHA-1 name.

Thanks, added.

-- 
Shawn.
