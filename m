From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: gitweb-projects
Date: Sat, 25 Aug 2007 20:20:11 -0400
Message-ID: <9e4733910708251720x79e54ae3m69d8e4d1e5532a02@mail.gmail.com>
References: <9e4733910708231438q4c454686p55cef622e61d6a2a@mail.gmail.com>
	 <fal7gn$2vf$1@sea.gmane.org>
	 <9e4733910708231711o71aa3953i349bce96c5eee8f0@mail.gmail.com>
	 <200708240935.59089.jnareb@gmail.com>
	 <9e4733910708251716r1c131b0aka3014a6011b9ebd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 02:20:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IP5rV-0000nn-Og
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 02:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759125AbXHZAUO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 20:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756111AbXHZAUO
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 20:20:14 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:42291 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbXHZAUM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 20:20:12 -0400
Received: by wa-out-1112.google.com with SMTP id j4so1519459wah
        for <git@vger.kernel.org>; Sat, 25 Aug 2007 17:20:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lg2AX9dD097JIF4jJDHJUqPIK5dhFOHVTJZgfAGVzIkJharFq5hxiZzvCRAYbfjgsNBESgJCHEwFZB4xW/D5cNDWahTHBbTLT6XCaIvuLVF+1oPN8tDtRC0XGeSJ8EytYITppFLn3xKNf6hmPZifYS8wdr1JoAp7K4+qQTId/Wg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ouAd2B8AeOwZON1p69wVRt0W1DQQm4lxg0ntXavqI3m6FqqI3FDULjy83Ew3cfZ+HrC5kH6jHqmfpNfJBBiKv1BvnhXJ1DnwlEIrabyj41Hwx5dtUxK7qmHMEJEbIe6885QMYYz1MT2jBGXAFj0E/c8H+zJXeKBLtVR/+Wn0OZE=
Received: by 10.114.196.1 with SMTP id t1mr3031025waf.1188087611581;
        Sat, 25 Aug 2007 17:20:11 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Sat, 25 Aug 2007 17:20:11 -0700 (PDT)
In-Reply-To: <9e4733910708251716r1c131b0aka3014a6011b9ebd4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56664>

On 8/25/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> Another HTML escaping problem, I can't use an @ sign in the hometext.html file.

hometext.html is really a misnomer, it needs XHTML syntax, not HTML.

>
> --
> Jon Smirl
> jonsmirl@gmail.com
>


-- 
Jon Smirl
jonsmirl@gmail.com
