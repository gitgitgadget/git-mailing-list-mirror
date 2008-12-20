From: Mark Burton <markb@ordern.com>
Subject: Re: RFC: Change whatchanged to report changes from merges by
 default?
Date: Sat, 20 Dec 2008 20:21:09 +0000
Organization: Order N Ltd.
Message-ID: <20081220202109.336d0a5e@crow>
References: <20081220104232.5ff1b7c0@crow>
	<7vvdtewqvy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 21:22:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE8LS-00056A-Ff
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 21:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbYLTUVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 15:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753077AbYLTUVY
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 15:21:24 -0500
Received: from c2bthomr09.btconnect.com ([213.123.20.127]:15927 "EHLO
	c2bthomr09.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775AbYLTUVX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 15:21:23 -0500
Received: from crow.ordern.com (host86-128-197-104.range86-128.btcentralplus.com [86.128.197.104])
	by c2bthomr09.btconnect.com
	with ESMTP id CHL00952;
	Sat, 20 Dec 2008 20:21:09 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id 67BDF190CFB;
	Sat, 20 Dec 2008 20:21:09 +0000 (GMT)
In-Reply-To: <7vvdtewqvy.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2bthomr09.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A090206.494D53BD.01C5,ss=1,fgs=0,
	ip=86.128.197.104,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103663>


On Sat, 20 Dec 2008 12:09:05 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> IOW, I consider "whatchanged" a command that is kept only for old timers'
> sake.  There is no reason to promote it, but there is no reason to
> deprecate it, either.  Which means the answer to this question...
> 
> > Would it not make more sense to have git whatchanged show the changes
> > introduced by merges by default and then people can use the (already
> > supported) --no-merges option to suppress that behaviour?  
> 
> ... is a NO spelled in capital letters.

OK (spelled in capital letters), I won't submit the patch.

Cheers,

Mark
