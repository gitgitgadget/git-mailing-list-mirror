From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 01:15:48 +0200
Message-ID: <20080910231548.GE22739@cuci.nl>
References: <20080909194354.GA13634@cuci.nl> <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org> <20080909235848.GE7459@cuci.nl> <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org> <48C785C3.9010204@gnu.org> <alpine.LFD.1.10.0809100830570.3384@nehalem.linux-foundation.org> <48C7E9A1.5080409@gnu.org> <alpine.LFD.1.10.0809100841080.3384@nehalem.linux-foundation.org> <alpine.LFD.1.10.0809100844040.3384@nehalem.linux-foundation.org> <48C7EE71.8080305@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 01:17:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdYvt-0006Z6-3i
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 01:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbYIJXPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 19:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752186AbYIJXPu
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 19:15:50 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:39612 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbYIJXPt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 19:15:49 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 153215465; Thu, 11 Sep 2008 01:15:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48C7EE71.8080305@gnu.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95568>

Paolo Bonzini wrote:
>> Btw, so far nobody has even _explained_ what the advantage of the origin 
>> link is. It apparently has no effect for most things, and for other things 
>> it has some (unspecified) effect when it can be resolved.

>> Apart from the "dotted line" in graphical history viewers, I haven't 
>> actually heard any single concrete example of exactly what it would *do*.

It allows one to follow and view the evolvement of a patch over time during
the various backports.
-- 
Sincerely,
           Stephen R. van den Berg.

"Am I paying for this abuse or is it extra?"
