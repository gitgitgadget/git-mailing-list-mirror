From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Management of opendocument (openoffice.org) files in git
Date: Tue, 16 Sep 2008 08:45:00 +0200
Message-ID: <vpqwshctwr7.fsf@bauges.imag.fr>
References: <loom.20080915T222909-709@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 09:03:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfUZn-0001KU-RU
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 09:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbYIPHBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 03:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbYIPHBK
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 03:01:10 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:44238 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737AbYIPHBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 03:01:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m8G6x1jo029208;
	Tue, 16 Sep 2008 08:59:02 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KfUJ2-0007KG-ML; Tue, 16 Sep 2008 08:45:00 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KfUJ2-0002lT-KB; Tue, 16 Sep 2008 08:45:00 +0200
In-Reply-To: <loom.20080915T222909-709@post.gmane.org> (Sergio Callegari's
	message of "Mon, 15 Sep 2008 22:40:01 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 16 Sep 2008 08:59:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95980>

Sergio Callegari <sergio.callegari@gmail.com> writes:

> Hi,
>
> Management of opendocument files in git has been discussed a short time ago.
> Here is an helper script that may help achieving better density in git packs
> containg blobs from openoffice files.

If you don't get "oh, sh*t, I lost data with it"-kind of feedback, can
you add it to the wiki:

http://git.or.cz/gitwiki/GitTips#head-1cdd4ab777e74f12d1ffa7f0a793e46dd06e5945

Thanks,

-- 
Matthieu
