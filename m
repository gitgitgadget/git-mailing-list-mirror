From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Symbolic refs and the git protocol?
Date: Sun, 25 Sep 2011 21:50:04 +0300
Message-ID: <20110925185004.GA12781@LK-Perkele-VI.localdomain>
References: <4E7F29EB.8000800@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
X-From: git-owner@vger.kernel.org Sun Sep 25 20:50:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7tmX-00007i-To
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 20:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341Ab1IYSuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Sep 2011 14:50:10 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:35234 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab1IYSuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2011 14:50:09 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id A59F718CE76;
	Sun, 25 Sep 2011 21:50:06 +0300 (EEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A043E17CA6B; Sun, 25 Sep 2011 21:50:06 +0300
Received: from LK-Perkele-VI (a88-112-55-20.elisa-laajakaista.fi [88.112.55.20])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 3CAFEE51A6;
	Sun, 25 Sep 2011 21:50:04 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <4E7F29EB.8000800@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182080>

On Sun, Sep 25, 2011 at 04:17:31PM +0300, Avi Kivity wrote:
>
> Now it looks like kernel.org will no longer offer shell access.  Is
> it possible to support symbolic-ref via 'git push'?

AFAIK, no, it isn't.

-Ilari
