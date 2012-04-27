From: <dag@cray.com>
Subject: Re: Subtree in Git
Date: Fri, 27 Apr 2012 15:38:49 -0500
Message-ID: <nngk410vrja.fsf@transit.us.cray.com>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 22:39:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNrwR-00058D-Ud
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 22:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758735Ab2D0Uiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 16:38:55 -0400
Received: from exprod6og111.obsmtp.com ([64.18.1.27]:38309 "EHLO
	exprod6og111.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab2D0Uiy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 16:38:54 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob111.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT5sD3SmSSetjxIOniDvLo9y9uPD0xfKt@postini.com; Fri, 27 Apr 2012 13:38:54 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 27 Apr
 2012 15:38:52 -0500
In-Reply-To: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
	(Hilco Wijbenga's message of "Fri, 27 Apr 2012 11:48:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196484>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> Do we have an idea of when subtree support will be a part of Git core?
> I am aware that I can install it separately but I'd like to know if
> there is something like a timeline or a target Git version number. And
> "no", is fine. :-)

We don't know right now.  I want to take a look at Herman's patches
first but have been delayed for various reasons.  I hope to get to that
this weekend.  I also want to get at least one release under our belt.

                             -Dave
