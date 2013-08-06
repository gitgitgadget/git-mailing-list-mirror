From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG?] gc and impatience
Date: Tue, 6 Aug 2013 08:29:54 +0530
Message-ID: <CALkWK0krAnVOx5c5-TT_k5NDfKm+cEft+xQUDSq+TLDm1r6-5Q@mail.gmail.com>
References: <1rpxs5pa827iefbyduyodlc7.1375495435629@email.android.com>
 <CALkWK0=djXdPMOvk8359nOs=rGLbBepxyXnpELfWs+wjjN7YZw@mail.gmail.com> <201308051245.07995.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin Fick <mfick@codeauror.org>, Git List <git@vger.kernel.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Aug 06 05:00:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6XVn-000293-Aj
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 05:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769Ab3HFDAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 23:00:35 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:53910 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700Ab3HFDAf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 23:00:35 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so7935835oag.38
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 20:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=J9EbrSysV3JTIR4aou4XnyiNudpTskyk2qmp5TtIfeY=;
        b=hUL5f5VIXyb+3ekPiIV7mgBJcg/DbFz90h2gmAep1YrteBF6bbqhEQqmh2KWj+P8g+
         u9IQ5Kkqcp1FbCHqUygrf9PJfzBD4J1rC1isVBsJlo3pkVRgmAdQXUUlAgXlC4gLC1SM
         PXAzZMYNWYkYhh/Gp1TfwOdrCoqv8VtIEiLeHOL2AbOTtCjPkVDSw9RDJ1aGRZN4Njz9
         yxzI0e8VkqvKgfvu8NCM9Nawj00BeMKfUsUyPkKIdroYIRcktP7LKR9s7E1qvA9kDnKV
         9Ue4WFP0cwFQT0YY6R+KTkc0UNXvYQ7ah3eTYQGvK+vWMmEk6dVv31bm4gmNfhPbJfGz
         vktQ==
X-Received: by 10.42.76.5 with SMTP id c5mr1986925ick.91.1375758034587; Mon,
 05 Aug 2013 20:00:34 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Mon, 5 Aug 2013 19:59:54 -0700 (PDT)
In-Reply-To: <201308051245.07995.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231712>

Martin Fick wrote:
> I hope
> that someone more familiar with git gc than me might take
> this on some day. :)

More likely scenario: someone who is unfamiliar with it will read and
patch it little by little :)
