From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH v2] rev-parse --namespace
Date: Wed, 20 Jan 2010 00:12:59 +0200
Message-ID: <20100119221258.GA25210@Knoppix>
References: <1263798952-27624-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <7v3a21amh7.fsf@alter.siamese.dyndns.org>
 <20100119214400.GA24911@Knoppix>
 <201001192246.53453.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 19 23:13:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXMK7-000204-9d
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 23:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755052Ab0ASWNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 17:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754966Ab0ASWNK
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 17:13:10 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:38204 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842Ab0ASWNH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 17:13:07 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 7F3FBEF2FF;
	Wed, 20 Jan 2010 00:13:03 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A0702573138; Wed, 20 Jan 2010 00:13:03 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 6F60C41BE2;
	Wed, 20 Jan 2010 00:12:59 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <201001192246.53453.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137498>

On Tue, Jan 19, 2010 at 10:46:51PM +0100, Thomas Rast wrote:
> Ilari Liusvaara wrote:
> > 
> > Eh, remind me what commands take refs and shell-glob them? The only
> > 'globbing' of refs I'm aware of is in refspecs, and that definitely isn't
> > shell globbing...
> 
> fetchspecs?

Ah, found one: 'ls-remote'. Documentation of that doesn't say what format
patterns are in... 

Any others? 

-Ilari
