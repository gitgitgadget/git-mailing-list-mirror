From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [gambit-list] Separating generated files? (Re: Mercurial -> git)
Date: Wed, 15 Oct 2008 17:30:11 +0200
Message-ID: <vpqiqrt3mgs.fsf@bauges.imag.fr>
References: <E6D34628-783D-4597-8B00-C10F27F63BE2@iro.umontreal.ca>
	<48F5D86B.6040501@pflanze.mine.nu>
	<fcaeb9bf0810150754s613f2c44pd8341711d9d73f73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Christian Jaeger" <christian@pflanze.mine.nu>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Marc Feeley" <feeley@iro.umontreal.ca>,
	"Gambit List" <Gambit-list@iro.umontreal.ca>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 17:47:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq8am-0000KQ-5p
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 17:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbYJOPqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 11:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbYJOPqF
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 11:46:05 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:35860 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbYJOPqE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 11:46:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m9FFgWYF003318;
	Wed, 15 Oct 2008 17:42:34 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Kq8KB-0004CO-95; Wed, 15 Oct 2008 17:30:11 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Kq8KB-0001dB-6d; Wed, 15 Oct 2008 17:30:11 +0200
In-Reply-To: <fcaeb9bf0810150754s613f2c44pd8341711d9d73f73@mail.gmail.com> (Nguyen Thai Ngoc Duy's message of "Wed\, 15 Oct 2008 21\:54\:26 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Wed, 15 Oct 2008 17:42:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98283>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> Hi Christian,
>
> The idea of using two separate repositories for source and generated
> source is interesting. I would like to bring this to git mailing list,
> they may provide insightul comments for your idea or even other
> approaches.

I think the first question is: do you (and why) need to use a version
control system for generated files?

-- 
Matthieu
