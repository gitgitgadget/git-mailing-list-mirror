From: Andreas Krey <a.krey@gmx.de>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 14:21:43 +0200
Message-ID: <20130523122143.GQ9448@inner.h.apk.li>
References: <20130522115042.GA20649@inner.h.apk.li> <CAMP44s2zR7qYp58M_TqUqRNW24Ap5m5DsH4WWuHD3MiBu2Wg0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 14:21:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfUWl-00039M-N9
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 14:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758840Ab3EWMVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 08:21:47 -0400
Received: from continuum.iocl.org ([217.140.74.2]:38868 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758099Ab3EWMVr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 08:21:47 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r4NCLhK05057;
	Thu, 23 May 2013 14:21:43 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s2zR7qYp58M_TqUqRNW24Ap5m5DsH4WWuHD3MiBu2Wg0A@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225243>

On Thu, 23 May 2013 06:34:38 +0000, Felipe Contreras wrote:
...
> I don't understand; gitk already shows the first parent starting from
> the bottom, and the merge commits arrive from the right side. What am
> I missing?

That this isn't (consistently) the case in complicated situations.
I'll need to make a picture (as in png).

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
