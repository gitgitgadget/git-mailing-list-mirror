From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Features from GitSurvey 2010
Date: Thu, 03 Feb 2011 16:33:31 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102031630520.12104@xanadu.home>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino> <201102011451.17456.jnareb@gmail.com>
 <AANLkTinPAL2rEUMe-tRGFxSQ0-gfAJvSO7WW+f+2Fd2u@mail.gmail.com>
 <AANLkTi=_DPSp2P3MuFOPgua2nH7U+RUt4AfAHSyPVv-G@mail.gmail.com>
 <AANLkTi=KUpYJBRMp9ti0h+g6a0iTw4D113rTgfTpR8C4@mail.gmail.com>
 <alpine.LFD.2.00.1102011647000.8580@xanadu.home>
 <FE2BDD68-9CFA-4CBB-9F66-32BE6CF3E174@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 22:33:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl6o6-0000zO-JV
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 22:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376Ab1BCVdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 16:33:32 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58774 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173Ab1BCVdc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 16:33:32 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LG200C7P97VFRE0@VL-MR-MRZ22.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 03 Feb 2011 16:33:31 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <FE2BDD68-9CFA-4CBB-9F66-32BE6CF3E174@adacore.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166001>

On Thu, 3 Feb 2011, Geert Bosch wrote:

> 
> On Feb 1, 2011, at 16:51, Nicolas Pitre wrote:
> 
> > Also... people interested in Narrow clones are likely to be shallow 
> > clone users too, right?
> 
> Not necessarily. Many corporate repositories are huge (caused by
> the concept of 1 central repository with everything in it) and have
> tons of crud (like marketing materials, media-heavy powerpoint
> presentations).  Here you really want a narrow clone (such as the
> sources of the project you're working on), but don't mind having
> the whole history.

OK.  I was asking just to see if the cache pack concept might have to 
cater for that case too.  but let's wait for proper narrow clone support 
first.


Nicolas
