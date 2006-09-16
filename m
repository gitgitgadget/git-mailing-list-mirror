From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] gitweb: export-ok option
Date: Sat, 16 Sep 2006 22:33:33 +0200
Message-ID: <20060916203333.GA29036@moooo.ath.cx>
References: <20060916192750.GA27008@moooo.ath.cx> <eehjtn$ipm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Sep 16 22:34:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOgrI-0002Qq-Vd
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 22:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWIPUdh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 16:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWIPUdh
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 16:33:37 -0400
Received: from moooo.ath.cx ([85.116.203.178]:53415 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751473AbWIPUdg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Sep 2006 16:33:36 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <eehjtn$ipm$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27131>

Jakub Narebski <jnareb@gmail.com> wrote:
> Matthias Lederhofer wrote:
> 
> > Perhaps there should be another option which allows only those
> > repositories to be shown which are in $projects_list.
> 
> If $projects_list is a file (and not directory), only repositories
> specified there are shown.

The main problem is not the list of projects. Every repository below
$project_root can be viewed using ?p=path/to/repostory.
