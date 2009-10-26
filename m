From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: git rebase -i <first_commit_in_repository>
Date: Mon, 26 Oct 2009 18:25:39 +0100
Message-ID: <40aa078e0910261025l1ad7bf8ex27fd62072a317f9d@mail.gmail.com>
References: <2b05065b0910261014t4eb93952oc804bcd01b339a84@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: eschvoca <eschvoca@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 18:32:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2TQO-00077a-Ap
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 18:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbZJZRb5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Oct 2009 13:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbZJZRb5
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 13:31:57 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:35025 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbZJZRb5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2009 13:31:57 -0400
Received: by fxm18 with SMTP id 18so12276634fxm.37
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jigK80g5f66zl49eRVMkGWF8hMmV1GJ5Uu8uQJ/iYKk=;
        b=daRvX4yKObb7herTB5i7WBa+Ni2BK+Zx3lGsECk39yVOi6FAe6TjGpQuTL2+QnHKBq
         /zEh4bNm8ywuqrFDABHoAMB1rb4XrskWCjoRMjhuV91VhSL04G+Qk/4Uf2gNbvxSlcw6
         mUGYN9VTFEHjZyX8gYnA6Qo1SQsQKbTGvH6B0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=FUC/W8BzdzSgn5sJEhvjVIWoYMAd5WiEJMZSkcDi2iSEjisP3qaMM5vTgQWyNEy9wR
         iZpaq8ZIMOvl1oxf3B90arrrD7bx4t5/ojqntJ1GGHfbHX+8gtmitmAuVIXESx2CAT1x
         KxEoXp6ysXhRozYxAfxd38mQd5Rvs9KOROC/k=
Received: by 10.204.154.216 with SMTP id p24mr6289212bkw.16.1256577939729; 
	Mon, 26 Oct 2009 10:25:39 -0700 (PDT)
In-Reply-To: <2b05065b0910261014t4eb93952oc804bcd01b339a84@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131257>

On Mon, Oct 26, 2009 at 6:14 PM, eschvoca <eschvoca@gmail.com> wrote:
> Hi,
>
> Is there a way to rewrite history, including the first commit. =A0It
> seems that the first commit can not be modified with a rebase.

This question is answered in the FAQ:
http://git.or.cz/gitwiki/GitFaq#HowdoIedittherootcommit.3F

--=20
Erik "kusma" Faye-Lund
