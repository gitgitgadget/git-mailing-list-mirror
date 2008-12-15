From: Nix <nix@esperi.org.uk>
Subject: Re: is gitosis secure?
Date: Mon, 15 Dec 2008 00:14:35 +0000
Message-ID: <87prju5m6s.fsf@hades.wkstn.nix>
References: <200812090956.48613.thomas@koch.ro>
	<bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com>
	<87hc58hwmi.fsf@hades.wkstn.nix> <gi1qsl$22p$1@ger.gmane.org>
	<m3zlizdofy.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org,
	Thomas Koch <thomas@koch.ro>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 01:16:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC183-0003CJ-EN
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 01:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbYLOAOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 19:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbYLOAOu
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 19:14:50 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:35847 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbYLOAOt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 19:14:49 -0500
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id mBF0Eamn001941;
	Mon, 15 Dec 2008 00:14:36 GMT
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id mBF0EaEc018247;
	Mon, 15 Dec 2008 00:14:36 GMT
Emacs: more boundary conditions than the Middle East.
In-Reply-To: <m3zlizdofy.fsf@localhost.localdomain> (Jakub Narebski's message of "Sun, 14 Dec 2008 02:47:31 -0800 (PST)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.5-b28 (linux)
X-DCC-sonic.net-Metrics: hades 1117; Body=4 Fuz1=4 Fuz2=4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103113>

On 14 Dec 2008, Jakub Narebski spake thusly:
> BTW. is outgoing SSH transport (from network to outside) blocked as
> well?

*No* ports are open. All they have is a (non-transparent) buggy HTTP
proxy. These guys really don't get the Internet, despite their sales
literature banging on endlessly about it.

Looks like a lot of git-bundling is in my future.
