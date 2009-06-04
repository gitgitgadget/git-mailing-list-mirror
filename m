From: Shakthi Kannan <shakthimaan@gmail.com>
Subject: di-git-ally managing love letters - a Git presentation
Date: Thu, 4 Jun 2009 17:11:37 +0530
Message-ID: <d16b1c80906040441n7ad549eay83a6ccfd5db09fb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 04 13:41:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCBKM-0007hA-K9
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 13:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705AbZFDLlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 07:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754563AbZFDLlg
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 07:41:36 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:49722 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754485AbZFDLlf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 07:41:35 -0400
Received: by gxk10 with SMTP id 10so1260127gxk.13
        for <git@vger.kernel.org>; Thu, 04 Jun 2009 04:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=EApGr3WkUT/NnOBxoHKgJvOJMTplIblFZ2b+88LhNxo=;
        b=mAQMi8Wb0at/lG7LqESA0d1Ek8Fn/Ub/sXHTMixYRwG8hmlra+4xC/cvUINnwKAQ0L
         T0jnIVLm9yunuPfTQLC9lDKiw3/pzDEVLYRAezTZu7Q/RU8Tl5wP03w4LK4BnV8OtxIS
         6GTaXEepcpM7zCO94HZ3dvXoiHUBciLMmA9RY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=fMKyjqQ50vSRrlmQ+RmKS1ZYEY2yaq6GPLxa8dcBkel95MP+j1aR4OqdrFbZ9whDH+
         ffjhKaVLpwpznLG+lqZD2Kq5nrjamZCEHzglfwCaj8YTkdbITs61scAj4LcZedWbjLg8
         2DxJBMCXVWgj97rcxHr1ojog+IkfKGdtYpS34=
Received: by 10.90.105.17 with SMTP id d17mr1787642agc.92.1244115697318; Thu, 
	04 Jun 2009 04:41:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120691>

Hi,

I have tried to make a basic presentation on Git, that covers some
basic commands. Please find it here:
http://shakthimaan.com/downloads/glv/presentations/di-git-ally-managing-love-letters.pdf

The LaTeX beamer sources are available at:
http://shakthimaan.com/downloads/glv/presentations/di-git-ally-managing-love-letters.tar.bz2

I start with git init, add, commit; show how to use rm with -f and
--cached options; then go on to show reset HEAD (alternative to using
--cached?); proceed further to show reset --soft and --hard options.
Finally, branching, merging, rebase and clone. It is not meant to be a
comprehensive list of git commands, but, some essential ones to get
people started with (I hope).

I would appreciate feedback, suggestions on the same. If you feel the
commands are to be used differently, or in a different workflow
perhaps, or if you find something that needs to be added, removed or
fixed, please let me know.

Kindly ignore the nouns used.

Thanks!

SK

-- 
Shakthi Kannan
http://www.shakthimaan.com
