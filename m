From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: How to email out commit message automatically?
Date: Wed, 27 Jan 2010 17:36:01 +0100
Message-ID: <vpq7hr3wln2.fsf@bauges.imag.fr>
References: <65d12cb11001270820i7094001odc4d9f27b7f57767@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, shuww2008@gmail.com
To: Weiwei Shu <shuww1980@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:36:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaAsL-0001LB-0K
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 17:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809Ab0A0QgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 11:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754697Ab0A0QgL
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 11:36:11 -0500
Received: from mx1.imag.fr ([129.88.30.5]:35458 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753013Ab0A0QgK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 11:36:10 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o0RGYwci010581
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 27 Jan 2010 17:34:58 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NaAs5-0000ak-GP; Wed, 27 Jan 2010 17:36:01 +0100
In-Reply-To: <65d12cb11001270820i7094001odc4d9f27b7f57767@mail.gmail.com> (Weiwei Shu's message of "Wed\, 27 Jan 2010 11\:20\:46 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 27 Jan 2010 17:34:59 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o0RGYwci010581
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1265214899.58226@l93QjdF+Te7/7oqy/A9yjQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138168>

Weiwei Shu <shuww1980@gmail.com> writes:

> Hi All,
>
> The second time to post here.  Git is great.
>
> I would like to email the commit message to my Gmail box automatically
> whenever I submit a commit.  Can anybody point me a link on how to do
> that?  I've searched it for half day but not successful.  Thanks!

http://git.kernel.org/?p=git/git.git;a=blob;f=contrib/hooks/post-receive-email

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
