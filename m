From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] builtin-branch: be prepared for ref-logging
Date: Sat, 3 Feb 2007 21:38:56 +0100
Message-ID: <8c5c35580702031238i612acda0p26aba8e3df747b1a@mail.gmail.com>
References: <11705213662728-git-send-email-tutufan@gmail.com>
	 <11705277471962-git-send-email-hjemli@gmail.com>
	 <7vr6t73tsi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 03 21:39:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDRf3-0004tK-Nx
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 21:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbXBCUi7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 15:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbXBCUi7
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 15:38:59 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:44377 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbXBCUi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 15:38:58 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1645415nfa
        for <git@vger.kernel.org>; Sat, 03 Feb 2007 12:38:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=at19PqA4GUw9MVwjETDcloorr39QI3+Pi9ieM7OiklOMqChC1q/n4JLZhsA1YDrGTDwaaZCG+0hgsqZIrUz9zyJTE0/9Tah0usFxiQUVLvhgjeSexhzrf0quoFEH4cydoqT0IojlfGyOrX61ZqspUUwtffNxsix6zDwXwgyxi4w=
Received: by 10.82.107.15 with SMTP id f15mr1697876buc.1170535137010;
        Sat, 03 Feb 2007 12:38:57 -0800 (PST)
Received: by 10.82.158.7 with HTTP; Sat, 3 Feb 2007 12:38:56 -0800 (PST)
In-Reply-To: <7vr6t73tsi.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38596>

On 2/3/07, Junio C Hamano <junkio@cox.net> wrote:
> Funny thing is that I thought I fixed this already

Infact, you did:

  http://article.gmane.org/gmane.comp.version-control.git/37197

Don't know what happend to this one...

-- 
larsh
