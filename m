From: vishwajeet singh <dextrous85@gmail.com>
Subject: GIT smart http vs GIT over ssh
Date: Tue, 31 Jul 2012 08:36:07 +0530
Message-ID: <CACbucKnj5tqtAX5tJRRp+O8MA=tMD_xESsREPcAwffNS6Kvfag@mail.gmail.com>
References: <CACbucKmOxKLpY-iHDpX3GJ7BGsipR9hhXm8UA1hdbNdCzNMMRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 31 05:07:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sw2nl-0002oT-18
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 05:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810Ab2GaDGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 23:06:31 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:50201 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754123Ab2GaDGa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 23:06:30 -0400
Received: by gglu4 with SMTP id u4so5614739ggl.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 20:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=lgbrEMrqOL9JBVJR6Z13W4vjuxkw8SBoN77Bx3odxR4=;
        b=ZmkeL1AUe9SzEYWcx6fs4zorbtAXn5dl6xfQbS8+cVHh5G2sZU1gqQw56YYZoW0E0b
         kz2O0Z/cxMHnnXvE1LttKcx1jtc+mLieWFxLVd7KpZvwa2T6xcHgF0T5Kulcdw7J1nQ4
         dzi+K0bA+na6glDsHKyAPLTp41v9G1d3Ubo/VUlQIDzVqbeadvlq7HJ8mhWzBde9IwTj
         NeysEZyTZIh/pN+V4jFoq9wyshE1xI0+DrqjhuM7rIkJ486aoZe5+eDolXTwGrq7nZuY
         798AWQrhWbiDJYVSHahFlwRQDAnVbutrPJ+x34OtjX8gv0Jb9l5hzuatXjBsTOWJNKnC
         AMFA==
Received: by 10.50.6.229 with SMTP id e5mr803503iga.9.1343703989123; Mon, 30
 Jul 2012 20:06:29 -0700 (PDT)
Received: by 10.64.15.70 with HTTP; Mon, 30 Jul 2012 20:06:07 -0700 (PDT)
In-Reply-To: <CACbucKmOxKLpY-iHDpX3GJ7BGsipR9hhXm8UA1hdbNdCzNMMRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202626>

Dear All,

Just wanted to know the difference between smart http and ssh and in
what scenarios we need them
I am setting up a git server,  can I just do with smart http support
or I need to enable the ssh support to use git effectively.
As I understand github provides both the protocols, what's the reason
for supporting both protocols.


Regards,
Vishwajeet Singh
