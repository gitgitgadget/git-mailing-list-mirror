From: brizly vaan van Ulciputz <brizly@freenet.de>
Subject: Re: setup gitosis on Fedora 11
Date: Sat, 18 Jul 2009 09:54:55 +0200
Message-ID: <1247903695.2384.88.camel@brizlyMobil>
References: <1247867114.2384.15.camel@brizlyMobil>
	 <ed88cb980907171752j5c61b3dfvd07298ac436abe38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Douglas Campos <douglas@theros.info>
X-From: git-owner@vger.kernel.org Sat Jul 18 09:55:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MS4lD-0003JL-WB
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 09:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbZGRHzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 03:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752867AbZGRHzC
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 03:55:02 -0400
Received: from mout4.freenet.de ([195.4.92.94]:52814 "EHLO mout4.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589AbZGRHzA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 03:55:00 -0400
Received: from [195.4.92.19] (helo=9.mx.freenet.de)
	by mout4.freenet.de with esmtpa (ID brizly@freenet.de) (port 25) (Exim 4.69 #92)
	id 1MS4kz-0005V6-MG; Sat, 18 Jul 2009 09:54:57 +0200
Received: from p4fc98e06.dip0.t-ipconnect.de ([79.201.142.6]:50915 helo=[192.168.23.106])
	by 9.mx.freenet.de with esmtpsa (ID brizly@freenet.de) (TLSv1:AES256-SHA:256) (port 25) (Exim 4.69 #93)
	id 1MS4kz-0007mk-8l; Sat, 18 Jul 2009 09:54:57 +0200
In-Reply-To: <ed88cb980907171752j5c61b3dfvd07298ac436abe38@mail.gmail.com>
X-Mailer: Evolution 2.26.2 (2.26.2-1.fc11) 
X-purgate-ID: 149285::1247903697-000007A7-1A57DDFB/0-0/0-0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123510>


> Have you manually included your key on the ~/.ssh/authorized_keys? It
> will bypass gitosis control!

no, the authorizes_keys-file does not exists on both system in "brizly"s
account.
