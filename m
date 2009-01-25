From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH v1 0/3] Introduce config variable "diff.primer"
Date: Sun, 25 Jan 2009 12:41:21 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0901251239000.12651@kiwi.cs.ucla.edu>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <7vr62rcee5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 21:43:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRBof-0002Zr-Oz
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 21:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbZAYUl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 15:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbZAYUlZ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 15:41:25 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:37707 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbZAYUlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 15:41:25 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n0PKfLP0016183;
	Sun, 25 Jan 2009 12:41:21 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n0PKfL5f016180;
	Sun, 25 Jan 2009 12:41:21 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <7vr62rcee5.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107101>

On Sun, 25 Jan 2009, Junio C Hamano wrote:

> I am puzzled.
> 
> The gitattributes mechanism is about per-path settings, but I do not think a 
> mnemonicprefix that is per-path makes much sense.

That was just an example (perhaps poorly chosen).  What I meant to suggest is 
making gitattributes consistent with gitconfig WRT at least the [diff] section.  
But maybe that's not appropriate.  Thanks for the insight.
