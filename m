From: Andrew Eikum <aeikum@codeweavers.com>
Subject: Re: What's cooking in git.git (Feb 2014, #04; Wed, 12)
Date: Fri, 14 Feb 2014 13:44:36 -0600
Message-ID: <20140214194436.GB743@foghorn.codeweavers.com>
References: <xmqqd2ism1pu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 21:02:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEOxf-00045j-Q9
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 21:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbaBNUCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 15:02:01 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:59966 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbaBNUCA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 15:02:00 -0500
X-Greylist: delayed 1042 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Feb 2014 15:02:00 EST
Received: from foghorn.codeweavers.com ([216.251.189.130])
	by mail.codeweavers.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <aeikum@codeweavers.com>)
	id 1WEOgf-0006Z4-KP; Fri, 14 Feb 2014 13:44:37 -0600
Content-Disposition: inline
In-Reply-To: <xmqqd2ism1pu.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242139>

On Wed, Feb 12, 2014 at 01:59:41PM -0800, Junio C Hamano wrote:
> As a workaround to make life easier for third-party tools, the
> upcoming major release will be called "Git 1.9.0" (not "Git 1.9").
> The first maintenance release for it will be "Git 1.9.1", and the
> major release after "Git 1.9.0" will either be "Git 2.0.0" or "Git
> 1.10.0".
> 

Apologies if this ground has been tread before, but has there been a
version numbering discussion? A quick google didn't seem to turn
anything up.

This seems to be an opportune time to drop the useless first digit.
Explicitly, the major release numbers would be: 1.8, 1.9, then 2.0,
3.0, 4.0, etc, with the 2nd digit would take the meaning of the
current 3rd digit and so on.

Andrew
