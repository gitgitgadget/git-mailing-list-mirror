From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v6 4/7] git-clean: use a git-add-interactive compatible UI
Date: Wed, 8 May 2013 08:28:37 +0800
Message-ID: <CANYiYbFgWiLjF1kPKe_o=qH6YB91O_SA2=sT0RgQ9jctXqkdJw@mail.gmail.com>
References: <4a32eb7cc4e277fcbf4b46c13524874334bea2a3.1367867498.git.worldhello.net@gmail.com>
	<6276dc8861b40e8377586f30b85c33e92c4e68fe.1367867498.git.worldhello.net@gmail.com>
	<CANYiYbG5q7g-Gn-EGtsgS4XYLbQJuY6Pr_6FgKknADTD5_KoTg@mail.gmail.com>
	<cover.1367867498.git.worldhello.net@gmail.com>
	<c77c33fe295bb8577336d5bb4fe0d8da32f69df3.1367867498.git.worldhello.net@gmail.com>
	<217e7618e9b9d50a50461959b38984ac8be88651.1367867498.git.worldhello.net@gmail.com>
	<CANYiYbEE90zvhoRp3utOzRWXnpVGTcaruWDuCCHE77FmGwB2_w@mail.gmail.com>
	<7vmws6lsto.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 08 02:28:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZsFP-0003wh-Mj
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 02:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756645Ab3EHA2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 20:28:39 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:37400 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756577Ab3EHA2i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 20:28:38 -0400
Received: by mail-we0-f171.google.com with SMTP id u55so1215238wes.16
        for <git@vger.kernel.org>; Tue, 07 May 2013 17:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=PC77HHiXsgxxxpTPXtiJkYAeIGGDyDh1VwIas8NBPYs=;
        b=LfQtubT4XLn2nA/5UTSgfS27aKpNXD/B04Hr+Fn9f+j97DaGydgvOKT2TnFJbvUYkK
         j95adQAYogDM5Y2qOV4rD/DCYQVGWov6FE82J6BdHsWP7hgtSMxVNa/ovap7KghrVr69
         6KE9AbnM9XDirnFAD5VzJJp7XYMYH2x73eYE44Tb0WLLaUcnQtm5FMClJ5cXBu4jrH1i
         fd9IfKev9cJ12/Gmp3yIwF/KV2Kj2Shecmrgn6BxKFgZsM1xl/erzyMarTcOZT4ixUVN
         cuWjudsl7+eaaJM3JrAda1rG9juNCvN6UNx3+YPkRdsXkUzY4p3VFsaiE+CyR2CV/pd8
         jjkw==
X-Received: by 10.180.90.164 with SMTP id bx4mr2284254wib.13.1367972917324;
 Tue, 07 May 2013 17:28:37 -0700 (PDT)
Received: by 10.194.175.72 with HTTP; Tue, 7 May 2013 17:28:37 -0700 (PDT)
In-Reply-To: <7vmws6lsto.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223633>

2013/5/7 Junio C Hamano <gitster@pobox.com>:
> What is this message trying to achieve?  "self review"???
>
> A bit puzzled....

Maybe I should send a new rerolled patch series after this. Yesterday I
wanted to wait for a while to see suggestions and reviews from others.

-- 
Jiang Xin
