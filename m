From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v5 6/7] Remove dead code which contains bad gettext block
Date: Thu, 26 Jul 2012 19:21:01 +0700
Message-ID: <CACsJy8BW+TUbY4yo0GqUvLrE0TivX=H+aqE+3tw=u0KZYyDtQA@mail.gmail.com>
References: <cover.1343205009.git.worldhello.net@gmail.com>
 <b22ea7d7306745555bfd39bf4ff51f485a005a02.1343205009.git.worldhello.net@gmail.com>
 <20120725113009.GA4732@burratino> <CANYiYbF9KsBeRsVV1RCD9k5KQFnf-9ubc-YLHLg+LjMSoPLVoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 14:21:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuN4U-00020O-DU
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 14:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758Ab2GZMVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 08:21:33 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:57678 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266Ab2GZMVc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 08:21:32 -0400
Received: by ghrr11 with SMTP id r11so1871890ghr.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 05:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1FkBv1R+fEIb4KeetvDbMA6/KFtFwDqsYT2hbT2uxO8=;
        b=HDkV050ZOniAPeguyatYQZYvxvgn4YLIL71Nv+H3QhF2pk8Ab4Nj/hIRdUTXI/tUbO
         w5u4oCkM83eubmMlgptGCX0Y9hAJrUHxSzHJxspkf1Nv45VNotdYtoBRPhPf7Y2lb1Rf
         e5QHvONWBvAaEMAPI7ouqCJhunwghuxV6v6ECp5EZ1VcVUp7jG57smCFH/U/lhUt2aaa
         VYp+Uj0i3NuTSsHXFwiBoUyp0WxCHVEFm2gsawj+Y4B9xMaKtP3E+Flz0H67jZm/YRjp
         0boUJZBU5t20e4jtN+6JQg5/nFQhc11UPV6Pn3julQqmcPwXkQNNvgou1IEJklj/96Lr
         3uIg==
Received: by 10.60.14.227 with SMTP id s3mr40779566oec.36.1343305291754; Thu,
 26 Jul 2012 05:21:31 -0700 (PDT)
Received: by 10.182.177.67 with HTTP; Thu, 26 Jul 2012 05:21:01 -0700 (PDT)
In-Reply-To: <CANYiYbF9KsBeRsVV1RCD9k5KQFnf-9ubc-YLHLg+LjMSoPLVoA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202257>

On Wed, Jul 25, 2012 at 8:31 PM, Jiang Xin <worldhello.net@gmail.com> wrote:
> 2012/7/25 Jonathan Nieder <jrnieder@gmail.com>:
>> Jiang Xin wrote:
>> s/Junathan/Jonathan/, please, unless you are trying to say that both
>> Junio and I pointed it out at the same time.
>
> Sorry. Correct it in next series of patches.
> I don't know how this happens until now.

I think it's nice. I can think of a few occasions to use this name.
Now I only need to train both of them to recognize their new name ;)
-- 
Duy
