From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: What do you use to receive mailed patches? (was: What do you use to send git patches?)
Date: Fri, 5 Sep 2008 16:33:36 +0200
Message-ID: <8516DF42-5E6B-4C36-BA2C-3D0B17554A1D@ai.rug.nl>
References: <e29894ca0809050715p6cc11525k7da204b43ae164ee@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Felipe Contreras" <felipe.contreras@gmail.com>,
	git@vger.kernel.org, "Tor Arvid Lund" <torarvid@gmail.com>,
	"Christian Jaeger" <christian@jaeger.mine.nu>
To: =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 16:36:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbcOi-0005zx-Iu
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 16:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbYIEOdq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Sep 2008 10:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753298AbYIEOdq
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 10:33:46 -0400
Received: from frim.nl ([87.230.85.232]:58319 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753266AbYIEOdp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 5 Sep 2008 10:33:45 -0400
Received: from s5591931c.adsl.wanadoo.nl ([85.145.147.28] helo=[192.168.1.11])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1KbcNa-0004BH-W3; Fri, 05 Sep 2008 16:33:43 +0200
In-Reply-To: <e29894ca0809050715p6cc11525k7da204b43ae164ee@mail.gmail.com>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95018>


On 5 sep 2008, at 16:15, Marc-Andr=E9 Lureau wrote:

> My question was about handling the patches you receive. Sending
> configuration is quite easy.

I use a little script that pipes the patches I have selected in Mail
through git-am, so it's just selecting the patches in my mail
client and then 'git apply-patches' in the repo I want them in.

- Pieter