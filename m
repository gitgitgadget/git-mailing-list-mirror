From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT] [PATCH] Testsuite: get rid of "Broken pipe" errors from
 yes.
Date: Mon, 30 Apr 2012 12:46:09 -0400
Message-ID: <20120430164604.GF20761@poseidon.cudanet.local>
References: <87k40x346u.fsf@opera.com>
 <20120430150655.GE20761@poseidon.cudanet.local>
 <CAHx6-UmQbcwGiv8xEjJo48cRdQ29KurtZ6O0+yZtJmey7GdrjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Per Cederqvist <ceder@lysator.liu.se>
X-From: git-owner@vger.kernel.org Mon Apr 30 18:46:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOtjt-0002qG-3L
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 18:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756202Ab2D3QqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 12:46:12 -0400
Received: from josefsipek.net ([64.9.206.49]:58776 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755972Ab2D3QqM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 12:46:12 -0400
Received: from poseidon.cudanet.local (unknown [12.200.95.45])
	by josefsipek.net (Postfix) with ESMTPSA id 327CDAF8BB;
	Mon, 30 Apr 2012 12:46:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAHx6-UmQbcwGiv8xEjJo48cRdQ29KurtZ6O0+yZtJmey7GdrjQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196576>

On Mon, Apr 30, 2012 at 05:34:40PM +0200, Per Cederqvist wrote:
> On Apr 30, 2012 5:06 PM, "Jeff Sipek" <jeffpc@josefsipek.net> wrote:
> >
> > On Mon, Apr 30, 2012 at 12:27:21PM +0200, Per Cederqvist wrote:
> > >
> >
> > Looks good.  Interestingly, I haven't seen those errors before.  What's
> your
> > setup like?
> >
> > Jeff.
> 
> I'm running the tests using M-x compile inside Emacs on Ubuntu 11.04. I
> cannot reproduce it in a plain terminal. yes might inherit some signal
> setup that Emacs makes.

Makes sense.

Thanks,

Jeff.

-- 
Don't drink and derive. Alcohol and algebra don't mix.
