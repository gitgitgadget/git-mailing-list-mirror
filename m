From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH 0/2] Make it easy to use branch --track on existing
 branch
Date: Sun, 17 Jan 2010 17:29:12 +0200
Message-ID: <20100117152912.GA20465@Knoppix>
References: <1263737212-8101-1-git-send-email-Matthieu.Moy@imag.fr>
 <20100117144031.GA20335@Knoppix>
 <vpqska4n5pr.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jan 17 16:29:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWX4N-00064m-Ha
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 16:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952Ab0AQP3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 10:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743Ab0AQP3d
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 10:29:33 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:37447 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174Ab0AQP3c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 10:29:32 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 435C718D09E;
	Sun, 17 Jan 2010 17:29:31 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A03C8140A22; Sun, 17 Jan 2010 17:29:31 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id C6CC0158A69;
	Sun, 17 Jan 2010 17:29:26 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <vpqska4n5pr.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137302>

On Sun, Jan 17, 2010 at 03:53:04PM +0100, Matthieu Moy wrote:
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:
> 
> > [*] Yes, I know you can edit .git/config, but I would want "official sounding"
> > (read: git remote subcommand) command to edit it (and no, delete & recreate
> > doesn't do the right thing).
> 
> Having a "git remote subcommand" to do the same thing could help too,
> but it could just come in addition to my patch.

Err... That was about changing URL, not about changing tracking branch.

-Ilari
