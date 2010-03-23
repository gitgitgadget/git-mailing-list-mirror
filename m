From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Feature Request: raw body in format strings
Date: Tue, 23 Mar 2010 10:54:07 +0200
Message-ID: <20100323085407.GA29220@LK-Perkele-V2.elisa-laajakaista.fi>
References: <m3wrx3ogwj.fsf@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Tue Mar 23 09:55:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtztB-0004z0-T9
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 09:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791Ab0CWIyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 04:54:51 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:55274 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374Ab0CWIyt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 04:54:49 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id C24B0C8520;
	Tue, 23 Mar 2010 10:54:47 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A05C69BF10E; Tue, 23 Mar 2010 10:54:47 +0200
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id F1E8CE51A5;
	Tue, 23 Mar 2010 10:54:44 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <m3wrx3ogwj.fsf@winooski.ccs.neu.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142999>

On Mon, Mar 22, 2010 at 11:28:44PM -0400, Eli Barzilay wrote:
> 
> Looking at the code I see that there is no way to get that, but it's
> really easy to add it.  Does it make sense to do so?

I think it makes sense.

> I have a change
> that adds a "%B" that does just that, and it seems that it works fine.
> (But I don't know what's the procedure for sending patches.)

See Documentation/SubmittingPatches in git source code.

-Ilari
