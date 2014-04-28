From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 12:10:39 -0500
Message-ID: <535e8b8fb1ab2_4565148331059@nysa.notmuch>
References: <535C47BF.2070805@game-point.net>
 <CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
 <535D4085.4040707@game-point.net>
 <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
 <535D6EB1.9080208@game-point.net>
 <535e18cdc7bce_338911e930c72@nysa.notmuch>
 <535E1CAD.1020304@game-point.net>
 <535e1ca4933da_338911e930c4@nysa.notmuch>
 <535E20DC.2040405@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Jeremy Morton <admin@game-point.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:10:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeqwE-00063r-DB
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbaD1TJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:09:16 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:46411 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbaD1TIz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:08:55 -0400
Received: by mail-oa0-f49.google.com with SMTP id o6so7758104oag.36
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 12:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=qdHZy8+NSu+1NdgyYNp4NZ8bVuWTZ9lp2YDfiXpL4mY=;
        b=ccAt4DVuYCFQnp4JxnVJUqfyHOtmGZ4h4n/5pxWTGP2UcqfGvr+HzSE+bNeuOnAHdF
         9MkjSrk4kdEi8eG0cRZWNi36hG1R+/t/OPx04AioaJXBeXoNlGGWR0z8hAB1j43bA1HR
         ERLqFsCILPAaqnVPgAZUoSXssmuoZBpbOeOwf60DD8BiWV5EvRwf41T7WttNvu8N0GvC
         nIapNO6Dui5XQ56u56t2HIE6mOy80KiajkjMk3DtAqfeDbCLG00siqSqX5g92Eplo7wp
         ZxtS8xaQKwu6+8YXvqsCnBI1Zjq0pDKR3GkI1LSAGQuE6UNAyf7q+p3hVnHT2nQ6LrUP
         7tIQ==
X-Received: by 10.60.159.36 with SMTP id wz4mr23673136oeb.30.1398705672714;
        Mon, 28 Apr 2014 10:21:12 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ko3sm75956175oeb.1.2014.04.28.10.21.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Apr 2014 10:21:11 -0700 (PDT)
In-Reply-To: <535E20DC.2040405@game-point.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247386>

Jeremy Morton wrote:
> On 28/04/2014 10:17, Felipe Contreras wrote:
> >
> > I don't seem to what? I'm the one arguing for change, and I sent the
> > patches to fix this default behavior.
> 
> Well maybe you should work on phrasing things better - you come across as
> quite negative.

What is the difference between a negative person and a realist, when what both
say are the same and true?

It's literally almost impossible to change an existing behavior in Git,
including the default behavior of 'git pull`, even if basically everybody
agrees the current behavior is wrong. That's just a fact.

-- 
Felipe Contreras
