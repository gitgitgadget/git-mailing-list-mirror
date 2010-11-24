From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: How to do with access control per repo with a smart http git
 server?
Date: Wed, 24 Nov 2010 06:50:25 +0200
Message-ID: <20101124045025.GA12399@LK-Perkele-V2.elisa-laajakaista.fi>
References: <loom.20101124T035911-773@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Chunlin Zhang <zhangchunlin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 05:50:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PL7JC-0006Ug-26
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 05:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975Ab0KXEuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 23:50:11 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:56509 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749Ab0KXEuK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 23:50:10 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 43EE018D2AF;
	Wed, 24 Nov 2010 06:50:09 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A02A0F40B60; Wed, 24 Nov 2010 06:50:09 +0200
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 34659158A62;
	Wed, 24 Nov 2010 06:50:07 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <loom.20101124T035911-773@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162044>

On Wed, Nov 24, 2010 at 03:10:27AM +0000, Chunlin Zhang wrote:
> I setup a smart http git server with apache(
> http://progit.org/2010/03/04/smart-http.html ),and I do the authentication with
> SSPI,but how can I do with access control per repo?
> 
> Does somebody know it?

Easiest way to do it is via Gitolite.

-Ilari
