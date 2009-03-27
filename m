From: Geoffrey Lee <geoffreyj.lee@gmail.com>
Subject: Re: Problem Creating Commit Messages
Date: Thu, 26 Mar 2009 22:18:26 -0700
Message-ID: <83d7aaa40903262218m17866090iece805b454d4462@mail.gmail.com>
References: <22735968.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 06:20:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln4U6-0008Rp-CN
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 06:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755773AbZC0FS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 01:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbZC0FS2
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 01:18:28 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:27555 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802AbZC0FS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 01:18:27 -0400
Received: by wf-out-1314.google.com with SMTP id 29so1118236wff.4
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 22:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=pC5sz3zQubqI8IMYMRB9TMPsDD7bvSLdunDGsBNfMCI=;
        b=kCPESv1pmjjT/u11OK+34B3zgz/p7UNUGDMUec0cpr2GhtWrPEYSvT7wxaBt4242uN
         NQoDZTkzJSi0YJMh34Q+KABWfu8lXZcciIfuE/XEqAamk0DW9+6oKessYL47yvhEn8r0
         MCxrM/InbcBBJ7mh4g0vCz1A4gH3vosIZs0fs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=MXLSqpbANT6RY8tAvtrGes1kaOtjQ0zEs27Xev1DtuBOnClfDdrxAMLdQwxWGq4WxK
         XSsZluputtyHJ0rcFJvgMXzR/+9TqnS7m9BpiGCw/8TLdkvYJB3T4gcRbe3CS0IMYCCf
         DEF1ebFohboL82XgUhySK7TjtfhaTl0+UXWLc=
Received: by 10.143.156.12 with SMTP id i12mr715264wfo.320.1238131106203; Thu, 
	26 Mar 2009 22:18:26 -0700 (PDT)
In-Reply-To: <22735968.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114851>

On Thu, Mar 26, 2009 at 9:44 PM, bggy <balishaggy@yahoo.com> wrote:
> I am not familiar with VIM, can change modes, but none of the key combos I
> tried worked.

1) Press "i" to enter Insert mode
2) Type in some text on the first line
3) Press "esc" to leave Insert mode
4) Press Shift + ; (or in other words, the colon character)
5) Enter the characters "wq" without the quotes, and press Enter. ("w"
for write, "q" for quit)

-Geoffrey Lee
