From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH v2 1/2] Introduce config variable "diff.primer"
Date: Tue, 3 Feb 2009 11:13:12 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0902031108531.5994@kiwi.cs.ucla.edu>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu> <1233598855-1088-2-git-send-email-keith@cs.ucla.edu> <m3d4dzwdr3.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 20:14:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUQjL-0004PD-GI
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 20:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbZBCTNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 14:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbZBCTNS
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 14:13:18 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:43362 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932AbZBCTNR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 14:13:17 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n13JDCmG011763;
	Tue, 3 Feb 2009 11:13:12 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n13JDCBl011760;
	Tue, 3 Feb 2009 11:13:12 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <m3d4dzwdr3.fsf@localhost.localdomain>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108243>

On Tue, 3 Feb 2009, Jakub Narebski wrote:

> I still think that naming this configuration variable (or configuration 
> section in the reverse primer.diff) 'primer' is not a good idea, because it is 
> quite obscure and not well known word.  In computer related context I have 
> seen it only when talking about introductory / novice / basic level 
> documentation ('primer (textbook)' meaning).  Git user, who might be not a 
> native English speaker, shouldn't have to look up in dictionary what it is 
> about...
> 
> I think that 'defaults' or 'options' would be a much better name.

Point well taken.  Let's consider "primer" the working name.  The final name 
will be the last finishing touch once (and if) we achieve consensus on the 
functionality.  Ultimately the name is best chosen after the functionality is 
certain.  IOW, open to discussion.

                                     -- Keith
