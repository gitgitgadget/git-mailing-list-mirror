From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Cygwin + git log = no pager!
Date: Wed, 26 Feb 2014 10:41:18 -0600
Message-ID: <CAHd499DnDNu5N+Jiva_xfc2O5Gxxb=cogYN2YHtrSJDFEjtO-A@mail.gmail.com>
References: <CAHd499BT1Q308+q0NB9Dpx=ncQZwRn0tg=q_PE8RutaVqH+xQQ@mail.gmail.com>
	<53085434.4060106@gmail.com>
	<CAHd499AbsUwmA0HWu31jW2n8eUNnRtU7URKPfBU7EhU6-F48zg@mail.gmail.com>
	<530AFAFD.2060504@gmail.com>
	<20140224090618.GB10698@sigill.intra.peff.net>
	<CAHd499BDBgaAZFkoc=S9i9hG=NifAmqhaW86fqgkzjShZd07ww@mail.gmail.com>
	<20140226092610.GB32537@sigill.intra.peff.net>
	<CAHd499Co9Amdf_gWnY81dkRa2uDTH0fVM8HSb99VHhrb1AAKhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Chris Packham <judge.packham@gmail.com>, Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 26 17:41:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIhXw-0004k7-Du
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 17:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbaBZQlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 11:41:20 -0500
Received: from mail-vc0-f173.google.com ([209.85.220.173]:49644 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbaBZQlT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 11:41:19 -0500
Received: by mail-vc0-f173.google.com with SMTP id ld13so1190075vcb.32
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 08:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ed6qFoftMCMIDXPtOvO7vb6u7tq2tfMPLXwik/VKRtk=;
        b=iPEOU9caOwCfX7iMQWkwqvSoBCI0LlV9uDT5Z0KG7oL8xne9bh8WCM5kXlK5Q+GW2A
         DCZ0P+m4Or86vNaA4iUP86p2+45ljzM2GA+PJ32fxQL+1uJ/FnBsUOeihtbAu3YchEi8
         0LcwmlmRofP0w+qz998ZQNlyPdXvtF6TkXeTS9S87jlZL2o9ACK9LLvf91qUIRcMZbxE
         hXH6A7abyhp5QJsJPW/jF5QvhVg14sV5lBV/TUR2sg9WSivqoQtHV+n4HWJyY7bDD0it
         T4XlzYZS4ylXKINMbnZ+S4HqkR7x00zj6F2f1EcJyprsJr4grgexkzoANwOZycv9b1kw
         Nm3g==
X-Received: by 10.59.5.102 with SMTP id cl6mr682260ved.41.1393432879006; Wed,
 26 Feb 2014 08:41:19 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.49.68 with HTTP; Wed, 26 Feb 2014 08:41:18 -0800 (PST)
In-Reply-To: <CAHd499Co9Amdf_gWnY81dkRa2uDTH0fVM8HSb99VHhrb1AAKhA@mail.gmail.com>
X-Google-Sender-Auth: tf_PMkcH4vVY4xU1pSozF-gWY6s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242735>

Copying the patch from the email text results in corrupted patch,
something isn't quite right with it so it won't let me apply it.

Can you attach it as an actual file so I can try again? Thanks.
