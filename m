From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT v1.5.1-rc1
Date: Tue, 20 Mar 2007 02:19:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703200217480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070306063501.GA24355@spearce.org> <7v1wk2ua55.fsf@assigned-by-dhcp.cox.net>
 <20070306071630.GB24004@spearce.org> <7vtzwyprr7.fsf_-_@assigned-by-dhcp.cox.net>
 <7v8xdth5c4.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703191459440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd534d8tq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 20 02:19:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTT0k-0005RY-Hw
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 02:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965582AbXCTBT0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 21:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965706AbXCTBT0
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 21:19:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:48268 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965582AbXCTBT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 21:19:26 -0400
Received: (qmail invoked by alias); 20 Mar 2007 01:19:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 20 Mar 2007 02:19:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+8blwPK1S8OupHNmHJRPddxvfpQlqj8VQHhmzeV0
	68un/uLc91w68C
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vd534d8tq.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42689>

Hi,

On Mon, 19 Mar 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 19 Mar 2007, Junio C Hamano wrote:
> >
> >>   - "git diff --pretty=format:<string>" to allow more flexible
> >>     custom log output.
> >
> > You mean "git log" there, not "git diff", correct?
> 
> Of course you are right.  Any other typos?

Not that I know of any...

> I could not parse the --reverse description so I rewrote it

> +  - "git log" and friends take --reverse, which instructs them
> +    to give their output in the order opposite from their usual.

s/usual/& order/ ?

Ciao,
Dscho
