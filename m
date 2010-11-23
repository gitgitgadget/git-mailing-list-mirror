From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Absolute Beginner
Date: Tue, 23 Nov 2010 17:54:36 +0200
Message-ID: <20101123155436.GA10420@LK-Perkele-V2.elisa-laajakaista.fi>
References: <1290516065002-5766449.post@n2.nabble.com>
 <AANLkTindQRaUMXiQ_2Fa-guKtZz5oV89Gw7W0dapO9MT@mail.gmail.com>
 <1290525868767-5766781.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: marcos <marcos@arena.com.br>
X-From: git-owner@vger.kernel.org Tue Nov 23 16:54:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKvCR-0001gN-MZ
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 16:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755592Ab0KWPy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 10:54:27 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:46779 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491Ab0KWPy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 10:54:26 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id E987F8C27B;
	Tue, 23 Nov 2010 17:54:24 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A00A60E6B56; Tue, 23 Nov 2010 17:54:24 +0200
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id B168DE51A4;
	Tue, 23 Nov 2010 17:54:22 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <1290525868767-5766781.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161976>

On Tue, Nov 23, 2010 at 07:24:28AM -0800, marcos wrote:
> 
> Then I received a reply from Howard Miller:
> 
> (...)
> You are trying to push to a repo that isn't bare. Not impossible but
> problematic and you can't do it at all by default (as you have found).
> 
> Personally I would look at a central shared repo. You could just get an
> account on (something like) GitHub or setup your own (something like
> Gitosis).
> (...)

Don't use Gitosis, it is obsolete. Use Gitolite instead.

-Ilari
