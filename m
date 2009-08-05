From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/6] Teach --id/-d to "git status"
Date: Wed, 5 Aug 2009 11:25:43 -0700
Message-ID: <fabb9a1e0908051125m3eecb065m5fb4ea2b55f69b91@mail.gmail.com>
References: <1249465906-3940-1-git-send-email-ayiehere@gmail.com> 
	<1249465906-3940-2-git-send-email-ayiehere@gmail.com> <81b0412b0908051111g4433e12epa540e0a2f07b62b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nazri Ramliy <ayiehere@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 20:26:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYlBo-000513-HD
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 20:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbZHES0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 14:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbZHES0H
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 14:26:07 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:56752 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbZHES0F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 14:26:05 -0400
Received: by ewy10 with SMTP id 10so202646ewy.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 11:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=joHXX3f8gtUhC01d+MIHg1Qzoaf4IaI2qF4QgDoJZSo=;
        b=KxB/CSbu7RCgGMyFHFfktlXI0RrKdWG8M29/M9IpQ9Z9NluPVyMBLhdknhm1dhRJI4
         vNH/T63FNCuQFSG9RYoDU0GJ/CTW4E64TFATVDVZRgD+EqGGswEpKXkjxUZdJMlh107V
         HkT3EQ7XKPUI4SgQt2fs2Cs6oN8rlFeHCwWEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=eGhoaW6biduoF1ibmOmdRrukiKvF7nrnYMhUdMvYbtAb1FecoVk57I6HNL8MIESekR
         8mC8zCHhj5HpYHTbxnEaJWtvTmASTxmCA4a0zOUvkhFY6RKqVXGJsXqxvCQu141iS7UI
         9HADGfr1lzc68JkrB38dA7g8U+LXhKYwkV/Qs=
Received: by 10.216.20.67 with SMTP id o45mr1921972weo.106.1249496763294; Wed, 
	05 Aug 2009 11:26:03 -0700 (PDT)
In-Reply-To: <81b0412b0908051111g4433e12epa540e0a2f07b62b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124943>

Heya,

On Wed, Aug 5, 2009 at 11:11, Alex Riesen<raa.lkml@gmail.com> wrote:
> What is it for?

See [PATCH 0/6].

-- 
Cheers,

Sverre Rabbelier
