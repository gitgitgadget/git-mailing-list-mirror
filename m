From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v4 00/26] Return of smart HTTP
Date: Thu, 29 Oct 2009 08:28:39 -0700
Message-ID: <20091029152839.GZ10505@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org> <m3my3ad3gp.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 16:28:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Wvd-00017C-BV
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 16:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959AbZJ2P2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 11:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754783AbZJ2P2e
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 11:28:34 -0400
Received: from george.spearce.org ([209.20.77.23]:60027 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754533AbZJ2P2e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 11:28:34 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 457AD381D3; Thu, 29 Oct 2009 15:28:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <m3my3ad3gp.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131601>

Jakub Narebski <jnareb@gmail.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > I think this is the final spin of the smart HTTP series.
>  
> If it is a final spin, then what of missing RFC-like documentation of
> Git HTTP protocol in Documentation/technical/http-protocol.txt
> (it was present only in first version of new series)?

Its still incomplete.  I want to get the code cooking while I work
on the documentation.  Its a separate patch anyway, whether or not
its in the middle of the code series or after it is doesn't matter.

-- 
Shawn.
