From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Thu, 24 Jul 2008 13:46:23 +0200
Message-ID: <48886B8F.6000304@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <7vsku1gqny.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 13:50:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLzI8-0002bG-JG
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 13:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbYGXLq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 07:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbYGXLq2
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 07:46:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:28190 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbYGXLq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 07:46:28 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1052528nfc.21
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 04:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=WAvkc2NcvHw4ZbkbhTE2Y4LzrYSKD04Xn3bM7pVX1XI=;
        b=SqODZBaMUo298jy52RLH5+ZX/WXkMAfFIrKeQMNt4fsOnd9whR0W6v/YsKP0Gg53hH
         Xt4ThZ5o511GrSnNaXfya36q/Xe/chPpi47K3x7BKXtkh+DkNwpmB25gRrwFHcKNFPf5
         oOl+oo8nYdFq3+lvKVRt+qyCdnoEZWcYT99EE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=MhraRJNM2LgVdlOAus9BXIgOR0FGCVitVcNMI/enfy7CCMrxSEXvGW8Nng6fTsvfKZ
         7mT62qEzZj5R+QLvhTByqbMZVNdwpvaLIyffM8ZXxoSjjViFEc6osuqER7/TTskcmny5
         hqJcpEHd60zE3jS4DXnjJvBVxgkLdMm7HH6X4=
Received: by 10.210.141.4 with SMTP id o4mr195831ebd.154.1216899986471;
        Thu, 24 Jul 2008 04:46:26 -0700 (PDT)
Received: from ?192.168.1.167? ( [150.254.6.130])
        by mx.google.com with ESMTPS id h6sm24079914nfh.29.2008.07.24.04.46.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 04:46:25 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
In-Reply-To: <7vsku1gqny.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89868>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> (...)
>   
>>    27. Which of the following features do you use?
>>        (zero or more: multiple choice)
>>      - git-gui or other commit tool, gitk or other history viewer, patch
>>        management interface (e.g. StGIT), bundle, eol conversion,
>>        gitattributes, submodules, separate worktree, reflog, stash,
>>        shallow clone, detaching HEAD, mergetool, interactive rebase,
>>        add --interactive or other partial commit helper, commit
>>        templates, bisect, other (not mentioned here)
>>     
I've got lost a little bit in this discussion, but some question about 
used GUI for Git maybe interesting - the above one is touching the 
problem. Just egit is missing there.

(...)
>>    40. Do you read the mailing list?
>>     -  yes/no
>>     
>
> Which mailing list?  Do we want to ask about alternative lists?
>
> I am not sure how and where, but I think j/egit should also be
> mentioned and/or asked about.
>   
There is no separate mailing list for j/egit, we just used private mails 
for some discussions/less important notifications.
