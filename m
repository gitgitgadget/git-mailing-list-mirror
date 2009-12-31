From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [Updated PATCH 1/2] Report exec errors from run-command
Date: Thu, 31 Dec 2009 12:48:36 +0200
Message-ID: <20091231104835.GA18848@Knoppix>
References: <1262170338-11574-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1262170338-11574-2-git-send-email-ilari.liusvaara@elisanet.fi>
 <905315640912302126n1848c99cre0f9caa644041fad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 11:48:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQIaB-00056s-W2
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 11:48:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbZLaKsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 05:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752317AbZLaKsk
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 05:48:40 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:53985 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbZLaKsj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 05:48:39 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 30F12EB673;
	Thu, 31 Dec 2009 12:48:38 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A05CAA314D6; Thu, 31 Dec 2009 12:48:38 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 20E7A158A64;
	Thu, 31 Dec 2009 12:48:36 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <905315640912302126n1848c99cre0f9caa644041fad@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135944>

On Thu, Dec 31, 2009 at 12:26:48AM -0500, Tarmigan wrote:
> On Wed, Dec 30, 2009 at 5:52 AM, Ilari Liusvaara
> <ilari.liusvaara@elisanet.fi> wrote:
> 
> I was testing pu and 'git diff' and 'git log' would hang forever.
 
V3 just sent to list. Should fix this issue.

-Ilari
