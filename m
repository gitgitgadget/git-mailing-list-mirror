From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: recur status on linux-2.6
Date: Sun, 13 Aug 2006 22:43:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608132221030.10541@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0608131550290.10541@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64gwmv2j.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0608132006510.10541@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vveowl8sm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 13 22:43:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCMoE-0006lh-Sj
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 22:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWHMUno (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 16:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWHMUnn
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 16:43:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:48579 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751417AbWHMUnn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Aug 2006 16:43:43 -0400
Received: (qmail invoked by alias); 13 Aug 2006 20:43:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 13 Aug 2006 22:43:41 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vveowl8sm.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25296>

Hi,

On Sun, 13 Aug 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I fail to see how this is worse than -recursive...
> 
> These are what I got.  ls-files -u output followed by git diff.

I am a little confused here: I thought it would be enough to compare the 
outputs of "git-ls-files --stage". But that seems wrong.

What are the stages for, again?

Ciao,
Dscho
