From: Andreas Krey <a.krey@gmx.de>
Subject: Re: zealous git convert determined to set up git server
Date: Fri, 16 Sep 2011 22:40:32 +0200
Message-ID: <20110916204032.GA13922@inner.h.iocl.org>
References: <CAOZxsTqtW=DD7zFwQLjknJR8g0nnh0WPUPna6_np4bVoGnSntQ@mail.gmail.com> <CAMK1S_jK2w8v4ushsZztQ0QY-eZq8axso-DpmCCvA=Gp7iXkBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 22:40:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4fDG-0006MP-0Z
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 22:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310Ab1IPUkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 16:40:37 -0400
Received: from continuum.iocl.org ([217.140.74.2]:42208 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759Ab1IPUkh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 16:40:37 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id p8GKeWw16484;
	Fri, 16 Sep 2011 22:40:32 +0200
Content-Disposition: inline
In-Reply-To: <CAMK1S_jK2w8v4ushsZztQ0QY-eZq8axso-DpmCCvA=Gp7iXkBg@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181553>

On Fri, 16 Sep 2011 22:30:35 +0000, Sitaram Chamarty wrote:
...
> Well it *is* pretty darn powerful (I'm the author; allow me some
> preening!) but I believe the real reason is that it is the most
> *transparent* solution.

It well looks so, but I have a question: It seems that it assumes a
flat set of *.git repos. Unfortunately my current setup has the repos
in a hierarchy, like area/sub/repo.git, and I don't want everyone to
change their local repo configs. Is it possible to keep it like that
(and consequently have 'repo area/sub/repo' lines) when putting it
under gitolite control?

Andreas
