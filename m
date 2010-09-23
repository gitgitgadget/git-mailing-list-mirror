From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Improvements to `git checkout -h`
Date: Thu, 23 Sep 2010 20:05:03 +0000
Message-ID: <AANLkTi=LBzJWGuqtqJT1eUtmQqFTj8jixxB=hONTh+mi@mail.gmail.com>
References: <AANLkTikra1iE5JpXvvPnNcwE=XEDF6B=ubCteEi77dqX@mail.gmail.com>
	<AANLkTikjqW5R4p90T3pWACPG9vGqd4uRETiE-Wb_BybS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Knittl <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 22:05:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oys2Z-0001yq-QQ
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 22:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233Ab0IWUFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 16:05:04 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49922 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016Ab0IWUFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 16:05:03 -0400
Received: by iwn5 with SMTP id 5so1685678iwn.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 13:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Ee9Di/lO1jt3f32TUZIaBKVk1MldrmYjWJtx1WeHISs=;
        b=bZiAJBSp7W2fguyAMcntIdKXVb1ZmQPVV9rFTaCoo1WmJZ66HYM2zeVHDo3+vjLZa0
         iRuh43jMvg+fm2iHS2vWAlnvmiJylY4/revQ3IWR1aEPKuYOmXb2dMk48jBoA1JGYWH7
         S6UDrlYHaM8cXj38cH+mMnP8Sfw/zLgvaUYm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=U5bPLDW1hG2n0TF3H6GSxU3hj+emEuKS82+N6x8vkH6pdWhhrnEu4PzwLIRzg2UIlb
         Er9Ks+ihn+Ht0xEjWoWk3qfjK0wEWht0zks1A9120C+w1jVOpUCGoYJDGXbiP2Nv5fda
         MMBbq99+dFt+7XEpNbN3mJv5UaQjE+WcCypHs=
Received: by 10.231.33.137 with SMTP id h9mr2061177ibd.91.1285272303151; Thu,
 23 Sep 2010 13:05:03 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Thu, 23 Sep 2010 13:05:03 -0700 (PDT)
In-Reply-To: <AANLkTikjqW5R4p90T3pWACPG9vGqd4uRETiE-Wb_BybS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156899>

On Thu, Sep 23, 2010 at 18:26, Knittl <knittl89@googlemail.com> wrote:
> any thoughts on this one?

Hi and thanks for patching Git, but could you please submit patches as
detailed in Documentation/SubmittingPatches ?
