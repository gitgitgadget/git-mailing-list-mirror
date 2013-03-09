From: Strasser Pablo <strasserpablo@bluewin.ch>
Subject: Re: Segfault in git 1.8.1.5
Date: Sat, 09 Mar 2013 22:31:04 +0100
Message-ID: <5706456.gdNEU5j7WE@pablohp>
References: <2078462.OF4zRmv4ar@pablohp> <7vboase0jw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: gitster@pobox.com, dennis@kaarsemaker.net
X-From: git-owner@vger.kernel.org Sat Mar 09 22:38:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UERTT-0008Sk-Np
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 22:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560Ab3CIViN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 16:38:13 -0500
Received: from zhbdzmsp-smta17.bluewin.ch ([195.186.99.133]:39798 "EHLO
	zhbdzmsp-smta17.bluewin.ch" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751133Ab3CIViN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Mar 2013 16:38:13 -0500
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Mar 2013 16:38:13 EST
Received: from [195.186.227.130] ([195.186.227.130:42428] helo=zhhdzmsp-smta12.bluewin.ch)
	by zhbdzmsp-smta17.bluewin.ch (envelope-from <strasserpablo@bluewin.ch>)
	(ecelerity 2.2.3.47 r(39824M)) with ESMTP
	id D2/C5-20489-91AAB315; Sat, 09 Mar 2013 21:31:06 +0000
Received: from pablohp.localnet (178.193.146.219) by zhhdzmsp-smta12.bluewin.ch (8.5.142) (authenticated as strasserpablo)
        id 510085B003CF9038; Sat, 9 Mar 2013 21:31:05 +0000
User-Agent: KMail/4.10.1 (Linux/3.7.10-1-ARCH; KDE/4.10.1; x86_64; ; )
In-Reply-To: <7vboase0jw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217765>

On Saturday 09 March 2013 13.16:35 Junio C Hamano wrote:
> Strasser Pablo <strasserpablo@bluewin.ch> writes:
> > I segfault with the following command:
> > 
> > git checkout HEAD~1
> > git branch -u origin/master
> 
> A patch to address this in cooking in 'next', and is expected to be
> in 1.8.2.1 or later.

Ok thanks.
