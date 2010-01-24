From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 3/3] rebase -i: Export GIT_AUTHOR_* variables explicitly
Date: Sun, 24 Jan 2010 06:33:26 +0100
Message-ID: <4B5BDBA6.9090307@alum.mit.edu>
References: <cover.1264151435.git.mhagger@alum.mit.edu> <c6efda03848abc00cf8bf8d84fc34ef0d652b64c.1264151435.git.mhagger@alum.mit.edu> <alpine.DEB.1.00.1001221212350.4985@pacific.mpi-cbg.de> <7viqatu9rv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, tarmigan+git@gmail.com, j.sixt@viscovery.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 06:34:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYv70-0002RQ-1w
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 06:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab0AXFdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 00:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656Ab0AXFdg
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 00:33:36 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:37244 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab0AXFdf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 00:33:35 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.128] (p4FC1EA78.dip.t-dialin.net [79.193.234.120])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0O5XTBn017868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 24 Jan 2010 06:33:31 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
In-Reply-To: <7viqatu9rv.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137883>

Junio C Hamano wrote:
> [...]
> So I tend to think this patch would be the cleanest and safest
> alternative, albeit it may cost an extra fork.
> 
> What do you think?
> 
> -- >8 --
> Subject: rebase -i: Export GIT_AUTHOR_* variables explicitly

Your version is fine with me.

Michael
