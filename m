From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: Errors pushing tags in "next"
Date: Thu, 22 Mar 2007 20:35:55 -0700 (PDT)
Message-ID: <483641.20752.qm@web31801.mail.mud.yahoo.com>
References: <7vr6rgsmj2.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 04:36:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUaZe-0004uz-EM
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 04:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934288AbXCWDf6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 23:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934290AbXCWDf6
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 23:35:58 -0400
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:29131 "HELO
	web31801.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S934288AbXCWDf6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2007 23:35:58 -0400
Received: (qmail 21361 invoked by uid 60001); 23 Mar 2007 03:35:55 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=efBoOZe+DbaFPDkcyKkFfWR9+YrK5pqxj7bG8CKX07fHs6+etKL8hYXK1eSJ2/mHqJLX7MjRhjNHzVBx2oyIbcsSsL4PUkvzPpB+TIwVVU+J06Lan8j5OojB/ptlNTY2Bv6ZqB5gek7zicCodh8MNikauHSwj3/Skip4FSZIesg=;
X-YMail-OSG: Z0i2mMQVM1mL1SwXg_wnNyMHYwKxHZYdSZMQMp3RK.2nkUvxo4n1LPz_RdhWvUZNvBZsMFWU2MFPwXmPu9fCrRzY9BjI_hFYL9nCxxYSRMGLLup8sUx0oW.6WvmDdmxep3YUjitGEt8JLwWBH9nTAg--
Received: from [64.215.88.90] by web31801.mail.mud.yahoo.com via HTTP; Thu, 22 Mar 2007 20:35:55 PDT
In-Reply-To: <7vr6rgsmj2.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42899>

--- Junio C Hamano <junkio@cox.net> wrote:

> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > Is this of any concern?
> 
> Sorry, I cannot tell without a command line.

Sorry, I didn't include that.  It is:

git-push --tags web

   Luben


> 
> > ### Pushing version 'v2.6.21-rc4' to the masses
> > fatal: ambiguous argument 'v2.6.21-rc3-329..bac6eefe96204d0ad67d144f2511a6fc487aa594': unknown
> > revision or path not in the working tree.
> > Use '--' to separate paths from revisions
> > fatal: ambiguous argument 'v2.6.21-rc3-329..bac6eefe96204d0ad67d144f2511a6fc487aa594': unknown
> > revision or path not in the working tree.
> > Use '--' to separate paths from revisions
> > refs/tags/v2.6.21-rc4: 0000000000000000000000000000000000000000 ->
> > bac6eefe96204d0ad67d144f2511a6fc487aa594
> >
> > Thanks,
> >    Luben
> >
> > P.S.
> > git --version
> > git version 1.5.1.rc1.901.gb7f2
> 
> 
