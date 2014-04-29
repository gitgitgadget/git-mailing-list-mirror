From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Tue, 29 Apr 2014 23:48:45 +0200
Message-ID: <CAA01CsoSR_NzWEbD0J88ref5FM3uHt74OuVh-WesGO09XZF2uA@mail.gmail.com>
References: <535C47BF.2070805@game-point.net>
	<CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
	<535D4085.4040707@game-point.net>
	<CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
	<535D6EB1.9080208@game-point.net>
	<535e18cdc7bce_338911e930c72@nysa.notmuch>
	<87bnvl6bdg.fsf@fencepost.gnu.org>
	<535e8e4253196_45651483310b3@nysa.notmuch>
	<152626b3-0642-4e26-9333-7d911d45c669@email.android.com>
	<535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch>
	<CAHYYfeGBLXGgK-cTQLEreFXJakp1jBE829=LrhmKR3MttBiw+A@mail.gmail.com>
	<535f1d4d8cbbb_762310ef30c9c@nysa.notmuch>
	<220967ee-98a9-4731-88c0-43a9cba7220a@email.android.com>
	<535f62c1e740a_45e485b30887@nysa.notmuch>
	<87r44g33z4.fsf@fencepost.gnu.org>
	<535f702352d21_3aee3b2f0b9@nysa.notmuch>
	<87mwf431t3.fsf@fencepost.gnu.org>
	<535f76db38a34_6f23159b31099@nysa.notmuch>
	<87eh0g30it.fsf@fencepost.gnu.org>
	<535f7c35cb5b1_7c7c10e32f019@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Kastrup <dak@gnu.org>, James Denholm <nod.helm@gmail.com>,
	Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:48:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfFtT-00037E-Ak
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 23:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932885AbaD2Vss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 17:48:48 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:39425 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127AbaD2Vsq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 17:48:46 -0400
Received: by mail-wg0-f41.google.com with SMTP id y10so863583wgg.24
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 14:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OuWCgGnqGDrMwgcF62LQxAqrq+I4wDEY8q38Z/y7tWk=;
        b=tAZu8NtWC87lUY5U6rkxjDnOpnHsqWrNOmh/miyK4HktyTQN93sARglSt2jCTuv2hl
         YC+auD/B3Y6JhfTptSLivbmjWQwRf/oGQLiWgSIYMU+Lbq0jzk0EVEKKZG0sWlLRw4fl
         Bpr+PM831pbJ45GIwN4IcIv1Toi26+QdUKsSaZqNz75JpfS2Hveoph5260oHolKKn+bX
         I3EJGZXQK8XLOvcGzsJE2zUqLTRC6473jmqyaBq/UodUNCFX61QmyWYWFMgvapUCBKOn
         lbg2Zj+QeUHBxWOnMgbVd6YyjAlgnZ3qP/nCh5z8xq4KEy6/gF1yGKe3ijogYUPcEmoN
         qjyg==
X-Received: by 10.180.12.206 with SMTP id a14mr315416wic.48.1398808125390;
 Tue, 29 Apr 2014 14:48:45 -0700 (PDT)
Received: by 10.180.24.133 with HTTP; Tue, 29 Apr 2014 14:48:45 -0700 (PDT)
In-Reply-To: <535f7c35cb5b1_7c7c10e32f019@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247614>

On Tue, Apr 29, 2014 at 12:17 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> That's all you could list for *four* years? None of that would even be noticed
> by most of our users, maybe push.default (when it actually happens), but that's
> *one*.
>
> *One* important change in *four* years.

Hi,

one out of how many? (How many proposed important changes were rejected?)

Thanks,
-- 
Piotr Krukowiecki
