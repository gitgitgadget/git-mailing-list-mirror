From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Extremely simple Vim interface for Git
Date: Mon, 8 Sep 2008 08:26:36 +0300
Message-ID: <20080908052636.GA3251@mithlond.arda.local>
References: <20080906193744.GA3122@mithlond.arda.local> <d2e97e800809070332t35e4ed46u7af4653ea768b39b@mail.gmail.com> <20080907131356.GC3387@mithlond.arda.local> <d2e97e800809071547m2b2e0f82ycc370f048d826b2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 07:27:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcZHv-0003n6-Cr
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 07:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbYIHF0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 01:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752497AbYIHF0k
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 01:26:40 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:54611 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355AbYIHF0j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 01:26:39 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 488F153401DB689B; Mon, 8 Sep 2008 08:26:37 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KcZGm-00012A-21; Mon, 08 Sep 2008 08:26:36 +0300
Content-Disposition: inline
In-Reply-To: <d2e97e800809071547m2b2e0f82ycc370f048d826b2d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95217>

Michael Wookey wrote (2008-09-08 08:47 +1000):

> Vim 7.2 provides a better alternative.  If the command is specifically
> 'git' then setting the filetype to 'git' also provides the correct
> syntax highlighting.

Thanks, I didn't know that. Definitely better. I see filetype "git" is 
already in my Vim 7.1.314 (Debian Etch backports).

> Perhaps some of these ideas should be added to the Vim wiki...
> 
> http://vim.wikia.com/wiki/Display_shell_commands%27_output_on_Vim_window

This Vim tip was originally written by me. I extended it with the 
version control tools.
