From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Enable setting attach as the default in .gitconfig 
  for git-format-patch.
Date: Mon, 9 Feb 2009 14:36:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de> <499022D3.3000200@drmicha.warpmail.net> <49902EDC.6020901@beonex.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jeremy White <jwhite@codeweavers.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Ben Bucksch <ben.bucksch.news@beonex.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 14:37:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWWK1-0007Sj-R8
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 14:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505AbZBINfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 08:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754366AbZBINfq
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 08:35:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:42036 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755428AbZBINfp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 08:35:45 -0500
Received: (qmail invoked by alias); 09 Feb 2009 13:35:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 09 Feb 2009 14:35:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+G3hdIzy6Gku7QsAQaF4CI9N3r9LTDBCY7x6t33J
	IXsaTmgOi6PpSp
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49902EDC.6020901@beonex.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109069>

Hi,

On Mon, 9 Feb 2009, Ben Bucksch wrote:

> On 09.02.2009 13:34, Michael J Gruber wrote:
> > Johannes Schindelin venit, vidit, dixit 08.02.2009 18:28:
> >    
> > > On Sun, 8 Feb 2009, Jeremy White wrote
> > > > Essentially, the problem is well understood - Thunderbird uses
> > > > format=flowed by default, which is what mangles the patches.
> > > >        
> > > I guess I'll start discouraging use of Thunderbird from now on.
> 
> Or you could just publish:
> 1. Prefs | Advanced | General | Config Editor...
> 2. "mailnews.send_plaintext_flowed" = false

Ah.  Mhm...

> As inline attachments, they'll show up inline in the msg viewer as well 

... which is a moot point, as the responder has to do extra work to quote 
the stuff.  Definitely not my type of friendliness.

> > I found git-send-email the more reliable and practical solution for 
> > sending out patches. Put yourself in bcc and you'll have a copy in 
> > TB's inbox or another folder (use filters).
> 
> Yup, I think that's the best way - git is using email only as protocol, so
> it's good to have special clients to that, as it's a really special use.

Aha.  And putting extra comments in (manually) does not count.  'cause I 
do not see send-email allowing that.

> > <sarcasm style="reality: exaggerated;">
> > Isn't that some Linux guy? How would he matter for Mozilla? Does he even
> > know how to send HTML mail...
> > </sarcasm>
> >    
>
> I don't think it's a matter of clue, it's a matter of background and 
> attitude.

Yeah, I think my background dictates that I stay by my word and recommend 
other mailers than Thunderbird.

It is one thing to be nice to the "average" user, but another one to be 
unfriendly to the people making the internet revolution possible.

Ciao,
Dscho
