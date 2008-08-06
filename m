From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH 2/2] tg-create.sh: Introduce topgit.subjectprefix config option
Date: Wed, 6 Aug 2008 07:08:57 +0200
Message-ID: <36ca99e90808052208p31889debgd7b468db2c34892@mail.gmail.com>
References: <1217963610-15195-1-git-send-email-bert.wesarg@googlemail.com>
	 <1217963610-15195-2-git-send-email-bert.wesarg@googlemail.com>
	 <20080805233930.GA1249@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Abhijit Menon-Sen" <ams@toroid.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 06 07:10:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQbHi-0002lk-C4
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 07:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370AbYHFFI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 01:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754338AbYHFFI7
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 01:08:59 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:10198 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbYHFFI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 01:08:58 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1703751wxd.4
        for <git@vger.kernel.org>; Tue, 05 Aug 2008 22:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WY7ami30aFerN1mpKm3J+Pvitf7qmGVCTEiHyAYYFi4=;
        b=aWOpIc5eJsaGfCktSecNhycqYnPf99L5oea8kPRM1lvXHpaW/2IHPoDdN5ek+8VQvh
         sf+MDA1e4fKu1Qosi8rUGPbp35CPhx0KWGkIVXIz7i56lZxUsoNixGu0URA7YIVxheF6
         w/7pTlh1uOZrz2yJ/kmTqbok62gle/gE2TgzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rJWV4JyM+CCyx8TLBcZupr0cFcf1W7jPIHHBu59jroYRFKP+5Cep70Y7zYBeGvo5pk
         7YrSlvSgk7g5X+Lfkaku6HfJ67QyNuuIiBA6c3dXr4JH37De3nvYoXuiVDn7Q/5gpT7M
         b1owgw0vxO7sv/lXKzzGt8yZX4y45cJ0ZjHYc=
Received: by 10.70.77.2 with SMTP id z2mr2303512wxa.76.1217999337253;
        Tue, 05 Aug 2008 22:08:57 -0700 (PDT)
Received: by 10.70.28.18 with HTTP; Tue, 5 Aug 2008 22:08:57 -0700 (PDT)
In-Reply-To: <20080805233930.GA1249@toroid.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91482>

On Wed, Aug 6, 2008 at 01:39, Abhijit Menon-Sen <ams@toroid.org> wrote:
> Hi Bert.
>
> I'm wondering how you managed to get two To: fields in your patch mail.
> Is it a git-send-email bug, or did you do something special?
Yeah, I noticed this too, I have a To: line in the mail file, formated
from tg patch, and than send it with git-send-mail with an --to
option. without this option git-send-mail has asked me for the
recipient.

Any help would be appreciate.

Thanks
Bert

>
> -- ams
>
