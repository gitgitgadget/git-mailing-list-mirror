From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: What's cooking in git.git (Nov 2010, #03; Wed, 24)
Date: Fri, 3 Dec 2010 16:03:20 +0100
Message-ID: <201012031603.20669.trast@student.ethz.ch>
References: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org> <201012031406.55854.trast@student.ethz.ch> <201012031512.45793.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 16:03:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POXAX-00025A-I9
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 16:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438Ab0LCPDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 10:03:23 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:39693 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998Ab0LCPDW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 10:03:22 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 3 Dec
 2010 16:03:08 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 3 Dec
 2010 16:03:20 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc3-git6-8-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <201012031512.45793.jnareb@gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162803>

Jakub Narebski wrote:
> Could you try if the following patch applied on top of 17b15d4 fixes
> it for you?  If it does, I'll resend fixed series (yet again, I'm sorry
> Junio).

Yes, that works.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
