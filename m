From: Pavel Roskin <proski@gnu.org>
Subject: Re: git 1.5.1-rc1 doesn't like empty files
Date: Tue, 20 Mar 2007 01:50:38 -0400
Message-ID: <1174369838.8210.9.camel@dv>
References: <1174361424.3143.42.camel@dv>
	 <Pine.LNX.4.64.0703192148430.6730@woody.linux-foundation.org>
	 <1174367312.3143.75.camel@dv>
	 <Pine.LNX.4.64.0703192237100.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Alexander Litvinov <litvinov2004@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 06:50:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTXFE-0000ZJ-O8
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 06:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbXCTFuu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 01:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752177AbXCTFuu
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 01:50:50 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:40013 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbXCTFut (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 01:50:49 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HTXDF-0001Op-0M
	for git@vger.kernel.org; Tue, 20 Mar 2007 01:48:49 -0400
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1HTXF0-0007ed-Ho; Tue, 20 Mar 2007 01:50:38 -0400
In-Reply-To: <Pine.LNX.4.64.0703192237100.6730@woody.linux-foundation.org>
X-Mailer: Evolution 2.10.0 (2.10.0-2.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42717>

On Mon, 2007-03-19 at 22:41 -0700, Linus Torvalds wrote:
> 
> On Tue, 20 Mar 2007, Pavel Roskin wrote:
> > 
> > .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391 is the same 9
> > bytes:  30 78 9c 03 00 00 00 00 01
> 
> Ahh.. You have
> 
> 	[core]
> 		legacyheaders = false

Yes.

-- 
Regards,
Pavel Roskin
