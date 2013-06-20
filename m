From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 0/5] git-remote-mediawiki: new tool to preview local changes without pushing
Date: Thu, 20 Jun 2013 10:55:09 +0200
Message-ID: <vpqa9mlduvm.fsf@anie.imag.fr>
References: <1371712593-6210-1-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Thu Jun 20 10:55:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upaeg-0000Zv-GX
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 10:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989Ab3FTIzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 04:55:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59863 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754811Ab3FTIzL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 04:55:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5K8t8Bj007154
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 20 Jun 2013 10:55:08 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Upae5-0006QJ-Gg; Thu, 20 Jun 2013 10:55:09 +0200
In-Reply-To: <1371712593-6210-1-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Thu, 20 Jun 2013 09:16:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 20 Jun 2013 10:55:08 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228466>

benoit.person@ensimag.fr writes:

> From: Benoit Person <benoit.person@ensimag.fr>
>
> The #7 issue on git-mediawiki's issue tracker [1] states that the ability to
> preview content without pushing would be a nice thing to have.

I make minor remarks, but on overall, the code looks good.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
