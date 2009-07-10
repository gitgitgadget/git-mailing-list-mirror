From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] teach --summary to stg show
Date: Fri, 10 Jul 2009 23:14:31 +0100
Message-ID: <b0943d9e0907101514u6140b577t2cd8e4e9f646817c@mail.gmail.com>
References: <20090619050653.GD21764@ldl.fc.hp.com>
	 <b0943d9e0907100311n26af2e86j95cae2200298ff68@mail.gmail.com>
	 <20090710185629.GA19324@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: kha@treskal.com, git@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 00:14:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPOMa-0007JP-VG
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 00:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756409AbZGJWOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 18:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755668AbZGJWOe
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 18:14:34 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:55203 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750AbZGJWOd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 18:14:33 -0400
Received: by bwz25 with SMTP id 25so1163624bwz.37
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 15:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=98ZwyYMKmXbMdkzkvzMI0Gv4/ZzhhNV2jwJswdyMSCE=;
        b=rFOJNiVa4q/G6UnZr+3CWeigkvNnGAAjzKAD+VUXIV078wP5V36EH7wxmWgL51tC6+
         K6vFbH535cdmxK0o7Jj0K8htXCfBtR/VXa4olUDvaRQT0DLJyRTS0RKb+PyjJ1000ic4
         UR9H6VyKL+SEYd9ZV2KCLTuxKMgi47e0Elx7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FuZM2xJu12I1rIk63L96pPqZMpQAUfBPTdtqt+fYOnbnINUhc5NKZqGilA7/UyuyFk
         z6or/lTE3A1Nn0mLZaay2XJzZCDdTGgi5IYlB7tr85beJ2niFfq9On8GWJ3Cq/mbX4yR
         vmmhEwRL9wNcM7Qj/eSGDoaQGkwe8JRSYe/p0=
Received: by 10.223.122.141 with SMTP id l13mr1390608far.99.1247264071712; 
	Fri, 10 Jul 2009 15:14:31 -0700 (PDT)
In-Reply-To: <20090710185629.GA19324@ldl.fc.hp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123089>

2009/7/10 Alex Chiang <achiang@hp.com>:
> [how about that other patch "fix stg mail %(shortlog)s order"? :) ]

I already merged it. Thanks.

-- 
Catalin
