From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Mon, 6 Apr 2009 01:06:06 +0300
Message-ID: <94a0d4530904051506x5cf7fa09o6b0168a4c440e1f8@mail.gmail.com>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
	 <7vmyausz3h.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530904051228m4e57ec90y810dded41f47e443@mail.gmail.com>
	 <7v7i1yrj3t.fsf@gitster.siamese.dyndns.org>
	 <7vzleuq3ci.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530904051341s7e8718c2uced945a16c26670e@mail.gmail.com>
	 <76718490904051355p2f92d445j860c56638118a604@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 00:07:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqaVE-0005Qk-Hd
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 00:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679AbZDEWGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 18:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752211AbZDEWGK
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 18:06:10 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:47078 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbZDEWGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 18:06:09 -0400
Received: by fxm2 with SMTP id 2so1650442fxm.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 15:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=M2w/Fl9UIhNSpwN+0rM82qjz9rjpCPaOxTVsBgOVI2c=;
        b=BfY3my2pAays3wZWvN0jIfZzIfWPXKP4PbIiR4cuhnByMl+G0dMfkUeIgwALUskws9
         sIiQ46oPtIvIA2u2JkbXpO4Tr2YtB4WeX/vQhDFF7u9unKhmzZqgpeoBbOmXKg4btWQE
         J1SRDms46JR+Qlpnt5rB5s7FacSA3dO65AfFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CKCt67hvz+qJq2b+zCksQgtX3ijQinbQ84FOZEwKnnoxwZSUGfaW5HOvUVNDOUzsln
         IFYe+cQM2XC5fg0cADm1q+ik+xmkJnBnNDBX7czKMXTUfF/Zwf1accLP/Th3buN3EhEr
         +7h3a/r/voYhu4JQhk6R7GPmjv4JBIONxFyO0=
Received: by 10.86.1.1 with SMTP id 1mr2617316fga.0.1238969166722; Sun, 05 Apr 
	2009 15:06:06 -0700 (PDT)
In-Reply-To: <76718490904051355p2f92d445j860c56638118a604@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115724>

On Sun, Apr 5, 2009 at 11:55 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> On Sun, Apr 5, 2009 at 4:41 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> == stage ==
>>
>> The word "stage" is used widely in the English language, and it
>> immediately evokes a theatrical stage. Generally, it means a different
>> (upper) level.
>>
>> In git it is barely used, mostly on the "documentation industry"
>> probably because it's easier to understand for most people (even
>> non-native-English speakers).
>
> Would an index by any other name smell as sweet?

Yeap, almost. Do you have in mind any other word that would fit?

-- 
Felipe Contreras
