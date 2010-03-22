From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Mon, 22 Mar 2010 20:26:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003222025220.7596@pacific.mpi-cbg.de>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>  <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>  <4BA544FC.7050007@gmail.com> <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>  <4BA61CF9.7040104@gmail.com>
 <41f08ee11003212052p6b0a7495j2e38f24839541ffb@mail.gmail.com>  <m3hbo8jr2e.fsf@localhost.localdomain> <alpine.DEB.1.00.1003221910520.7596@pacific.mpi-cbg.de> <fabb9a1e1003221138n50e30adaxe91ac9503932c35a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Bo Yang <struggleyb.nku@gmail.com>, gitster@pobox.com,
	gitzilla@gmail.com, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 20:26:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtnGp-0007Jk-2B
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 20:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710Ab0CVT0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 15:26:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:47862 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751420Ab0CVT0c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 15:26:32 -0400
Received: (qmail invoked by alias); 22 Mar 2010 19:26:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 22 Mar 2010 20:26:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182vKwEdDw2vPJw3mIfNLET1kcr0/zgvMGG9jE0zX
	VzGvvXIYvoKJGp
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <fabb9a1e1003221138n50e30adaxe91ac9503932c35a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142960>

Hi,

On Mon, 22 Mar 2010, Sverre Rabbelier wrote:

> On Mon, Mar 22, 2010 at 19:21, Johannes Schindelin 
> <Johannes.Schindelin@gmx.de> wrote:
> > As to fuzzy matching of lines that could not be attributed otherwise, 
> > I think that that will require a lot of playing around with different 
> > ideas. A simple Levenshtein-Damerau is highly unlikely to be enough.
> 
> I'd recommend making this either the last milestone, or not a milestone 
> at all. As I noticed with git-stats such metrics might not exist at all 
> (or at least be too hard to find/implement), and it's quite a bummer to 
> not be able to implement your primary milestone ;).

Indeed. TBH, I wanted to ask you to assist in that part of the project. 
You probably can give a good overview over what does not work, and why.

Ciao,
Dscho
