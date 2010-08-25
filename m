From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH v2] t7610 (mergetool): more nitpicks
Date: Wed, 25 Aug 2010 08:56:50 +0100
Message-ID: <20100825075650.GB18308@hashpling.org>
References: <1282617444-641-1-git-send-email-brian@gernhardtsoftware.com>
 <20100824030524.GF17406@burratino>
 <20100825002552.GI2376@burratino>
 <20100825074034.GA4058@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 09:57:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoAqx-0007it-OI
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 09:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347Ab0HYH4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 03:56:54 -0400
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:35821 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752308Ab0HYH4w (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 03:56:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEADJpdEzUnw4U/2dsb2JhbACgOXG7ZoU3BA
Received: from outmx08.plus.net ([212.159.14.20])
  by relay.ptn-ipout02.plus.net with ESMTP; 25 Aug 2010 08:56:51 +0100
Received: from hashpling.plus.com ([212.159.69.125])
	 by outmx08.plus.net with esmtp (Exim) id 1OoAqo-0007oN-HR; Wed, 25 Aug 2010 08:56:50 +0100
Received: from charles by hashpling.plus.com with local (Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1OoAqo-0007kj-14; Wed, 25 Aug 2010 08:56:50 +0100
Content-Disposition: inline
In-Reply-To: <20100825074034.GA4058@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154433>

On Wed, Aug 25, 2010 at 12:40:38AM -0700, David Aguilar wrote:
> On Tue, Aug 24, 2010 at 07:25:52PM -0500, Jonathan Nieder wrote:
> >  - use tabs to indent
> > [...]
> 
> Cool.  I'd like to do the same to git-mergetool.sh too.
> Until now I've stuck to the existing style.
> My editor is setup to display tabs visually which makes it easy
> for me to emulate existing code but not everyone does that.
> 
> Any objections to a patch that replaces the mixed 4-space+tab
> indents with pure tabs?

Just the same objection as the last time:

http://thread.gmane.org/gmane.comp.version-control.git/115069/focus=115192

We've already tidyied up mergetool to be consistent, I don't see what
touching 90% of the lines achieves other than getting yourself
'blamed' for everything in mergetool.

Charles.
