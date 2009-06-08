From: "Ferry Huberts" <ferry.huberts@pelagic.nl>
Subject: Re: Git for Windows 1.6.3.2
Date: Mon, 8 Jun 2009 13:05:43 +0200 (CEST)
Message-ID: <34357.77.61.241.211.1244459143.squirrel@hupie.xs4all.nl>
References: <alpine.DEB.1.00.0906071629460.26154@pacific.mpi-cbg.de>
    <26984.77.61.241.211.1244457815.squirrel@hupie.xs4all.nl>
    <fabb9a1e0906080351hbfe7ab7w2016a030ef1bde7@mail.gmail.com>
    <alpine.DEB.1.00.0906081255530.4461@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Sverre Rabbelier" <srabbelier@gmail.com>,
	"Ferry Huberts" <ferry.huberts@pelagic.nl>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 08 13:05:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDcfo-0006sv-4l
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 13:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217AbZFHLFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 07:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754135AbZFHLFm
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 07:05:42 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:47821 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753872AbZFHLFl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2009 07:05:41 -0400
Received: by Lighthouse.internal.Hupie.com (Postfix, from userid 48)
	id AA82858BDD4; Mon,  8 Jun 2009 13:05:43 +0200 (CEST)
Received: from 77.61.241.211
        (SquirrelMail authenticated user ferry.huberts@pelagic.nl)
        by hupie.xs4all.nl with HTTP;
        Mon, 8 Jun 2009 13:05:43 +0200 (CEST)
In-Reply-To: <alpine.DEB.1.00.0906081255530.4461@intel-tinevez-2-302>
User-Agent: SquirrelMail/1.4.8-5.el5.centos.3
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121062>

> The original fix was indeed done for a reason.
>
> My best guess (as I said in another email on the msysgit list today, where
> Ferry probably did not expect helpful information): msys-1.0.dll was not
> properly updated.

sorry for that, I am subscribed to git.devel only. probably should
have checked the msysgit list

>
> I worked on a check for this some time ago, but I forgot to finish and
> include it in our official 'devel'.

does this mean that we can expect a '-2' msysgit release soon?
