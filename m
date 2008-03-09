From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4.4
Date: Sun, 09 Mar 2008 12:56:40 -0400
Message-ID: <47D416C8.1020903@garzik.org>
References: <7vr6f31iwj.fsf@gitster.siamese.dyndns.org> <7vr6eknpjf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 17:57:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYOqC-0006On-0x
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 17:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710AbYCIQ4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 12:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339AbYCIQ4o
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 12:56:44 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:49881 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659AbYCIQ4o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 12:56:44 -0400
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.66 #1 (Red Hat Linux))
	id 1JYOpF-0006ik-OD; Sun, 09 Mar 2008 16:56:42 +0000
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <7vr6eknpjf.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.4 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76662>

Junio C Hamano wrote:
> The latest maintenance release GIT 1.5.4.4 is available at the
> usual places:
> 
>   http://www.kernel.org/pub/software/scm/git/
> 
>   git-1.5.4.4.tar.{gz,bz2}			(tarball)
>   git-htmldocs-1.5.4.4.tar.{gz,bz2}		(preformatted docs)
>   git-manpages-1.5.4.4.tar.{gz,bz2}		(preformatted docs)
>   RPMS/$arch/git-*-1.5.4.4-1.$arch.rpm	(RPM)

Does it address the following issue, present in git-core-1.5.4.1-1.fc8?

http://marc.info/?l=git&m=120423022832530&w=2

Thanks,

	Jeff
