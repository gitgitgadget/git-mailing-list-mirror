From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: git access using SSL certificates
Date: Mon, 28 Jun 2010 23:44:25 +0300
Message-ID: <20100628204425.GA13640@LK-Perkele-V2.elisa-laajakaista.fi>
References: <CB7586D8-2C18-4BE9-9B32-3D02AA5F37ED@uab.edu>
 <16FCDB06-9C82-4CBF-BD25-A10BD3E829DE@uab.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Shantanu Pavgi <pavgi@uab.edu>
X-From: git-owner@vger.kernel.org Mon Jun 28 22:43:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTLAn-0007I5-Ib
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 22:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab0F1UnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 16:43:16 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:40774 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115Ab0F1UnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 16:43:16 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 60E7CEC1C0;
	Mon, 28 Jun 2010 23:43:14 +0300 (EEST)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A021FD55FED; Mon, 28 Jun 2010 23:43:14 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 2A23641BE4;
	Mon, 28 Jun 2010 23:43:12 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <16FCDB06-9C82-4CBF-BD25-A10BD3E829DE@uab.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149859>

On Mon, Jun 28, 2010 at 03:23:30PM -0500, Shantanu Pavgi wrote:
> 
> Forgot to mention version info in my earlier email: 
> Server/Public repo: CentOS 5.4 with Git 1.7.1 installed from source 
> Client in earlier mail: Mac OS X 10.6 Git 1.6.5.2 

Too old. 1.6.6 is minimum version requirement for smart HTTP push.
Try upgrading.

> Debian with Git 1.5.6.5:

Too old. That's quite old version... Upgrade.

-Ilari
