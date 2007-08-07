From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Bootstraper for Git Dev Environment for Windows (Light version)
Date: Tue, 7 Aug 2007 16:18:18 -0400
Message-ID: <fcaeb9bf0708071318r28397a32v685b672b0fb677a2@mail.gmail.com>
References: <2B8D8540264E4205BD1E4605770422BF@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 22:19:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIVWa-0004tw-6g
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 22:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290AbXHGUSU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 16:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755058AbXHGUSU
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 16:18:20 -0400
Received: from el-out-1112.google.com ([209.85.162.182]:37573 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbXHGUST (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 16:18:19 -0400
Received: by el-out-1112.google.com with SMTP id j27so367933elf
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 13:18:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EEv7k7yeLQ9vWqM9fTWdN2AqmI2OODhX0r0Qrk3ffAf1hrFYIU3o1OU7MXfkCVniNPLVJZ6GRcKJaovseTIm5etkIaPCfPbp0yjUFmyTYsy0NJS/cDhpZ11l902nrXDghyLxKnauPB5tkkyMwvLaOy1tKgkAbEFF3jSmYnwDizs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CrKaESGy32rZ0IQPx+wRkHnRwqiEAD4Scon/0gI84ibu1gE5fQWqmBxgFmxrqqwWTGee6efQfieM0zegvzsMf9L0DshMcvGzhNbqfvkMfTpsHtvnsX2Vj+jbWrLTs6as7i/ePUxO4tzPjG7/HSRGSioHk+IeOng4AvVdRDw7+GM=
Received: by 10.100.121.12 with SMTP id t12mr4153214anc.1186517898389;
        Tue, 07 Aug 2007 13:18:18 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Tue, 7 Aug 2007 13:18:18 -0700 (PDT)
In-Reply-To: <2B8D8540264E4205BD1E4605770422BF@ntdev.corp.microsoft.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55273>

On 8/5/07, Dmitry Kakurin <dmitry.kakurin@gmail.com> wrote:
> Please give it a try and tell me how it works for you:
> http://msysgit.googlecode.com/files/GitMe-1.exe (1.6 MB)

Sorry, can't help it. After making more commands built-in and
stripping all executables, I can make a 1.4 MB zip archive containing
a (mostly) functional git! I bet no other SCM can be that small yet as
powerful as git. Thanks git team! (Okay, rant's over)
-- 
Duy
