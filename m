From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Newbie grief
Date: Fri, 4 May 2012 16:56:06 +0100
Message-ID: <20120504155606.GB30130@sirena.org.uk>
References: <86mx5rmx32.fsf@red.stonehenge.com>
 <4FA055D0.7040102@palm.com>
 <86aa1rmvhb.fsf@red.stonehenge.com>
 <4FA05E9F.9090709@palm.com>
 <CAJsNXTmo1B86nSm7u923jJuGX0zajz3iqVu-onANMN-5BE5DfQ@mail.gmail.com>
 <4FA2D1D7.3020807@palm.com>
 <CA+7g9JzZ36RgsniT4UN0Zk+z1ohZYW5u+0AoGMjJZqsoBjqvqA@mail.gmail.com>
 <4FA2D97A.8090504@palm.com>
 <86ipgdhvjo.fsf@red.stonehenge.com>
 <4FA2F013.3020904@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Nathan Gray <n8gray@n8gray.org>,
	PJ Weisberg <pj@irregularexpressions.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Fri May 04 17:56:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQKrq-0005Mi-4K
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 17:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378Ab2EDP4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 11:56:20 -0400
Received: from cassiel.sirena.org.uk ([80.68.93.111]:44863 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab2EDP4T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 11:56:19 -0400
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.72)
	(envelope-from <broonie@sirena.org.uk>)
	id 1SQKrW-0000a0-7V; Fri, 04 May 2012 16:56:06 +0100
Content-Disposition: inline
In-Reply-To: <4FA2F013.3020904@palm.com>
X-Cookie: Swap read error.  You lose your mind.
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: broonie@sirena.org.uk
X-SA-Exim-Scanned: No (on cassiel.sirena.org.uk); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197032>

On Thu, May 03, 2012 at 01:52:35PM -0700, Rich Pixley wrote:

> It's not just hg.  It's other source code control systems as well.
> Check out any of the other daggy guys.  So sure, I'll admit a bias
> for current technology over older tech.

I'm still not sure what's missing here without a central server?   The
other DVCSs I've used (which don't include hg) do require that the user
trigger a merge operation somehow; they don't magically go and merge
things without being asked.  The only thing I've noticed that git does
differently is that it caches the remote branches locally by default
when remotes are set up.
