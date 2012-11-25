From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 04:54:29 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121125095429.GB22279@thyrsus.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CACsJy8BbUjrJtfpEvbcK==Y2gFNsFhFBN93CL36J5uVe=Ca4wQ@mail.gmail.com>
 <20121125051809.GA3670@thyrsus.com>
 <CAMP44s0r1J=aOuEpKQ1+ew9FzODwLX-w5z9rG-WN6AjU0o97yw@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 10:55:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcYw9-0003bl-2c
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 10:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873Ab2KYJzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 04:55:21 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:42069
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626Ab2KYJzV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 04:55:21 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 5EE684065F; Sun, 25 Nov 2012 04:54:29 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAMP44s0r1J=aOuEpKQ1+ew9FzODwLX-w5z9rG-WN6AjU0o97yw@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210344>

Felipe Contreras <felipe.contreras@gmail.com>:
> On Sun, Nov 25, 2012 at 6:18 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
> > Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> >> These may apply to other languages as well. Where do we draw a line?
> >
> > I'm in favor of the general policy of avoiding scripting languages
> > other than the top three most widely deployed.  At the moment that
> > means shell, Python, Perl; on present trends, in a few years Perl
> > (dropping in popularity) might be passed by Ruby on the way up.
> 
> Top three according to whom?

According to the LOC counts in git's codebase.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
