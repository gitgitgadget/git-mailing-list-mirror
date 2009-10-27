From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitk: Use the --submodule option for diffs
Date: Tue, 27 Oct 2009 16:41:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0910271640540.11562@felix-maschine>
References: <4AE70AC9.6040302@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Oct 27 16:41:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2oB5-0003yj-A8
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 16:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755548AbZJ0Pld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 11:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755543AbZJ0Plc
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 11:41:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:57799 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754391AbZJ0Plc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 11:41:32 -0400
Received: (qmail invoked by alias); 27 Oct 2009 15:41:36 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO [10.1.35.45]) [141.5.11.5]
  by mail.gmx.net (mp055) with SMTP; 27 Oct 2009 16:41:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+H1RlNTwiHaXzFN6aBxbs+SKG1wlh6+NLeVpA1hC
	C5xG0JnNY9QuHZ
X-X-Sender: johannes@felix-maschine
In-Reply-To: <4AE70AC9.6040302@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131349>

Hi,

On Tue, 27 Oct 2009, Jens Lehmann wrote:

> Instead of just showing not-quite-helpful SHA-1 pairs display the first
> lines of the corresponding commit messages in the submodule (similar to
> the output of 'git submodule summary').
> 
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
> 
> This patch applies to 'next' and uses the new --submodule option of git
> diff to achieve a more meaningful output of submodule differences in
> gitk.
> 
> Any objections against making this the default?

Certainly not from me.  It would help people in my day-job project.

Ciao,
Dscho
