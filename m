From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: document git blame --no-follow and git diff --no-follow
Date: Sun, 11 Aug 2013 12:30:08 +0800
Message-ID: <CAHtLG6Q=XRVEhLKxSZUi3JM6w638ZSCpM84peW3RqE9a_=tE=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 11 06:30:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8NIE-0007ky-QB
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 06:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843Ab3HKEaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Aug 2013 00:30:10 -0400
Received: from mail-vc0-f195.google.com ([209.85.220.195]:63575 "EHLO
	mail-vc0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749Ab3HKEaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Aug 2013 00:30:09 -0400
Received: by mail-vc0-f195.google.com with SMTP id gd11so918886vcb.10
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 21:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=eRA9P+adVzGtXBulGo7hcKZFfRcTfEhpDnjB2tnfHIE=;
        b=joUd9ELISsH1h8O2rKZ8iHkV3pOKWyNd0xkbYTpewAll8duAIm7YJz9LzjgBkRQCj3
         tr98RbWi3WeaWUAhM7MIp8kcQTZI1MRckhgRXkjwrg/TeyuRBquuuvo1wDm3uqTufXDy
         qP+jdIOHvpZcoLL0T6Ofo/laQATvuaQeKYQV6kUYxdDyX2xzlQ5D8MpLPSvGxsggsnSy
         805eTqdXjUsFfZ3JuWUwpDVM8y3ANaT6q4aJFBIhPmIabIiIv5CvzIT/9X1zDbmgF8tA
         xFuX97xx6GjCqD3k7+UN3Fb7M9C9Vya3O/sxvi4OpBVOo9NUG/droHWLt8hLVMt57YZV
         Chlw==
X-Received: by 10.52.232.165 with SMTP id tp5mr7686761vdc.11.1376195408615;
 Sat, 10 Aug 2013 21:30:08 -0700 (PDT)
Received: by 10.220.226.194 with HTTP; Sat, 10 Aug 2013 21:30:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232119>

Hi,

Please document git blame --no-follow and git diff --no-follow

Regards,
ch3cooli
