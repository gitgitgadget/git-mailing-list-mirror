From: chaitanya nalla <nallachaitu@gmail.com>
Subject: Re: Testing JavaScript code in gitweb.
Date: Sun, 20 May 2012 15:30:21 +0530
Message-ID: <CACeyogeMi4K-+j8pR0yKWeeJ1nu1Mca2Y+OPAetK-07cYFQKQQ@mail.gmail.com>
References: <CAH-tXsDif9YOrkEcj7AdRfn6gvLx4mj4+SKCB4GzyW6QJpx=9A@mail.gmail.com>
	<4FB8BE7C.8050306@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: jaseem abid <jaseemabid@gmail.com>,
	git mailing list <git@vger.kernel.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Sun May 20 12:00:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SW2wO-0000cy-NJ
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 12:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375Ab2ETKAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 May 2012 06:00:23 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48024 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782Ab2ETKAW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2012 06:00:22 -0400
Received: by obbtb18 with SMTP id tb18so6491578obb.19
        for <git@vger.kernel.org>; Sun, 20 May 2012 03:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=v2q35Ag4lL+Bdt1SPUvVlrHS1MUgS4ZhjFuAUqZOS+A=;
        b=ECgIWwEszNJgwsilk78YxEd4/rOsWbh0y5wkspKOX4WnHxn40wTqUvH9bdF7Ly1LWw
         XV4wUvWLyk2izjHT0y+iSqb43RP85PpO+FmmqfErKj1WQqaLR17thV1kEKaQPzuFn8b6
         gIM9Zrd2Ye2p+aBWT/uq1FnEqzDqCB9XbWd0wN1pxfGtOzQ+ISdHJTI6O/39XU26FJg3
         3+aWyrVQ7jLrsHXskdhduHTrQIgEwaD5n2MBBnogSTQzn3VTTBMlCYzVFk5PLmEiR9ZP
         rz5jGze8egicUYLPpnPyDxLYQ8PzI3HYTawSyP59/OWn95ClIpE2G+0+Loj08saOuTp2
         a+9g==
Received: by 10.182.47.105 with SMTP id c9mr16119476obn.49.1337508021681; Sun,
 20 May 2012 03:00:21 -0700 (PDT)
Received: by 10.182.81.103 with HTTP; Sun, 20 May 2012 03:00:21 -0700 (PDT)
In-Reply-To: <4FB8BE7C.8050306@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198055>

Hi,

Even JSTestDriver has the feature of code coverage. Here is the link
:http://code.google.com/p/js-test-driver/wiki/CodeCoverage

JSCoverage also works great in my opinion.
