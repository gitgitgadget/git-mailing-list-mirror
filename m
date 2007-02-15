From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: User-wide ignore list
Date: Thu, 15 Feb 2007 12:00:48 +0100
Message-ID: <vpqabzfsn1b.fsf@olympe.imag.fr>
References: <vpq4ppnvi1j.fsf@olympe.imag.fr>
	<Pine.LNX.4.63.0702151152320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 15 12:01:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHeMR-0004e9-3C
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 12:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965853AbXBOLBF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 06:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965627AbXBOLBE
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 06:01:04 -0500
Received: from imag.imag.fr ([129.88.30.1]:39931 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965853AbXBOLBD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 06:01:03 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l1FB0m0i022335
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 15 Feb 2007 12:00:48 +0100 (CET)
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HHeM4-0004dz-H1
	for git@vger.kernel.org; Thu, 15 Feb 2007 12:00:48 +0100
Received: from moy by olympe.imag.fr with local (Exim 4.50)
	id 1HHeM4-0004Wd-Ec
	for git@vger.kernel.org; Thu, 15 Feb 2007 12:00:48 +0100
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0702151152320.22628@wbgn013.biozentrum.uni-wuerzburg.de> (Johannes Schindelin's message of "Thu\, 15 Feb 2007 11\:52\:58 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 15 Feb 2007 12:00:48 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39816>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 15 Feb 2007, Matthieu Moy wrote:
>
>> Is there a way to have a per-user ignore list in git?
>
> It's not really per user, but how about doing it with templates?

Correct me if I'm wrong (I didn't really find a documentation for
templates), but I believe this would only apply to newly created
project. Then, it doesn't apply if I clone the project of someone
using another editor for example, nor to my old projects if I add
something to the list of things I want to ignore.

-- 
Matthieu
