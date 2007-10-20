From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH 3/3] git-cvsexportcommit.perl: git-apply no longer needs --binary
Date: Sat, 20 Oct 2007 15:59:52 +0200
Message-ID: <200710201559.53033.robin.rosenberg.lists@dewire.com>
References: <1192522094-4988-1-git-send-email-mfwitten@mit.edu> <20071017011148.GL13801@spearce.org> <862396DD-A3EA-4850-8AE8-9E765C7FF0F2@MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Michael Witten <mfwitten@mit.edu>
X-From: git-owner@vger.kernel.org Sat Oct 20 15:57:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjEpU-0000sv-Gz
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 15:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194AbXJTN5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 09:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755331AbXJTN5R
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 09:57:17 -0400
Received: from [83.140.172.130] ([83.140.172.130]:14995 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754956AbXJTN5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 09:57:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 4527D802E1B;
	Sat, 20 Oct 2007 15:48:36 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18755-08; Sat, 20 Oct 2007 15:48:36 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id EAFB180266F;
	Sat, 20 Oct 2007 15:48:35 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <862396DD-A3EA-4850-8AE8-9E765C7FF0F2@MIT.EDU>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61837>

onsdag 17 oktober 2007 skrev Michael Witten:
> 
> On 16 Oct 2007, at 9:11:48 PM, Shawn O. Pearce wrote:
> 
> > Sorry, but I have to say I agree with Robin here.  The tab patch
> > is large, ugly, and provides relatively little value in comparsion.
> >
> > The first rule of git development typically is "any change is bad".
> > Because anything that is already written can be assumed to already
> > be tested and in use by someone.  Breaking that is bad, as then
> > they have a bad experience with git.
> 
> OK. I understand.
> 
> This was really preparation for a more substantial addition
> that I hope to make.

That might warrant fixing the tabs, *then*. It is nice to know that this 
debate did not scare you awya from submitting patches. 

> I'll just have to change one line at a time with every substantial
> patch!

Exactly :)
I wrote some more in a commet on the On tabs and spaces thread.

-- robin
