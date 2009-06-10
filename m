From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: EasyGit Integration
Date: Wed, 10 Jun 2009 14:52:38 +0200
Message-ID: <vpqljo045ex.fsf@bauges.imag.fr>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	<51419b2c0906091500q6aaff225q42bd79e6349a1143@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 14:56:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MENLl-0001iU-QM
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 14:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757325AbZFJMzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 08:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755373AbZFJMzg
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 08:55:36 -0400
Received: from imag.imag.fr ([129.88.30.1]:39670 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755323AbZFJMzg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 08:55:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n5ACqdbw023649
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 10 Jun 2009 14:52:39 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MENIE-00070I-KI; Wed, 10 Jun 2009 14:52:38 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MENIE-00044Y-Iu; Wed, 10 Jun 2009 14:52:38 +0200
In-Reply-To: <51419b2c0906091500q6aaff225q42bd79e6349a1143@mail.gmail.com> (Elijah Newren's message of "Tue\, 9 Jun 2009 16\:00\:14 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 10 Jun 2009 14:52:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121274>

Elijah Newren <newren@gmail.com> writes:

>> Some other things that might be nice:
>>
>> * 'git backout' for 'git reset HEAD^'
>
> May cause confusion for mercurial users (hg backout == current git
> revert).

Yes, and a bit of consistency between the various (D)VCS would be good
(for regular-hg-users which are also occasional-git-users and so).

> I don't have a better proposal, though. 'uncommit'?

I like 'uncommit'. That's what bzr uses.

-- 
Matthieu
