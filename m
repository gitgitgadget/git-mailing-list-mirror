From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: git config file for sending email using gmail smpt server [was: Cover letter]
Date: Tue, 8 Jan 2008 16:09:35 +0100
Message-ID: <4d8e3fd30801080709q218613b4r785be7baa1e11f57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 16:10:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCG5f-0008Pm-IJ
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 16:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611AbYAHPJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 10:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754483AbYAHPJj
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 10:09:39 -0500
Received: from ro-out-1112.google.com ([72.14.202.177]:43155 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481AbYAHPJi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 10:09:38 -0500
Received: by ro-out-1112.google.com with SMTP id p4so2418021roc.5
        for <git@vger.kernel.org>; Tue, 08 Jan 2008 07:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=IkLKgiFLjZvQpS8zIVLOuAWC47JdzGeLiUM7ISyEFaU=;
        b=nqXr9jURcKoc4+CwL+biMcolXW3ZFnuNlla5kYQGd7bOYAyxurmcGwBHmMbhWG7DmQcM3cG/7qtJYEqYwiArZA1un6UIIbST+wyclYjOeeDmP95jfKHT7LOMunCqC6u6XACUaHxZ0DIYhX4co7og6aKcChTumRrsTrfwNRPf+WQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=D6rpMdKLd4H2OAdfqo8vyZPCZ7mPIOBS8AwnSXATg7qmTgpahCynreteZ2vAtuWlnEEtEwfjcrgYbgV69Wvb74IT1WwNJL+0ffFv2nPYCjMhBScH0uXNYJqNJxywfpfqPKzb6H8pRZUJ4MCF+D6fj+g2b3JQ42jEDwGU7/KT/Nk=
Received: by 10.142.140.14 with SMTP id n14mr258465wfd.192.1199804975222;
        Tue, 08 Jan 2008 07:09:35 -0800 (PST)
Received: by 10.143.162.9 with HTTP; Tue, 8 Jan 2008 07:09:35 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69882>

On Jan 8, 2008 2:13 PM, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
>
> On Jan 8, 2008 2:09 PM, Gustaf Hendeby <hendeby@isy.liu.se> wrote:
> > > This is working fine but since I'm going to push out a queue of patches
> > > it would be nicer to script everything with git-send-email.

BTW, would anybody so kind to post the configuration lines needed for
git-send-email to work with gmail's smtp server?

I guess a lot of people are using it so it would be nice to add a sample
conf file in the wiki.

Thanks.

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
