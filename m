From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: when is "git diff" output suitable for patch?
Date: Thu, 13 Jul 2006 17:53:14 -0400
Message-ID: <20060713215313.GO19366@fieldses.org>
References: <20060713212127.GA30770@fieldses.org> <7vhd1lurei.fsf@assigned-by-dhcp.cox.net> <20060713213116.GK19366@fieldses.org> <7v3bd5uqav.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 23:53:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G197W-0003Gt-FM
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 23:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030418AbWGMVxQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 17:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbWGMVxP
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 17:53:15 -0400
Received: from mail.fieldses.org ([66.93.2.214]:60860 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1030418AbWGMVxP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 17:53:15 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1G197S-0000Gi-1V; Thu, 13 Jul 2006 17:53:14 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bd5uqav.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23858>

On Thu, Jul 13, 2006 at 02:51:20PM -0700, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> >> As far as I recall "git diff" never defaulted to -M.
> >
> > Hm.  Is this related?:
> >
> > commit 42efbf6d8a5b4902c55a2f6e96034625c056ba1f
> > Author: Junio C Hamano <junkio@cox.net>
> > Date:   Sat Mar 11 17:44:10 2006 -0800
> >
> >     git-diff: -p disables rename detection.
> 
> Ah, sorry, it _did_ default to -M; it was in such an ancient
> past and the shell wrapper wasn't initially done by me, so I
> misremembered.

Perfectly understandable; thanks for the help.--b.
