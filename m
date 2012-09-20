From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH] Improve legibility of test_expect_code output
Date: Thu, 20 Sep 2012 17:57:54 +0100
Message-ID: <CAOkDyE9hvBz5wYbj+q=oYTz7zWnP2E9dqtKZ-V=6jBW-FomfbQ@mail.gmail.com>
References: <1348094310-11214-1-git-send-email-git@adamspiers.org>
	<7vboh1eew2.fsf@alter.siamese.dyndns.org>
	<CAOkDyE-x5NeZX2tpp3C9Kkwb1kPniHptB9ERvtpx2XODufaW=A@mail.gmail.com>
	<7vtxusbpub.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 18:58:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEk4j-0007en-Ii
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 18:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418Ab2ITQ54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 12:57:56 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46375 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab2ITQ5z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 12:57:55 -0400
Received: by bkuw11 with SMTP id w11so356840bku.19
        for <git@vger.kernel.org>; Thu, 20 Sep 2012 09:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Z5ncK8zImT5h9k3fVnCugLenvGOFoTnRmKJmceLq/tI=;
        b=uNET0J9hmHSjfps1iugeV60y+Kf5BVAJycPglUd+yuubqNcChIX+YR8j8P5AZYe2fM
         0ahpPImGGOETASe9KbGpop1m0mdl4GFT09lTkocbQ5pRiY+/sGyuO5li1kEN7uhH75ua
         5Uy9AFnlT8NC0D+Lwzmq6T5MvcQjiVcNAj6njskz4deyQmL6UZ5aw0LrNhko/ICXzABg
         Ov5ac+HJ7nWx+wlEbS2uTBgWLFQ7jDasLgLOGQcZvgS1ZLBzw9GXCfX0vjFyi+ynVzx7
         C9dv3XTB1fDh6LEkD14xcSPAvnYsnoMcUpZ4gmArsuCaIrrFjvMp+TJzKRZFFwBfkjcr
         esZQ==
Received: by 10.204.136.215 with SMTP id s23mr1026817bkt.32.1348160274272;
 Thu, 20 Sep 2012 09:57:54 -0700 (PDT)
Received: by 10.205.81.80 with HTTP; Thu, 20 Sep 2012 09:57:54 -0700 (PDT)
In-Reply-To: <7vtxusbpub.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: Go1HqtjXX6JzhExWJM9Sr5FVTGs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206056>

On Thu, Sep 20, 2012 at 5:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Do you want this queued on top of your other series, or as an
> independent change?

Independent please.
