From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: How to do with access control per repo with a smart http git
 server?
Date: Wed, 24 Nov 2010 08:08:13 +0200
Message-ID: <20101124060813.GA12949@LK-Perkele-V2.elisa-laajakaista.fi>
References: <loom.20101124T035911-773@post.gmane.org>
 <20101124045025.GA12399@LK-Perkele-V2.elisa-laajakaista.fi>
 <loom.20101124T060650-817@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Chunlin Zhang <zhangchunlin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 07:08:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PL8WV-0006co-O8
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 07:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451Ab0KXGIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 01:08:00 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:50882 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab0KXGH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 01:07:59 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id CFA398C5B3;
	Wed, 24 Nov 2010 08:07:57 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A05403CB996; Wed, 24 Nov 2010 08:07:57 +0200
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id C38D641BE6;
	Wed, 24 Nov 2010 08:07:55 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <loom.20101124T060650-817@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162048>

On Wed, Nov 24, 2010 at 05:07:46AM +0000, Chunlin Zhang wrote:
> Ilari Liusvaara <ilari.liusvaara <at> elisanet.fi> writes:
> 
> > Easiest way to do it is via Gitolite.
> 
> I notice that:"gitolite depends heavily on ssh pubkey (passwordless) access" (
> https://github.com/sitaramc/gitolite/blob/pu/doc/1-INSTALL.mkd )
 
See http://github.com/sitaramc/gitolite/blob/pu/doc/http-backend.mkd

-Ilari
