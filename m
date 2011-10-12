From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RESEND PATCH v3] Configurable hyperlinking in gitk
Date: Wed, 12 Oct 2011 22:07:28 +1300
Message-ID: <4E9558D0.60802@gmail.com>
References: <20110917022903.GA2445@unpythonic.net> <4E7467B7.1090201@gmail.com> <m3hb49sn26.fsf@localhost.localdomain> <20110922013101.GB26880@unpythonic.net> <20111011183722.GA26646@unpythonic.net> <7vfwizdvnn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff Epler <jepler@unpythonic.net>,
	Paul Mackerras <paulus@samba.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Marc Branchaud <marcnarc@xiplink.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 11:07:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDumq-0003T6-Au
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 11:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864Ab1JLJHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 05:07:30 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:34146 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab1JLJHa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 05:07:30 -0400
Received: by pzk1 with SMTP id 1so1104218pzk.1
        for <git@vger.kernel.org>; Wed, 12 Oct 2011 02:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8p51SI+ocHgmkwFAjU3eCQlqS70G2OtTlDB6G0PLQR8=;
        b=MC3H4H5GFgxx1dx5Qv727HIpMvlMu/+h4j13tSoYwEf0Rxien/m+AphqNOeiFJaHhD
         Ffg9GhnUlc0FAoGyiR7+CwRE4d4dPvl+TmU/G5NkpRIoBlPJkwK9lfu1lA/d0xZN2hXQ
         WuK1/k1Pw6y5IIFiiUY2yd2lHdznnIhiJP6xg=
Received: by 10.68.0.227 with SMTP id 3mr15712476pbh.48.1318410449579;
        Wed, 12 Oct 2011 02:07:29 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPS id ml4sm5605133pbc.0.2011.10.12.02.07.24
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Oct 2011 02:07:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.2.22) Gecko/20110907 SUSE/3.1.14 Thunderbird/3.1.14
In-Reply-To: <7vfwizdvnn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183362>

On 12/10/11 11:13, Junio C Hamano wrote:
> Jeff Epler <jepler@unpythonic.net> writes:
> 
>> I'm aware of no problems with this patch, and a number of people have
>> commented that it is useful to them.
> 
> Hmmm, "didn't generate any discussion" does not mesh very well with "a
> number of people are happy". Which one should I trust?
> 

For what it's worth I've (just) tested v3 and it works well for me.
