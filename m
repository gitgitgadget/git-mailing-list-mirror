From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: Re: git-notes
Date: Thu, 24 Jun 2010 22:36:54 +0530
Message-ID: <AANLkTimvCIQ-2lTtEvs94BuQvLerniIqdMaoUFKTZKLy@mail.gmail.com>
References: <AANLkTildVSt4cau9VhFePnmW057dQBEusCYKIk9NXgtb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 19:07:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORptF-0003Iz-F4
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 19:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314Ab0FXRG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 13:06:56 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44620 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab0FXRGz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 13:06:55 -0400
Received: by gxk28 with SMTP id 28so889676gxk.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 10:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=4yk2Nbb4zs+5TsK2tmlHvNf3D71nACZpT/UMoqFWMSI=;
        b=hD45yFG4dSP7JK/YRxyiX8qLQUWcLLt3Jv4LnAS2Q57YDHNARw+D9scDwKz427wmZp
         jIY5rDUvp4omVR/vuFPXeQUoMqh25ehYH5TAFCJ/alKcQJhnobbJtM4w8rrZPEEucQoq
         tqye3IHDTOo9KnYcMeYSi3erbYkU5j1bXOthI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=vhz6ZOWRK5/uKzvQ9jK4FYBc6NXPgssuXdSuEYlGi4yLNCuJh6Xiii7cH2UhHnR6Qt
         LZmS+7Zkan/phC3ypBVhzeSnwMiTXh4ll5fclXpQsXIZCaDUPlL916HeD9P91KVD4jFO
         pbDB5tiTJdbxMLRl5m5ZoEAJt7vq8lnlEFdy4=
Received: by 10.91.146.20 with SMTP id y20mr6019700agn.19.1277399214512; Thu, 
	24 Jun 2010 10:06:54 -0700 (PDT)
Received: by 10.90.25.8 with HTTP; Thu, 24 Jun 2010 10:06:54 -0700 (PDT)
In-Reply-To: <AANLkTildVSt4cau9VhFePnmW057dQBEusCYKIk9NXgtb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149605>

Git Rocks !! ;  I got it in man page

notes.rewriteMode  Config Variable !!


    When copying notes during a rewrite (see the
"notes.rewrite.<command>" option), determines what to do if the target
commit already has a note. Must be one of overwrite, concatenate, or
ignore. Defaults to concatenat
On Thu, Jun 24, 2010 at 10:23 PM, Mahesh Vaidya <forvaidya@gmail.com> wrote:
> How to Prevent git-notes removal / replacement by another user in master repo.?
>
> If I add "git notes" to my commit and Push it. How do my repo admin
> will ensure that notes are never overwritten or removed; but can be
> appended
>
> Thank You
>



-- 
Thank you and best regards.
Mahesh Vaidya  / 9740500144
http://www.twitter.com/forvaidya
