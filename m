From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-shell and git-cvsserver
Date: Tue, 9 Oct 2007 12:51:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710091245310.4174@racer.site>
References: <200710051453.47622.wielemak@science.uva.nl>
 <Pine.LNX.4.64.0710080534270.4174@racer.site> <200710081622.33222.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jan Wielemaker <wielemak@science.uva.nl>
X-From: git-owner@vger.kernel.org Tue Oct 09 13:51:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfDcm-00012p-4x
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 13:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbXJILvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 07:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752439AbXJILvf
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 07:51:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:45566 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751873AbXJILve (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 07:51:34 -0400
Received: (qmail invoked by alias); 09 Oct 2007 11:51:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 09 Oct 2007 13:51:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+O8ZZuqKuOJY5bJvCJGvY+S1P2YD6rGLrrdJoQr3
	OzlFKaKY6J3p54
X-X-Sender: gene099@racer.site
In-Reply-To: <200710081622.33222.wielemak@science.uva.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60388>

Hi,

On Mon, 8 Oct 2007, Jan Wielemaker wrote:

> On Monday 08 October 2007 06:51, Johannes Schindelin wrote:
> 
> > > +#define EXEC_PATH "/usr/local/bin"
> >
> > This is definitely wrong.  Use git_exec_path() instead.
> 
> I stated in my comments I was not happy about that.

That's why I suggested a fix.

> [explaining -- using a lot of words -- no intention to fix the patch]

Heh.  I think that you could have fixed the patch in less time than it 
took you to write your answer ;-)

Ciao,
Dscho
