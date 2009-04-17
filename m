From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 1/3] Changed Transport class hierarchy basing on
	underlying transport
Date: Fri, 17 Apr 2009 08:40:16 -0700
Message-ID: <20090417154016.GR23604@spearce.org>
References: <85647ef50904160703y3a416294k54f21b50f6006040@mail.gmail.com> <20090417145846.GP23604@spearce.org> <85647ef50904170830iccabee9n5a7a6cdb283654f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 17:42:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuqCN-0000Lm-Vk
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 17:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004AbZDQPkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 11:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbZDQPkR
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 11:40:17 -0400
Received: from george.spearce.org ([209.20.77.23]:41101 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936AbZDQPkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 11:40:16 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4167338211; Fri, 17 Apr 2009 15:40:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <85647ef50904170830iccabee9n5a7a6cdb283654f9@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116750>

Constantine Plotnikov <constantine.plotnikov@gmail.com> wrote:
> On Fri, Apr 17, 2009 at 6:58 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Constantine Plotnikov <constantine.plotnikov@gmail.com> wrote:
> >
> > The entire patch looks fine. ?Except its corrupted by line wrapping
> > by your MUA. ?Can you please resend without using format-flawed ?
> > :-)
> >
> I have now tried to send via gmail.com using git imap-send, please
> tell if it was transferred correctly.

Nope, its still corrupted.

I tried fixing up the wrapped lines by hand, but there's tab->space
conversions in context lines, so it won't apply even after I tried
to fix the wrapped lines.

-- 
Shawn.
