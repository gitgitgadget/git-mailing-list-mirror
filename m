From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: git-ftp for /contrib
Date: Fri, 28 May 2010 04:49:49 +0300
Message-ID: <20100528014948.GA23225@LK-Perkele-V2.elisa-laajakaista.fi>
References: <1274987983.17078.35.camel@zoulou.moser.lan>
 <1275000359-sup-1204@ezyang>
 <m3r5kwrgjz.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Edward Z. Yang" <ezyang@MIT.EDU>,
	=?utf-8?B?UmVuw6k=?= Moser <mail@renemoser.net>,
	git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 28 03:51:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHojW-0007lV-OE
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 03:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449Ab0E1Bv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 21:51:29 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:40556 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132Ab0E1Bv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 21:51:28 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 56A8413B889;
	Fri, 28 May 2010 04:51:27 +0300 (EEST)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A0710856B2E; Fri, 28 May 2010 04:51:27 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id C004E27D85;
	Fri, 28 May 2010 04:51:22 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <m3r5kwrgjz.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147910>

On Thu, May 27, 2010 at 05:54:02PM -0700, Jakub Narebski wrote:
> 
> P.S. I wonder how hard would be to add native support for "dumb"
> ftp:// protocol, so that "git fetch ftp://example.com/repo.git"
> _and_ "git push ftp://example.com/repo.git" works.

AFAIK, ftp(s):// fetch already works, but there is no FTP push.

-Ilari
