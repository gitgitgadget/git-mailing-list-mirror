From: Filip Navara <filip.navara@gmail.com>
Subject: Re: git-mailsplit and TortoiseGit bugs
Date: Tue, 23 Jun 2009 10:13:42 +0200
Message-ID: <5b31733c0906230113u518cbd96t4ab825d83eafbe8a@mail.gmail.com>
References: <5b31733c0906221053k4b2659bev1da861b8e997eb5f@mail.gmail.com>
	 <20090622202939.GA11912@sigill.intra.peff.net>
	 <5b31733c0906221446m1a82b39fkd5d25ea413697138@mail.gmail.com>
	 <1976ea660906221826lfc074c2x6231dcae16535a9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, tortoisegit-dev@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 10:13:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJ18a-0002tr-Vz
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 10:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbZFWINn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 04:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752169AbZFWINl
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 04:13:41 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:46606 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbZFWINk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 04:13:40 -0400
Received: by ewy6 with SMTP id 6so5364056ewy.37
        for <git@vger.kernel.org>; Tue, 23 Jun 2009 01:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0VeSMYubRptljxiE6Wr1ku3aoM9aMHat/qGjSTKFTTM=;
        b=n1T2l5kGUd4vEV/V/+B/i/n+Q2C6lH/9YCyb6xYebShXHaVx+8KP4Qoby3B7o4j/TI
         U7gfAmzd96uy37VftY9umn5uTzNpO9C4tIq2Em/bnCzqCxPi5MmUGcuAGP+8k6tdmCHl
         d+Gq+vnlLZoKWOqxub1auwXIRzuhSQVD+aExc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YLzMEMU82i9XXKpqmAaxQLzn9LRXpqDWXiBBrvlr0GhG3IQskH8RwnpdW4tXO3G44I
         NinMz+D3KyfST4u6yosnnfUjfQ98IKmNtmQUdyBh18ILBzIIr5rHERmyz11BsXO7qIVW
         dBqes+gsoErR4GVhl1p+lD5P4xG1xmcFLHzcY=
Received: by 10.216.23.72 with SMTP id u50mr2633456weu.178.1245744822623; Tue, 
	23 Jun 2009 01:13:42 -0700 (PDT)
In-Reply-To: <1976ea660906221826lfc074c2x6231dcae16535a9c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122080>

On Tue, Jun 23, 2009 at 3:26 AM, Frank Li<lznuaa@gmail.com> wrote:
> Do you means I should remove "boundary=WC_MAIL_PaRt_BoUnDaRy_05151998"
> when send patch without attachment?

Yes, it's meaningless for text/plain mails.

>
> Tortoisegit bug report:
> http://code.google.com/p/tortoisegit/issues/list
>
> best regards
> Frank Li

Best regards,
Filip Navara
