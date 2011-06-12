From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2011, #02; Sat, 11)
Date: Sun, 12 Jun 2011 17:44:39 +0530
Message-ID: <BANLkTinHCX0vmAdk+su-_Y0th9vLQ6qsnw@mail.gmail.com>
References: <7voc23sfxd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 12 14:15:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVjZM-0004OG-3r
	for gcvg-git-2@lo.gmane.org; Sun, 12 Jun 2011 14:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352Ab1FLMPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2011 08:15:03 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61542 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab1FLMPC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2011 08:15:02 -0400
Received: by wwa36 with SMTP id 36so4052964wwa.1
        for <git@vger.kernel.org>; Sun, 12 Jun 2011 05:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ZNdfg+TZg2Q4QUzbAyUlBmaQLiEIwTB00eD+evJZsRc=;
        b=pNryOUdOZ0RSix68LAHT/pTQAapN1WIrLhotDr3seuH7E8dC7gcj4iKQv7rooeu4Co
         L5/rQvyA5rrb/jRx/pwR7OkVkVuu3ehrVj8kx8C4a6wvHcvTMdbaHcgC6iXbggNxLcrW
         IPHWLYaTCJGzsAi2xW69FBMa4ZpajmlgIyYXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=U2UoGWkXVsiVNmWb1lBpkFr4rLWnoVeLCblXEQ34Vdc7oYrNUZlGaObuhXPeVUfNLs
         YdjBjzwCvwNox8eKmZ0y/o72qiRu82OjviLg27++r0lb5YP06DKQg5PtnQZekhdh86Jp
         gNQg7RkdMLfWcx5llttSFylfbIbxoiu1NsOTU=
Received: by 10.216.232.13 with SMTP id m13mr1493578weq.110.1307880899115;
 Sun, 12 Jun 2011 05:14:59 -0700 (PDT)
Received: by 10.216.1.20 with HTTP; Sun, 12 Jun 2011 05:14:39 -0700 (PDT)
In-Reply-To: <7voc23sfxd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175656>

Hi Junio,

Have you seen my "libify reset" patch [1]?  I thought it was an easy candidate.

Thanks.

-- Ram

[1]: http://mid.gmane.org/1307772613-30775-1-git-send-email-artagnon@gmail.com
