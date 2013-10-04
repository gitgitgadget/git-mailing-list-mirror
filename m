From: Miklos Vajna <vmiklos@suse.cz>
Subject: Re: [PATCH] Documentation/Makefile: make AsciiDoc dblatex dir
 configurable
Date: Fri, 4 Oct 2013 07:43:08 +0200
Message-ID: <20131004054308.GA5947@collabora.co.uk>
References: <6c148f88f6efb7c5d7a9a03f8383b47f939b36ec.1380827852.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Oct 04 07:43:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRyAa-0004xa-Qr
	for gcvg-git-2@plane.gmane.org; Fri, 04 Oct 2013 07:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214Ab3JDFnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Oct 2013 01:43:17 -0400
Received: from bhuna.collabora.co.uk ([93.93.135.160]:38546 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab3JDFnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Oct 2013 01:43:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(Authenticated sender: vmiklos)
	with ESMTPSA id 3AE642688035
Content-Disposition: inline
In-Reply-To: <6c148f88f6efb7c5d7a9a03f8383b47f939b36ec.1380827852.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235697>

On Thu, Oct 03, 2013 at 08:17:32PM +0100, John Keeping <john@keeping.me.uk> wrote:
> On my system this is in /usr/share/asciidoc/dblatex not
> /etc/asciidoc/dblatex.  Extract this portion of the path to a variable
> so that is can be set in config.mak.

Sure, makes sense.
