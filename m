From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/5] fc/transport-helper-sync-error-fix rebased
Date: Sun, 20 Apr 2014 16:54:27 -0500
Message-ID: <53544213e6635_a81169b2ece1@nysa.notmuch>
References: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
 <1397890843-27035-1-git-send-email-gitster@pobox.com>
 <535413cbc7eaa_1f08dd12eca5@nysa.notmuch>
 <7voazvlna8.fsf@alter.siamese.dyndns.org>
 <535438246097c_4c30158d2ec11@nysa.notmuch>
 <7v7g6jllck.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 00:05:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbzrB-0006bu-VC
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 00:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbaDTWEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 18:04:50 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:49598 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbaDTWEs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 18:04:48 -0400
Received: by mail-yk0-f180.google.com with SMTP id 19so2900225ykq.11
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 15:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=qwTLcNjI8C+AaQaCPPzslDSYfvIAGRxrhtzlr0o1rKE=;
        b=TXGW5aqCd71NQLeqIKuv3dlmpgQAjSC8I8DSztngKpZlp5zbaB5O17ElL4u0K1jzR8
         yp8vrMdEqe54TtRPKnOihr6ETUFTK4cdf+ZPhU32Dg6CXmdeGYFx8uk7NXQltBoXIB7e
         XxeK5Y+5BJcUBWzVVqtHUvi5BIGJAWZ82TrAVvs10bPi0c/6VRaYRwNWt3fMZvNJENrF
         RT/+1vnnwghY82/IDsynP+TtxiweFt9UH9QI/OoIETB+370gYI7J7Xx6oH9mKaXfNmB7
         lphT7+6SuvGM0NbXFUU7lgZB2FjNUeMM6j3Hja1Xxwe8z7gHDDcyQyHS3jfvRrDgovwv
         6kmQ==
X-Received: by 10.236.21.241 with SMTP id r77mr48362966yhr.7.1398031488051;
        Sun, 20 Apr 2014 15:04:48 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id t66sm25619302yhc.45.2014.04.20.15.04.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 15:04:47 -0700 (PDT)
In-Reply-To: <7v7g6jllck.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246593>

Junio C Hamano wrote:
> So I think it is better to quote these in this particular case.
> 
> The pipe is purely subjective readability. I can go either way, but
> since I was the one who was applying the patch that needed other
> changes anyway... ;-)

You started by saying these were "not the matter for your liking or not
liking", and now you are explaining why you like one better than the other.

I don't think it's particularly helpful to criticize one person's preferences
because they don't match yours.

You like one, I like another. That's it.

-- 
Felipe Contreras
