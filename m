From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [EGIT] How to deal with important modifications
Date: Sat, 28 Mar 2009 23:44:49 +0100
Message-ID: <49CEA861.4070700@pelagic.nl>
References: <1238261528.6971.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Mar 28 23:46:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnhIL-000527-7O
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 23:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944AbZC1Wo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 18:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbZC1Wo5
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 18:44:57 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:51155 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751119AbZC1Wo4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Mar 2009 18:44:56 -0400
Received: from [192.168.0.51] (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 13BCE58BD89;
	Sat, 28 Mar 2009 23:44:50 +0100 (CET)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <1238261528.6971.10.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114986>

Yann Simon wrote:
> Hi,
> 
> I am working on the synchronization view. It is not 100% functional yet.
> The view is not updated when a local file is modified for example.
> As the modifications are getting important, I was wondering how to deal
> with it. Should I continue my work an send all the patches when
> finished?
> 
> To have an overview of the modifications:
> http://github.com/yanns/egit/commit/18c4a928d53345802a8c9641dcb2d457ebbe2cbc
> http://github.com/yanns/egit/commit/9fab398fa1b7b6efa9532b3c09e5bcfcc8bb9419
> 
> Or should I begin to send patches, but by not activating the function
> yet?
> (It could be a way to have other people to help contributing.)
> 
> Yann
Yann,

I was asking myself the same questions about my work on ignores and
chose to send it out early, being half completed. Don't know if that was
right, did not receive feedback yet, but it's only been 2 days with
Eclipsecon wrapping up on friday.

If you keep a seperate changeset in which you activate your work and
split up the changesets in manageable pieces it's easier for others to
review your work and comment on it.

Love to see your work though. Having the sync view available for git
would be a major plus. I proposed something simpler on the wiki: a
'pending changes' window. But if you have the complete sync view that's
wonderful.

my 2 cents  :-)

Ferry
